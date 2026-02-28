function QuBIng_display1(axes1,axes2,axes3)
global st   a;
[X, Y, X1, X2, X3 ,T]=data();
y=4;
x=3;
w=0:360;
t=1;
v=-40:0.1:40;
axes(axes1);
speed1=line([0,0],[361,0],'Color','r');
yuan=ezplot('(x-3)^2+(y-4)^2-1');%背景圆
set(yuan,'color','c');
% line(x坐标, y坐标, 属性名, 属性值) 
line([10,6],[4.2,4.2],'Color','c');
line([10,6],[3.8,3.8],'color','c');
hold on;
% [x,y,width,height]
huakuai=rectangle('Position',[4,4,0.4,0.5],'LineWidth',2);%滑块
ball=plot(3,4,'k.');
set(ball,'MarkerSize',10);
lin2=line([3,3],[y,4],'LineWidth',2);%杆1
lin1=line([3,x],[4,y],'LineWidth',2);%杆2
xlim([1 10]);
ylim([0 8]);          %主图 y 值域
title(' ');
set(gca,'xTick',[]);%去除 X
set(gca,'yTick',[]);%去除 Y
xlabel(' ');%去除 x 坐标值
ylabel(' ');%去除 y 坐标值


axes( axes2);
speed1=line([0 721],[2 0],'color','r','linestyle','--');
hold on;
speed=plot( axes2,T,X2,'r');
hold on;
line([0 720],[0 0],'linestyle',':');
ylim([-2 2]);
 set(gca,'xTick',[]);
set(gca,'yTick',[]);

axes( axes3);
acceleration1=line([0 721],[2 0],'color','b','linestyle','--');
hold on;
acceleration=plot( axes3,T,X3,'b');
hold on;
line([0 720],[0 0],'linestyle',':');
ylim([-2 2]);
set(gca,'xTick',[]);
set(gca,'yTick',[]);
st=8;
while ishandle(lin1)&&a
drawnow;
t=t+st;
if t>=360
     t=1;
end
% 这是「防崩溃保护」：如果用户在动画播放时关闭窗口，lin1（杆 2）的句柄会失效，
% 此时修改它的属性会报错；加这个判断，句柄失效后就跳过更新，循环也会自然停止。
if ishandle(lin1)==1
set(speed1,'YData',[X2(t),X2(t)]);
end
if ishandle(lin1)==1
xlim( axes2,[0+t 360+t]);
end
if ishandle(lin1)==1
set(acceleration1,'YData',[X3(t),X3(t)]);
end
if ishandle(lin1)==1
xlim( axes3,[0+t 360+t]);
end
x=X(t);%铰接点
y=Y(t);
if ishandle(lin1)==1
set(ball,'XData',x,'YData',y);
end
x1=X1(t);
if ishandle(lin1)==1
set(lin2,'XData',[x,x1],'YData',[y,4]);
set(lin1,'XData',[3,x],'YData',[4,y]);
set(huakuai,'position',[x1,3.8,0.5,0.4]);
end
pause(0.03);
end
end

function [X,Y,X1,X2,X3,T]=data()
    sed=3.14159/180;
    X=linspace(0,0,720);%铰接点 x 值
    Y=linspace(0,0,720);%铰接点 y 值
    X1=linspace(0,0,720);%滑块x值
    X2=linspace(0,0,720);%滑块速度
    X3=linspace(0,0,720);% 滑块加速度
    T=linspace(0,0,720);%进程表
    t=0;
    for a=0:1:720

        x=sin(t)+3;%铰接点
        X(a+1)=x;
        x=cos(t)+4;
        Y(a+1)=x;
        x=sqrt(25-(cos(t))^2)+sin(t)+3;
        X1(a+1)=x-0.25;
        x=cos(t) + (cos(t)*sin(t))/(25 - cos(t)^2)^(1/2);
        X2(a+1)=x;
        x=cos(t)^2/(25 - cos(t)^2)^(1/2) - sin(t) - sin(t)^2/(25 - cos(t)^2)^(1/2) - (cos(t)^2*sin(t)^2)/(25 - cos(t)^2)^(3/2);
        X3(a+1)=x;
        T(a+1)=a;
        t=t+sed;
    end
end