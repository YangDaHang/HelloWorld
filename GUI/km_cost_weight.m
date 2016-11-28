function [data,result]=km_cost_weight(range)
tic


%energy consumption per km in[Wh/km]
energy_consumption_pro_km = 160;
%Average Vehicle velocity in[km/h]
speed=50;                                                                  %x=round(E_bat1/1000-24); %index
%nominal capacity of single battery in [Ah]
c=3.1;
%nominal voltage of single battery in [V]
u=1.6;
v=10;

for E_bat1=25000:1000:40000 % for E_bat1=25000:1000:30000
%  E_bat1=30000; 
%For different SOC
num=E_bat1/1000-24;
data(num).E_bat1=E_bat1;
 
for soc =0.1:0.1:1
    %index
    n=round(soc*10);                                                       
    data(num).SOC(n)=soc;
    E_bat1_rest(n)=E_bat1*soc;
    %remaining driving time within the rest part of bat1
    t(1,n)= E_bat1_rest(n)/energy_consumption_pro_km/speed; 
    %demanding discharge current within the remaining driving time
    I_rex(n)=c/t(1,n);
    
    if I_rex(n)>3
       I_rex(n)=3;
    else
       I_rex(n)=I_rex(n);
    end
    
    %According to non-linear regression relationship between I and E to get
    %the actual energy storage in single REX cell
    e_rex(n)= 1/(0.216+0.0479*I_rex(n));
    %time spended until the REX is empty
    t(2,n)=e_rex(n)/I_rex(n)/u;
    data(num).rex_dr_range(n+1,1)=I_rex(n);                                              %I-rex from big to small
    data(num).driving_range(1,n)= soc;                                               %soc
    data(num).driving_range(2,n)= (E_bat1)/energy_consumption_pro_km;                %bat1_km
%For different dimensions of REX
    
    for cell=1200:100:4000                                                 %different cell of REX
        m=round(cell/100-11);                                              %index
        %dr_range----range_rex(cell,I_rex)
        data(num).rex_dr_range(1,m+1)=cell;                                              %cells from 2000 to 4000
        data(num).rex_dr_range(n+1,m+1)=(e_rex(n)*cell)/energy_consumption_pro_km; %range for different numbers of cells
        data(num).e_rex_tot(1,m+1)=cell;  
        data(num).e_rex_tot(n+1,1)=I_rex(n);     
        data(num).e_rex_tot(n+1,m+1)=round(data(num).rex_dr_range(n+1,m+1)*energy_consumption_pro_km); %capacity of REX in [Wh]
       
        data(num).cost(1,m+1)= cell;
        data(num).cost(2,m+1)= round(E_bat1*0.45+E_bat1/160*0.22*0.0278*1995); %cost_E_bat1
        data(num).cost(3,m+1)= round(cell*0.00558*100*5);                                      %cost_REX
        data(num).cost(4,m+1)= round(E_bat1*0.45+E_bat1/160*0.22*0.0278*1995)+cell*0.00558*100*5; %cost_total
        data(num).cost(5,m+1)= round((E_bat1+5.58*cell)*0.45+(E_bat1+5.58*cell)/160*0.23*0.0278*2000);%reference
       
        data(num).weight(2,m+1)= E_bat1/122; %weight_E_bat1
        data(num).weight(3,m+1)= cell*0.015; %weight_REX
        data(num).weight(4,m+1)= E_bat1/122+cell*0.015; %weight_tatal
      
        data(num).dr(n,m)=data(num).driving_range(2,n)+data(num).rex_dr_range(n+1,m+1);
      
    end 
        
    maximum_1=max(data(num).rex_dr_range(n+1,:));
    v1=find(data(num).rex_dr_range(n+1,:)==maximum_1);
    data(num).driving_range(3,n)=  data(num).rex_dr_range(n+1,v1);                             %rex_km
    data(num).driving_range(4,n)= data(num).driving_range(2,n)+ data(num).driving_range(3,n);  %sum_k
    
end

data(num).v=find((data(num).dr(:,:)) > range, 4);

data(num).test=(data(num).dr(data(num).v)<=(data(num).dr(min(data(num).v))+1));
if sum(data(num).test)>1
    data(num).temp=data(num).v(sum(data(num).test));
    clear data(num).v;
    data(num).v=data(num).temp;
else
    temp=min(data(num).v);
    clear data(num).v;
    data(num).v=temp;
end    

if isempty(data(num).v)
   data(num).v=0;
   data(num).index=[0 0];
   result(1,num)=E_bat1;                                     
   result(2,num)=0;              %soc
   result(3,num)=0;              %cell
   result(4,num)=data(num).dr(10,29); %Km max can reach
   result(5,num)=data(num).cost(4,30);   %cost_max
   result(6,num)=data(num).weight(4,30); %weight_max
   result(7,num)=data(num).e_rex_tot(11,30);
else  
   data(num).index(1,1)=mod(data(num).v,10);
   data(num).index(1,2)=floor(data(num).v/10)+1;
    
   if data(num).index(1,1)==0
      data(num).index(1,1)=10;
      data(num).index(1,2)=data(num).index(1,2)-1;
   end
   
   result(1,num)=E_bat1;                                     
   result(2,num)=data(num).index(1,1)*10;                    %soc
   result(3,num)=(data(num).index(1,2)+19)*100;              %cell
   result(4,num)=data(num).dr(data(num).index(1,1),data(num).index(1,2)); %Km
   result(5,num)=data(num).cost(4,data(num).index(1,2)+1);   %cost
   result(6,num)=data(num).weight(4,data(num).index(1,2)+1); %weight
   result(7,num)=data(num).e_rex_tot(data(num).index(1,1)+1,data(num).index(1,2)+1);
     
 end    
 
end     
 
 
 