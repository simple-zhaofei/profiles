flag = 0;
knickpoint_elevation=[];
knickpoint_distance=[];
arr=[];
number=0;
lie=789*6938;
len_liedian=0;
liedian_final=zeros(3,lie);
hangshu=789;
lieshu=6938;
% distance=distance/1000;
max_dis=max(max(distance))/1000;
% for i = 1:896
%     x = distance(i,:)/1000;
%     y = elevation(i,:);
% 
%     x = fliplr(x);
%     x(isnan(x))=[];
%     y(isnan(y))=[];
% 
%     set(gcf,'color','w');  
%     set(gca,'FontSize',10,'FontWeight','bold')
%     ylabel('Elevation/m','FontName','Times New Roman','FontSize',16);
%     xlabel('Distance/km','FontName','Times New Roman','FontSize',16);
% %      axis([0 7000 -1000 6000]) 
%     plot(x,y,'color',[0.5 0.5 0.5]);   %不拟合
%     hold on;
% end
qinshijizhun=zeros(2,lieshu);
tem_ele=ones(hangshu,lieshu)*9999;
liuyubianjiexian=zeros(2,lieshu);
tem_ele2=zeros(hangshu,lieshu);
for i=1:hangshu
a=elevation(i,:);
a(isnan(a))=[];
a=fliplr(a);
tem_ele(i,1:length(a))=a;
tem_ele2(i,1:length(a))=a;
end
for p = 1:lieshu
    tem=(tem_ele(:,p))';
%     tem(find(isnan(tem)==1)) = 999999;
    [tem_min,tem_flag]=min(tem);
    qinshijizhun(1,p)=tem_min;
    qinshijizhun(2,p)=distance(tem_flag,p);
    tem2=(tem_ele2(:,p))';
%     tem(find(isnan(tem)==1)) = 999999;
    [tem_max,tem_flag2]=max(tem2);
    liuyubianjiexian(1,p)=tem_max;
    liuyubianjiexian(2,p)=distance(tem_flag2,p);
end

    x =qinshijizhun(2,:);
    y=qinshijizhun(1,:);
    x(isnan(x))=[];
    y(isnan(y))=[];

    set(gcf,'color','w');  
    set(gca,'FontSize',10,'FontWeight','bold')
    ylabel('Elevation/m','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
    xlabel('Distance/km','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
%      axis([0 7000 -1000 6000]) 
   x=x/1000;
    plot(x,y,'color',[0 0 0.6],"LineWidth",2);   %不拟合
    hold on;
    
%    拟合曲线
nihe_x= qinshijizhun(1,:);
nihe_y=qinshijizhun(2,:);
p = polyfit(x,y,1); 
xx=1:max_dis;
yy=polyval(p,xx);
plot(xx,yy,'--','color',[1 0 0],"LineWidth",2); 
hold on;

    x =liuyubianjiexian(2,:);
    y=liuyubianjiexian(1,:);
    x(isnan(x))=[];
    y(isnan(y))=[];

%     set(gcf,'color','w');  
%     set(gca,'FontSize',10,'FontWeight','bold')
%     ylabel('Elevation/m','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
%     xlabel('Distance/km','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
% %      axis([0 7000 -1000 6000]) 
   x=x/1000;
    plot(x,y,'color',[0 0.39 0],"LineWidth",2);   %不拟合
    hold on;
    
%    拟合曲线
nihe_x= liuyubianjiexian(1,:);
nihe_y=liuyubianjiexian(2,:);
p2 = polyfit(x,y,1); 
xx=1:max_dis;
yy=polyval(p2,xx);
plot(xx,yy,'--','color',[0 0 0],"LineWidth",2); 
hold on;
l1=legend('Basin boundary','Fitting curve of Basin boundary','Erosion base','Fitting curve of Erosion base','Location','NorthWest');
set(l1,'Fontname', 'Times New Roman','FontWeight','bold','FontSize',11, 'Position', [0.365, 0.82, 0, 0]);
