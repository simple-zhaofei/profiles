flag = 0;
knickpoint_elevation=[];
knickpoint_distance=[];
arr=[];
number=0;
lie=1100*15001;
len_liedian=0;
liedian_final=zeros(3,lie);
hangshu=1100;
lieshu=15001;
% distance=distance/1000;
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
        if(liedian2_y(m)>=0.0001)
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
               if(a<2000)
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
len_liedian=length(liedian_arr(1,:));
liedianfenzu_arr=zeros(2,12);
for i = 1: len_liedian
    if(liedian_arr(1,i)<50)
        liedianfenzu_arr(2,1)=liedianfenzu_arr(2,1)+1;
    elseif(liedian_arr(1,i)<130)
        liedianfenzu_arr(2,2)=liedianfenzu_arr(2,2)+1;
    elseif(liedian_arr(1,i)<200)
        liedianfenzu_arr(2,3)=liedianfenzu_arr(2,3)+1;
    elseif(liedian_arr(1,i)<280)
        liedianfenzu_arr(2,4)=liedianfenzu_arr(2,4)+1;
    elseif(liedian_arr(1,i)<360)
        liedianfenzu_arr(2,5)=liedianfenzu_arr(2,5)+1;
    elseif(liedian_arr(1,i)<460)
        liedianfenzu_arr(2,6)=liedianfenzu_arr(2,6)+1;
    elseif(liedian_arr(1,i)<580)
        liedianfenzu_arr(2,7)=liedianfenzu_arr(2,7)+1;
    elseif(liedian_arr(1,i)<700)
        liedianfenzu_arr(2,8)=liedianfenzu_arr(2,8)+1;
    elseif(liedian_arr(1,i)<830)
        liedianfenzu_arr(2,9)=liedianfenzu_arr(2,9)+1;
    elseif(liedian_arr(1,i)<950)
        liedianfenzu_arr(2,10)=liedianfenzu_arr(2,10)+1;
    elseif(liedian_arr(1,i)<1060)
        liedianfenzu_arr(2,11)=liedianfenzu_arr(2,11)+1;
    else
        liedianfenzu_arr(2,12)=liedianfenzu_arr(2,12)+1;
    end
end
num=1;
for i=1:12
    liedianfenzu_arr(1,i)=num;
    num=num+1;
end
liedianfenzu_arr(2,:)=liedianfenzu_arr(2,:);
nihe_x= liedianfenzu_arr(1,:);
nihe_y=liedianfenzu_arr(2,:);
p = polyfit(nihe_x,nihe_y,2); 
xx=1:12;
yy=polyval(p,xx);
plot(xx,yy,'-',"LineWidth",2); 
% plot(liedianfenzu_arr(1,:),liedianfenzu_arr(2,:),'LineWidth',2);
hold on;
bar(liedianfenzu_arr(2,:),0.6,'r');
alpha(0.4)
% x_label={'<100','100-200','200-300','300-400','400-500','500-600','600-700','700-800','800-900','900-1000','1000-1100','1100-1200'};
x_label={'200','400','600','800','1000','1200',''};
xtb = get(gca,'XTickLabel');% 获取横坐标轴标签句柄
xt = get(gca,'XTick');% 获取横坐标轴刻度句柄
yt = get(gca,'YTick'); % 获取纵坐标轴刻度句柄 
xtextp=xt+1.7;%每个标签放置位置的横坐标，这个自然应该和原来的一样了。                    
ytextp=-0.1*yt(3)*ones(1,length(xt));
text(xtextp,ytextp,x_label,'FontSize',10,'FontWeight','bold');
set(gca,'XTickLabel',[],'FontSize',10,'FontWeight','bold'); %将原坐标(1,2,3,..)去掉
% hist(liedian_arr(2,:),50);
l1=legend('Fitting curve','Number of knickpoints','Location','NorthWest');
set(l1,'Fontname', 'Times New Roman','FontWeight','bold','FontSize',11);
ylabel('Numer of Knickpoints','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
pos=axis;
xlabel({'Distance/km'},'FontName','Times New Roman','FontSize',16,'FontWeight','bold','position',[7 -3]);

