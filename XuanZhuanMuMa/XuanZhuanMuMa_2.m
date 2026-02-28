function XuanZhuanMuMa_2(handles)%主要函数
global dt Fx Fy Fz t ;%dt 时间步长      fx：x关于t的函数，fy，fz同理     t时间向量
t=0:0.01:6.28;
Fz=sin(t*8)*0.5;
Fx=sin(t);
Fy=cos(t);

%通过如下三个数组绘制球在x=0、y=0、z=0，面上的投影
zero_data=(0:0.1:6.3)*0;
sin_data=0.2*sin(0:0.1:6.3);
cos_data=0.2*cos(0:0.1:6.3);

[ball_data(:,:,1),ball_data(:,:,2), ball_data(:,:,3) ]= sphere;%生成单位半径大小的球面数据
ball_data=ball_data*0.2;%将球大小缩小至0.2倍

ball=surf(handles.axes1,ball_data(:,:,1),ball_data(:,:,2), ball_data(:,:,3));hold on;%绘制球
set(ball,'FaceColor','blue');%更改球颜色为蓝色
set( handles.axes1,'xlim',[-1.5 1.5],'ylim',[-1.5 1.5],'zlim',[-1.5 1.5]);%限制坐标轴范围

ball_2=plot3(handles.axes1,sin_data,cos_data,zero_data,'Color','k');%z=0 面上投影
ball_3=plot3(handles.axes1,zero_data,sin_data,cos_data,'Color','k');%x=0面上投影
ball_4=plot3(handles.axes1,sin_data,zero_data,cos_data,'Color','k');%y=0面上投影

GuiJi=plot3(handles.axes1,Fx,Fy,Fz,'Color','b','LineWidth',1);%,'LineStyle',':'%球的轨迹
GuiJi_x1=plot3(handles.axes1,Fx,Fy,Fz,'LineStyle',':','Color','r');%投影标线，以下两行同理
GuiJi_y1=plot3(handles.axes1,Fx,Fy,Fz,'LineStyle',':','Color','r');
GuiJi_z1=plot3(handles.axes1,Fx,Fy,Fz,'LineStyle',':','Color','r');

GuiJi_x=plot3(handles.axes1,Fx*0+1.5,Fy , Fz,'LineStyle',':','Color','k');%轨迹在x=0面上的投影
GuiJi_y=plot3(handles.axes1,Fx,Fy*0+1.5,Fz,'LineStyle',':','Color','k');%轨迹在y=0面上投影，余下同理
GuiJi_z=plot3(handles.axes1,Fx,Fy,Fz*0+1.5,'LineStyle',':','Color','k');

set( handles.axes1,'view', [25 35]);%设置视角，转角25度，仰角35度
set( handles.slider2,'value',(25+180)/360);%设置转角滑动条位置，以下同理
set( handles.slider3,'value',(35+90)/180);
i=1;

while 1
        i=i+dt;
        if i>628
            i=1;
        end
        qut=get( handles.axes1,'view');%获取当前视角数据
        sett(ball, qut  , ball_data(:,:,1), ball_data(:,:,2),  ball_data(:,:,3)  , Fx(i) , Fy(i) , Fz(i) );%
        %根据视角及球位置，计算球与观察者的距离，近大远小，改变球的大小增强立体感
        
        x1=1.5; y1=-1.5 ; z1=-1.5;%背景墙初始位置数据
        if qut(1)>0&&qut(1)<180%根据视角改变背景墙数据，使得背景墙上的投影等始终处于球后方
            x1=-1.5;
        end
        if qut(1)>-90&&qut(1)<90%与上一式类似
            y1=1.5;
        end
        if qut(2)<0&&qut(2)>-180
            z1=1.5;
        end
        sett(ball_2 , qut, sin_data, cos_data, zero_data,Fx(i) , Fy(i), z1);%刷新z面（与z轴垂直的面）上的球投影
        sett(ball_3 , qut, zero_data , sin_data , cos_data , x1 , Fy(i) , Fz(i));%刷新x面上的球投影
        sett(ball_4 , qut, cos_data ,zero_data , sin_data , Fx(i) , y1 , Fz(i));%同理
        
        set(GuiJi , 'Xdata',Fx,'Ydata', Fy ,'Zdata', Fz );%刷新轨迹
        set(GuiJi_x1 , 'Xdata',[Fx(i) x1],'Ydata',[Fy(i) Fy(i)],'Zdata', [Fz(i) Fz(i)]);%刷新x面标线投影
        set(GuiJi_y1 , 'Xdata',[Fx(i) Fx(i)],'Ydata',[Fy(i) y1],'Zdata', [Fz(i) Fz(i)]);%余下同理
        set(GuiJi_z1 , 'Xdata',[Fx(i) Fx(i)],'Ydata',[Fy(i) Fy(i)],'Zdata', [Fz(i) z1]);
        
         set(GuiJi_x , 'Xdata',Fx*0+x1,'Ydata',Fy,'Zdata',Fz);%刷新x面轨迹投影
         set(GuiJi_y , 'Xdata',Fx,'Ydata',Fy*0+y1,'Zdata',Fz);%同理
         set(GuiJi_z , 'Xdata',Fx,'Ydata',Fy,'Zdata',Fz*0+z1);
        pause(0.02);%暂停0.02秒
end

end