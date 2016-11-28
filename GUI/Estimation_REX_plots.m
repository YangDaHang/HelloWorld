% function Estimation_REX_plots (E_bat1,range)
% tic

E_bat1=27000;
range=250;
number=round((E_bat1-24000)/1000);


figure(1)      
A=result(1,1:16); %E_bat1
B=result(7,1:16); %E_rex
Z=zeros(1,16);
C=result(2,:);    %socA
r=[A',B'];
m=1:16;

bar([A',B'],'stacked')
hold on
% legend({'E Bat1';'E Bat2'});
[ax,h1,h2]=plotyy(m,Z,m,C,@bar,@plot);hold on;
legend('E Bat1','E bat2');

s=[zeros(1,16)',zeros(1,16)']
s(3,1)=A(3);
s(3,2)=B(3);    
h=bar(s,'stacked');
set(h(1),'facecolor','r');
set(h(2),'facecolor','g');
hold on


set(get(ax(2),'Ylabel'),'string','SOC [%]','color','r') 
set(get(ax(1),'Ylabel'),'string','E Bat1&E REX [Wh]','color','k') 

xlabel(' ');
set(h2,'linestyle','-','color','r','linewidth',3);   
set(ax(:),'Ycolor','k') 
set(ax(2),'ytick',[0:10:100]); 
set(ax(1),'ytick',[0:10000:40000])
set(ax,'xlim',[0 17]) 
hold on
title('Energy & SOC');
 

figure(2) 
v2=find(data(number).dr_range(2:11,1)==3); %current = 3A
v2_max=max(v2);
X=data(number).dr_range(1,2:22);       %2000 2100......4000
Y=data(number).dr_range(1+v2_max:11,1);
Z=data(number).dr(v2_max:10,1:21);

x=data(number).dr_range(1,2:22);
y=data(number).dr_range(1+v2_max:11,1);
z=data(number).dr(v2_max:10,1:21);

surf(x,y,z);
shading faceted;
hold on;
[c,h]=contour3(X,Y,Z,8,'w','linewidth',3);     %??12????????
clabel(c);
xlabel('cell number of REX'),ylabel('I rex'),zlabel('driving range');
hold on; 

figure(3)
 

data1=data(number).dr(v2_max:end,18)';

% data250=[ 250 250 250 250 250 250 250]';
data_ref=zeros(1,11-v2_max)+round(range); %as reference driving range line to compare


m1=data(number).dr_range(1+v2_max:11,1)';

plot(m1,data(number).dr(v2_max:end,15)','linewidth',2);
hold on;
[ax1,h3,h4]=plotyy(m1,data1,m1,data_ref); %h-- line handle
hold on;
plot(m1,data(number).dr(v2_max:end,21)','linewidth',2);
legend('cell3400','cell3700','cell4000'); 

set(get(ax1(1),'Ylabel'),'string','dring range','color','r') %y1
set(get(ax1(2),'Ylabel'),'string','250Km','color','k') %y2
xlabel('I rex');
set(h3,'linestyle','-','linewidth',2);   
set(h4,'linestyle','-','color','k','linewidth',2);  
set(ax1(:),'Ycolor','k')
set(ax1(1),'ytick',[200:10:270]);
set(ax1(2),'ytick',[200:10:270])
set(ax1,'xlim',[min(m1) max(m1)]) 
hold on
title('range@I rex@E bat1 27000Wh');





