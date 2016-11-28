figure(1)      
A=result(1,1:16); %E_bat1
B=result(7,1:16); %E_rex
C=result(2,:);    %soc
r=[A',B'];
m=1:16;
xlabel(' ');
yyaxis left
ylabel('E Bat1&E REX');
bar([A',B'],'stacked')

yyaxis right
plot(m,C,'linewidth',2);
ylabel('SOC');
ylim([0,100]);
legend('E bat1','E rex','SOC'); 
% % [ax,h1,h2]=plotyy(m,C,m,r,@plot,@bar); %h-- line handle
% set(get(ax(1),'Ylabel'),'string','SOC','color','r') %y1
% set(get(ax(2),'Ylabel'),'string','E Bat1&E REX','color','k') %y2
% xlabel(' ');
% set(h1,'linestyle','-','color','r','linewidth',3);   
% set(ax(:),'Ycolor','k') 
% set(ax(1),'ytick',[0:10:100]); 
% set(ax(2),'ytick',[0:10000:40000])
% set(ax,'xlim',[1 16]) 
% title('E & SOC');

figure(2)
v2=find(data(3).dr_range(2:11,1)==3);
v2_max=max(v2);
X=data(3).dr_range(1,2:22);       %2000 2100......4000
Y=data(3).dr_range(1+v2_max:11,1);
Z=data(3).dr(v2_max:10,1:21);

x=data(3).dr_range(1,2:22);
y=data(3).dr_range(1+v2_max:11,1);
z=data(3).dr(v2_max:10,1:21);

surf(x,y,z);
shading faceted;
hold on;
[c,h]=contour3(X,Y,Z,8,'w','linewidth',3);     %??12????????
clabel(c);
xlabel('cell number of REX'),ylabel('I rex'),zlabel('driving range');
hold on;

figure(3)

data1=data(3).dr(v2_max:end,18)';

% data250=[ 250 250 250 250 250 250 250]';
data250=zeros(1,11-v2_max)+250;


m1=data(3).dr_range(1+v2_max:11,1)';

plot(m1,data(3).dr(v2_max:end,15)','linewidth',2);
hold on;
[ax1,h3,h4]=plotyy(m1,data1,m1,data250); %h-- line handle
hold on;
plot(m1,data(3).dr(v2_max:end,21)','linewidth',2);
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




