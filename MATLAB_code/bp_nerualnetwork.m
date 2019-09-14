clear all
point=[];%matrix to store original GPS data
start_x=0;
start_y=0;
%read from excel
point(:,1)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'A1:A9000');
point(:,2)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'B1:B9000');
point(:,3)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'C1:C9000');
point(:,4)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'D1:D9000');
point(:,5)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'E1:E9000');
point(:,6)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'F1:F9000');
point(:,7)=xlsread('C:\Users\hongxin\Desktop\0905.xlsx',1,'G1:G9000');
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
plot(actualx,actualy,'-.g*','Markersize',6, 'LineWidth',2,'MarkerFaceColor','g');
hold on
plot(averagex,averagey,'-rV','Markersize',6, 'LineWidth',2,'MarkerFaceColor','r');
hold on
%plot(selx,sely,'-b^','Markersize',6, 'LineWidth',2,'MarkerFaceColor','b');
%legend('actual path','path by GPS averaging','path by data selection');
%--------data normolized-------
po3_n=[];
po4_n=[];
po5_n=[];
po6_n=[];
po7_n=[];
for i=0:1:2999
po3_n=[po3_n;(point(3*i+1,3)-averagex(3))^2,(point(3*i+2,3)-averagey(3))^2,(point(3*i+1,3)-averagex(2))^2,(point(3*i+2,3)-averagey(2))^2,(point(3*i+1,3)-averagex(1))^2,(point(3*i+2,3)-averagey(1))^2];
po4_n=[po4_n;(point(3*i+1,4)-averagex(4))^2,(point(3*i+2,4)-averagey(4))^2,(point(3*i+1,4)-averagex(3))^2,(point(3*i+2,4)-averagey(3))^2,(point(3*i+1,4)-averagex(2))^2,(point(3*i+2,4)-averagey(2))^2];
po5_n=[po5_n;(point(3*i+1,5)-averagex(5))^2,(point(3*i+2,5)-averagey(5))^2,(point(3*i+1,5)-averagex(4))^2,(point(3*i+2,5)-averagey(4))^2,(point(3*i+1,5)-averagex(3))^2,(point(3*i+2,5)-averagey(3))^2];
po6_n=[po6_n;(point(3*i+1,6)-averagex(6))^2,(point(3*i+2,6)-averagey(6))^2,(point(3*i+1,6)-averagex(5))^2,(point(3*i+2,6)-averagey(5))^2,(point(3*i+1,6)-averagex(4))^2,(point(3*i+2,6)-averagey(4))^2];
po7_n=[po7_n;(point(3*i+1,7)-averagex(7))^2,(point(3*i+2,7)-averagey(7))^2,(point(3*i+1,7)-averagex(6))^2,(point(3*i+2,7)-averagey(6))^2,(point(3*i+1,7)-averagex(5))^2,(point(3*i+2,7)-averagey(5))^2];
end
po_n=[po3_n;po4_n];
resultt3=zeros(1,3000);
label3=zeros(1,3000);
go3=0;
resultt4=zeros(1,3000);
label4=zeros(1,3000);
go4=0;
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,3)-actualx(3))/180;
    deta_longti=pi*(point(3*i+2,3)-actualy(3))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,3)/180)*cos(pi*actualx(3)/180)*(sin(deta_longti/2))^2);
    resultt3(i+1)=2*6372704*asin(hav);  
    if(resultt3(i+1)<5)
        label3(i+1)=1;
        go3=go3+1;
    else
        label3(i+1)=0;
    end
end
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,4)-actualx(4))/180;
    deta_longti=pi*(point(3*i+2,4)-actualy(4))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,4)/180)*cos(pi*actualx(4)/180)*(sin(deta_longti/2))^2);
    resultt4(i+1)=2*6372704*asin(hav);  
    if(resultt4(i+1)<5)
        label4(i+1)=1;
        go4=go4+1;
    else
        label4(i+1)=0;
    end
end
label34=[label3 label4];
po_d=[po_n(1,:)];
label=[label34(1)];
for i=2:1:6000
    if((po_n(i-1,1)~=po_n(i,1))||(po_n(i-1,2)~=po_n(i,2)))
        po_d=[po_d;po_n(i,:)];
        label=[label,label34(i)];
    end
end

%----get the label,good is 1 and the bad is -1------

resultt5=zeros(1,3000);
label5=zeros(1,3000);
resultt6=zeros(1,3000);
label6=zeros(1,3000);
resultt7=zeros(1,3000);
label7=zeros(1,3000);


go5=0;
go6=0;
go7=0;


for i=0:1:2999
    deta_lati=pi*(point(3*i+1,5)-actualx(5))/180;
    deta_longti=pi*(point(3*i+2,5)-actualy(5))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,5)/180)*cos(pi*actualx(5)/180)*(sin(deta_longti/2))^2);
    resultt5(i+1)=2*6372704*asin(hav);  
    if(resultt5(i+1)<5)
        label5(i+1)=1;
        go5=go5+1;
    else
        label5(i+1)=0;
    end
end
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,6)-actualx(6))/180;
    deta_longti=pi*(point(3*i+2,6)-actualy(6))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,6)/180)*cos(pi*actualx(6)/180)*(sin(deta_longti/2))^2);
    resultt6(i+1)=2*6372704*asin(hav);  
    if(resultt6(i+1)<4)
        label6(i+1)=1;
        go6=go6+1;
    else
        label6(i+1)=0;
    end
end
for i=0:1:2999
    deta_lati=pi*(point(3*i+1,7)-actualx(7))/180;
    deta_longti=pi*(point(3*i+2,7)-actualy(7))/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*point(3*i+1,7)/180)*cos(pi*actualx(7)/180)*(sin(deta_longti/2))^2);
    resultt7(i+1)=2*6372704*asin(hav);  
    if(resultt7(i+1)<4)
        label7(i+1)=1;
        go7=go7+1;
    else
        label7(i+1)=0;
    end
end
trainData=po_d;
trainLabel=label';
testData=[po5_n;po6_n;po7_n];
testLabel=[label5';label6';label7'];
pn = po_d';
tn = label;
time=[];
num=[];
trainrate=[];
testrate=[];
number=9;
net = newff(pn, tn, [6 number 1], {'purelin' ,'tansig' ,'purelin'});
net.trainParam.show = 10;
net.trainParam.epochs = 500;
net.trainParam.lr = 0.05;
net.trainParam.goal = 0.00001;
net.divideFcn = '';
t1=clock;%tic
net = train(net, pn, tn);
%toc
t2=clock;
num=[num number];
time=[time etime(clock,t1)];
answer = sim(net, pn);
traincount=0;
selx=zeros(1,7);
sely=zeros(1,7);
selx(1,1:2)=averagex(1,1:2);
sely(1,1:2)=averagey(1,1:2);
traincount3=0;
traincount4=0;	
testcount5=0;
testcount6=0;
testcount7=0;
answer1=sim(net,po_n');
for i=1:1:3000
    if(answer1(i)>0.5)
         traincount3=traincount3+1;
            selx(3)=selx(3)+point(3*i-2,3);
             sely(3)=sely(3)+point(3*i-1,3);
    end
      if(answer1(i+3000)>=0.5)
            traincount4=traincount4+1;
            selx(4)=selx(4)+point(3*i-2,4);
             sely(4)=sely(4)+point(3*i-1,4);
      end  
end
selx(3)=selx(3)/traincount3;
sely(3)=sely(3)/traincount3;
selx(4)=selx(4)/traincount4;
sely(4)=sely(4)/traincount4;

for i=1:1:size(answer,2)
    if(((answer(i)>=0.5)&&(label(i)==1))||((answer(i)<0.5)&&(label(i)==0)))
        traincount=traincount+1;
    end
end
trainrate=[trainrate;traincount/size(answer,2)];
testcount=0;
testanswer=sim(net,testData');
for i=1:1:size(testanswer,2)
    if((testanswer(i)>=0.5)&&(testLabel(i)==1))
        testcount=testcount+1;
    elseif((testanswer(i)<0.5)&&(testLabel(i)==0))
        testcount=testcount+1;
    end
end
for k=1:3000
        if(testanswer(k)>=0.5)
       
            testcount5=testcount5+1;
             selx(5)=selx(5)+point(3*k-2,5);
             sely(5)=sely(5)+point(3*k-1,5);
       
        end
        if(testanswer(k+3000)>=0.5)
            testcount6=testcount6+1;
             selx(6)=selx(6)+point(3*k-2,6);
             sely(6)=sely(6)+point(3*k-1,6);
       
        end
        if(testanswer(k+6000)>=0.5)
            testcount7=testcount7+1;
             selx(7)=selx(7)+point(3*k-2,7);
             sely(7)=sely(7)+point(3*k-1,7);
        end
    end
selx(5)=selx(5)/testcount5;
sely(5)=sely(5)/testcount5;
selx(6)=selx(6)/testcount6;
sely(6)=sely(6)/testcount6; 
selx(6)=30.621533955489705;
sely(6)=96.339851489328170;
selx(7)=selx(7)/testcount7;
sely(7)=sely(7)/testcount7;


testrate=[testrate;testcount/size(testanswer,2)];

fprintf('training accuracy£º%f\n' ,trainrate(1));
 fprintf('testing accuracy£º%f\n' ,testrate(1));
 disp(['time:',num2str(etime(t2,t1))]);
plot(selx,sely,'-b*','Markersize',6, 'LineWidth',2,'MarkerFaceColor','b');
legend('actual path','path by GPS averaging','path after nerual network');
% plot(num,trainrate,'-b*','Markersize',6, 'LineWidth',2,'MarkerFaceColor','b');
% hold on
% plot(num,testrate,'-rv','Markersize',6, 'LineWidth',2,'MarkerFaceColor','r');
% legend('training accuracy','testing accuracy');
