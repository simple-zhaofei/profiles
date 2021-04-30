flag = 0;
knickpoint_elevation=[];
knickpoint_distance=[];
arr=[];
number=0;
lie=1203*11136;
len_liedian=0;
liedian_final=zeros(3,lie);
hangshu=1203;
lieshu=11136;
% distance=distance/1000;
maxa =  max(max(distance));
max_dis=max(max(distance))/1000;
for i = 1:hangshu
    x = distance(i,:);
    y = elevation(i,:);
    len = length(x);
    
    liedian_x=x; %juli
    liedian_y=y; %gaocheng
    for j = 2:len-1
        if (isnan(liedian_y(j+1)))
            liedian_y(j)=0;
           break; 
        end
        h=y(j-1)-y(j+1);
        d=liedian_x(j+1)-liedian_x(j-1);
        liedian_y(j)=h/d;
    end
     liedian_y(1)=0;
     liedian_y(len)=0;
     
    liedian2_x=x; %juli
    liedian2_y=liedian_y; %gaocheng
    for k = 2:len-1
        if (isnan(liedian2_y(k+1)))
            liedian2_y(k)=0;
           break; 
        end
        h=abs(liedian_y(k-1)-liedian_y(k+1));
        d=liedian2_x(k+1)-liedian2_x(k-1);
        liedian2_y(k)=h/d;
    end
    liedian2_y(1)=0;
    liedian2_y(len)=0;   
     
    x = fliplr(x);
    x(isnan(x))=[];
    y(isnan(y))=[];
    for m = 1:len
        if(liedian2_y(m)>=0.0015)
           if(len_liedian==0)
               liedian_final(1,1)=x(m);
               liedian_final(2,1)=y(m);
               liedian_final(3,1)=m;
               len_liedian=len_liedian+1;
           end
           flag=1;
           for n = 1 : len_liedian
               a=abs(liedian_final(1,n)-x(m));
               b=abs(liedian_final(2,n)-y(m));
               if(a<200)
                   flag=0;
                  continue;
               end
           end
           if(flag==1)
               liedian_final(1,len_liedian+1)=x(m);
               liedian_final(2,len_liedian+1)=y(m);
               liedian_final(3,len_liedian+1)=m;
               len_liedian=len_liedian+1;
           end
        end
    end  
end
liedian_arr=zeros(3,len_liedian);
    for t = 1:len_liedian
        liedian_arr(1,t)=liedian_final(1,t);
        liedian_arr(2,t)=liedian_final(2,t);
        liedian_arr(3,t)=liedian_final(3,t);
    end
% set(gcf,'color','w');
% ylabel('Elevation/m','FontName','Times New Roman','FontSize',16);
% xlabel('Distance/km','FontName','Times New Roman','FontSize',16);
liedian_arr(1,:)=liedian_arr(1,:)/1000;
plot(liedian_arr(1,:),liedian_arr(2,:),'ro','MarkerFaceColor',[1,0,0],'MarkerSize',3);
hold on;
qinshijizhun=zeros(2,lieshu);
tem_ele=ones(hangshu,lieshu)*9999;
for i=1:hangshu
a=elevation(i,:);
a(isnan(a))=[];
a=fliplr(a);
tem_ele(i,1:length(a))=a;
end
for p = 1:lieshu
    tem=(tem_ele(:,p))';
%     tem(find(isnan(tem)==1)) = 999999;
    [tem_min,tem_flag]=min(tem);
    qinshijizhun(1,p)=tem_min;
    qinshijizhun(2,p)=distance(tem_flag,p);
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
plot(xx,yy,'--','color',[1 0 1],"LineWidth",2); 
hold on;
l1=legend('Knickpoint','Erosion base','Fitting curve of Erosion base','Location','NorthWest');
set(l1,'Fontname', 'Times New Roman','FontWeight','bold','FontSize',11);

gongshi_a=num2str(p(1)*10000);
gongshi_b=num2str(p(2));
gongshi=[gongshi_a,"*10^-5X+",gongshi_b];


