% X=data(3).dr_range(1,2:22);
% Y=data(3).dr_range(2:11,1);
% Z=data(3).dr(1:10,1:21);
% 
% x=data(3).dr_range(1,2:22);
% y=data(3).dr_range(2:11,1);
% z=data(3).dr(1:10,1:21);
% figure(1)
% % subplot(1,2,1);
% surf(x,y,z);
% shading faceted;
% hold on;
% % figure(1)
% % % [X,Y,Z]=peaks(30);
% % waterfall(X,Y,Z)
% % xlabel('X-axis'),ylabel('Y-axis'),zlabel('Z-axis');
% % figure(2)
% [c,h]=contour3(X,Y,Z,20,'w','linewidth',3);     %??12????????
% clabel(c);
% xlabel('X-axis'),ylabel('Y-axis'),zlabel('Z-axis');
% hold on;
% % figure(3)
% % contourf(X,Y,Z); %??12????????
% % % clabel(c1);
% % 
% % xlabel('X-axis'),ylabel('Y-axis'),zlabel('Z-axis');
% 


if a<25000||a>40000
    
    error_e_bat1='E_bat1 is exceed';
    set(handles.edit4,'String',error_e_bat1);
    
end    


