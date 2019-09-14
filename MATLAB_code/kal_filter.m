clear all
point=[];%matrix to store original GPS data
start_x=0;
start_y=0;
%read from excel
point(:,1)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'A1:A9000');
point(:,2)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'B1:B9000');
point(:,3)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'C1:C9000');
point(:,4)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'D1:D9000');
point(:,5)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'E1:E9000');
point(:,6)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'F1:F9000');
point(:,7)=xlsread('C:\Users\lenovo\Desktop\0905.xlsx',1,'G1:G9000');

total_x1=0;
total_y1=0;
total_x2=0;
total_y2=0;
total_x3=0;
total_y3=0;
total_x4=0;
total_y4=0;
total_x5=0;
total_y5=0;
 total_x6=0;
total_y6=0;
total_x7=0;
total_y7=0;
count=0;
for i=0:1:2999
    start_x=start_x+point(3*i+1,1);
    start_y=start_y+point(3*i+2,1);
end
final=zeros(7,2);
final(1,1)=30.6212482452392;
final(1,2)=96.339599609375;
finalm=zeros(7,2);
result1=zeros(1,3000);
result2=zeros(1,3000);
result5=zeros(1,3000);
result6=zeros(1,3000);
result7=zeros(1,3000);
result3=zeros(1,3000);%store point3 distance to start point
pote_x3=[];%store potential correct GPS for point 3
pote_y3=[];
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,3)-final(1,1))/180;
    deta_longti=pi*(point(3*i+2,3)-final(1,2))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,3)/180)*cos(pi*final(1,1)/180)*(sin(deta_longti/2))^2);
    result3(i+1)=2*6372704*asin(hav);
    %if(abs(result3(i+1)-20)<0.5)
        %pote_x3=[pote_x3,point(3*i+1,3)];
       % pote_y3=[pote_y3,point(3*i+2,3)];
    %end
    if(abs(result3(i+1)-20)<50)
        total_x3=total_x3+point(3*i+1,3);
        total_y3=total_y3+point(3*i+2,3);
        count=count+1;
    end
  
end
total_x3=total_x3/count;
 total_y3=total_y3/count;
 count=0;
result4=zeros(1,3000);
pote_x4=[];%store potential correct GPS for point 3
pote_y4=[];
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,4)-final(1,1))/180;
    deta_longti=pi*(point(3*i+2,4)-final(1,2))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,4)/180)*cos(pi*final(1,1)/180)*(sin(deta_longti/2))^2);
    result4(i+1)=2*6372704*asin(hav);
    %if(abs(result4(i+1)-30)<0.5)
    %    pote_x4=[pote_x4,point(3*i+1,4)];
    %    pote_y4=[pote_y4,point(3*i+2,4)];
    %end
    if(abs(result4(i+1)-30)<50)
        total_x4=total_x4+point(3*i+1,4);
        total_y4=total_y4+point(3*i+2,4);
        count=count+1;
    end
end
total_x4=total_x4/count;
 total_y4=total_y4/count;
 count1=0;
line_para=[];%store the data on a line
sim_degree=[];
actual=abs(result4-30);
[sim_x,sim_y]=find(actual==min(min(actual)));

%ddd=[];
%for i=1:1:size(pote_x3,2)
 %   for j=1:1:size(pote_x4,2)
  %      ddd=[ddd abs((pote_x4(j)-final(1,1))/(pote_x3(i)-final(1,1))-3/2)];
   %     if(abs(((pote_x4(j)-final(1,1))/(pote_x3(i)-final(1,1)))-3/2)<0.1)
    %      line_para=[line_para;pote_x3(i),pote_y3(i),pote_x4(j),pote_y4(j)];
     %     sim_degree=[sim_degree;abs(((pote_x4(j)-final(1,1))/(pote_x3(i)-final(1,1)))-3/2)]
      %    [sim_x,sim_y]=find(sim_degree==min(min(sim_degree)));
       % end
    %end
%end
%-----get actual GPS for the line------
actualx=[30.6212482452392];
actualy=[96.339599609375];
for i=1:6
    actualx=[actualx;(point(3*(sim_y(1)-1)+1,4)-30.6212482452392)/3*i+30.6212482452392];
    actualy=[actualy;(point(3*(sim_y(1)-1)+2,4)-96.339599609375)/3*i+96.339599609375];
end
%------calculate result by just do averaging-------
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,2)-final(1,1))/180;
    deta_longti=pi*(point(3*i+2,2)-final(1,2))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,2)/180)*cos(pi*final(1,1)/180)*(sin(deta_longti/2))^2);
    result2(i+1)=2*6372704*asin(hav);
    
    if(abs(result2(i+1)-10)<50)
        total_x2=total_x2+point(3*i+1,2);
        total_y2=total_y2+point(3*i+2,2);
        count1=count1+1;
    end
end
total_x2=total_x2/count1;
 total_y2=total_y2/count1;
count2=0;
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,5)-final(1,1))/180;
    deta_longti=pi*(point(3*i+2,5)-final(1,2))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,5)/180)*cos(pi*final(1,1)/180)*(sin(deta_longti/2))^2);
    result5(i+1)=2*6372704*asin(hav);
    
    if(abs(result5(i+1)-40)<50)
        total_x5=total_x5+point(3*i+1,5);
        total_y5=total_y5+point(3*i+2,5);
        count2=count2+1;
    end
end
total_x5=total_x5/count2;
 total_y5=total_y5/count2;
count=0;
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,6)-final(1,1))/180;
    deta_longti=pi*(point(3*i+2,6)-final(1,2))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,6)/180)*cos(pi*final(1,1)/180)*(sin(deta_longti/2))^2);
    result6(i+1)=2*6372704*asin(hav);
    
    if(abs(result6(i+1)-50)<50)
        total_x6=total_x6+point(3*i+1,6);
        total_y6=total_y6+point(3*i+2,6);
        count=count+1;
    end
end
total_x6=total_x6/count;
 total_y6=total_y6/count;
count=0;

for i=0:1:2999
    deta_lati=pi*(point(3*i+1,7)-final(1,1))/180;
    deta_longti=pi*(point(3*i+2,7)-final(1,2))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,7)/180)*cos(pi*final(1,1)/180)*(sin(deta_longti/2))^2);
    result7(i+1)=2*6372704*asin(hav);
    
    if(abs(result7(i+1)-60)<50)
        total_x7=total_x7+point(3*i+1,7);
        total_y7=total_y7+point(3*i+2,7);
        count=count+1;
    end
end
%result22=abs(result2-10);
%result33=abs(result3-20);
%result44=abs(result4-30);
%result55=abs(result5-40);
%result66=abs(result6-50);
%result77=abs(result7-60);
total_x7=total_x7/count;
 total_y7=total_y7/count;
count=0;
%[lab2,lab22]=find(result22==min(min(result22)));
%[lab3,lab33]=find(result33==min(min(result33)));
%[lab4,lab44]=find(result44==min(min(result44)));
%[lab5,lab55]=find(result55==min(min(result55)));
%[lab6,lab66]=find(result66==min(min(result66)));
%[lab7,lab77]=find(result77==min(min(result77)));
averagex=[30.6212482452392,total_x2,total_x3,total_x4,total_x5,total_x6,total_x7];
averagey=[96.339599609375,total_y2,total_y3,total_y4,total_y5,total_y6,total_y7];
%selx=[30.6212482452392,point((lab22(1)-1)*3+1,2),point((lab33(1)-1)*3+1,3),point((lab44(1)-1)*3+1,4),point((lab55(1)-1)*3+1,5),point((lab66(1)-1)*3+1,6),point((lab77(1)-1)*3+1,7)];
%sely=[96.339599609375,point((lab22(1)-1)*3+2,2),point((lab33(1)-1)*3+2,3),point((lab44(1)-1)*3+2,4),point((lab55(1)-1)*3+2,5),point((lab66(1)-1)*3+2,6),point((lab77(1)-1)*3+2,7)];
%selx(2)=30.621310670166;
%sely(2)=96.3396517915039;
% plot(actualx,actualy,'-.g*','Markersize',6, 'LineWidth',2,'MarkerFaceColor','g');
% hold on
% plot(averagex,averagey,'-rV','Markersize',6, 'LineWidth',2,'MarkerFaceColor','r');
% hold on
%plot(selx,sely,'-b^','Markersize',6, 'LineWidth',2,'MarkerFaceColor','b');
%legend('actual path','path by GPS averaging','path by data selection');
%-----kalman filter---------
sigma_meax=zeros(1,7);
sigma_meay=zeros(1,7);
for k=1:1:7
for i=0:1:2999
    xdis(k,i+1)=pi*(point(3*i+1,k)-averagex(1,k))/180*6371000;
    ydis(k,i+1)=pi*(point(3*i+2,k)-averagey(1,k))/180*6371000;
    %if(abs(result3(i+1)-20)<0.5)
        %pote_x3=[pote_x3,point(3*i+1,3)];
       % pote_y3=[pote_y3,point(3*i+2,3)];
    %end
    
end
sigma_meax(k)=std(xdis(k,:));
sigma_meay(k)=std(ydis(k,:));
end
x_axis=[];
y_axis=[];
for sigma=0.01:0.01:0.5
    x_axis=[x_axis sigma];
   selx=zeros(7,1);
   sely=zeros(7,1);
    selx(1)=30.6212482452392;
    sely(1)=96.339599609375;
sigma_prex=sigma* 9.8267/9.9724;
sigma_prey=sigma*1.6967/9.9724;
F=[1  10;0 1];
H=[1 0];
G=[50  50; 10 10];
Q=sigma^2*G*G';
x=[0 0;0.98267 0.16967];
P=[0 0; 0 0];
for i=2:1:7
    x_=F*x;
    P_=F*P*F+Q;
    z=[(averagex(i)-averagex(1))*6371000*pi/180 (averagey(i)-averagey(1))*6371000*pi/180];
    y=z-H*x_;
    R=sqrt(sigma_meax(i)^2+sigma_meay(i)^2);
    S= H*P_*H'+R;
    K=P_*H'*S^(-1);
    x=x_+K*y;
    I=[1 0 ;0 1];
    P=(I-K*H)*P_*(I-K*H)'+K*R*K';
    selx(i)=(x(1,1))/6371000*180/pi+selx(1);
     sely(i)=(x(1,2))/6371000*180/pi+sely(1);
end
SSTsel=0;
for n=2:1:7
for i=1:1:50
	curselx=(selx(n)-selx(n-1))/50*i+selx(n-1);
	cursely=(sely(n)-sely(n-1))/50*i+sely(n-1);
	curactualx=(actualx(n)-actualx(n-1))/50*i+actualx(n-1);
	curactualy=(actualy(n)-actualy(n-1))/50*i+actualy(n-1);
	deta_lati=pi*(curselx-curactualx)/180;
    deta_longti=pi*(cursely-curactualy)/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*curselx/180)*cos(pi*curactualx/180)*(sin(deta_longti/2))^2);
    dis=2*6372704*asin(hav);  
    SSTsel=SSTsel+dis;
end
end
y_axis=[y_axis SSTsel];

end
 plot(x_axis,y_axis,'-bv','Markersize',6, 'LineWidth',2,'MarkerFaceColor','b');
