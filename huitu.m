flag = 0;
knickpoint_elevation=[];
knickpoint_distance=[];
arr=[];
distance=distance/1000;
number=0;
for i = 1:1203
    x = distance(i,:);
    y = elevation(i,:);

    x = fliplr(x);
    x(isnan(x))=[];
    y(isnan(y))=[];

    set(gcf,'color','w');  
    set(gca,'FontSize',10,'FontWeight','bold')
    ylabel('Elevation/m','FontName','Times New Roman','FontSize',16);
    xlabel('Distance/km','FontName','Times New Roman','FontSize',16);
%      axis([0 7000 -1000 6000]) 
    plot(x,y,'color',[0.5 0.5 0.5]);   %不拟合
    hold on;

%     len = length(y);
%     j=0;
%     number=0;
%     x = fliplr(x);
%     y = fliplr(y);
%     for j = 1:len-1
%         dis=abs(y(j+1)-y(j));
%         if dis == 0
%             number=number+1;
%             flag=1;
%         elseif flag==0 || number<=200
%             number=0;
%             continue;
%         elseif flag==1 && number>200
%             knickpoint_elevation=[knickpoint_elevation y(j)];
%             knickpoint_distance=[knickpoint_distance x(j)];
%             flag=0;
%             number=0;
%         end
%         j=j+1;
%     end
%     disp(i);
end
%筛选把相近的点删除
% le= length(knickpoint_elevation)-1;
% for m=1:le
%     disp(m);
%     dis_ele=abs(knickpoint_elevation(m+1)-knickpoint_elevation(m));
%     if dis_ele<500
%        arr=[arr,m+1];
%     end
% end

scatter(knickpoint_distance,knickpoint_elevation,100,'r');