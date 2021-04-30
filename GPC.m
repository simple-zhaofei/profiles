y = elevation.';
l = distance.';
y_max=max(y);
y_min=min(y);
l_max=max(l);
number = size(elevation,1);
index=[];
for i = 1:number
    h1=y_max-y_min;
    s1=h1(i)*l_max(i);
    h2=elevation(i,:)-y_min(i);
    if(s1==0)
        continue;
    end
    sum = 0;
    for j = 2 : size(h2,2)
        if(isnan(distance(i,j)))
            continue;
        end
        h_tixing=distance(i,j)-distance(i,j-1);
        sum=sum+(h2(j-1)+h2(j))*h_tixing/2;
    end
    index(i)=sum/s1;
end
junzhi=mean(index);
biaozhuncha = std(index,0);
zhongweishu = median(index);