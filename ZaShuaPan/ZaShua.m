function varargout = ZaShua(varargin)
% ZASHUA MATLAB code for ZaShua.fig
%      ZASHUA, by itself, creates a new ZASHUA or raises the existing
%      singleton*.
%
%      H = ZASHUA returns the handle to a new ZASHUA or the handle to
%      the existing singleton*.
%
%      ZASHUA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZASHUA.M with the given input arguments.
%
%      ZASHUA('Property','Value',...) creates a new ZASHUA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ZaShua_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ZaShua_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ZaShua

% Last Modified by GUIDE v2.5 02-Nov-2018 16:47:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ZaShua_OpeningFcn, ...
                   'gui_OutputFcn',  @ZaShua_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ZaShua is made visible.
function ZaShua_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ZaShua (see VARARGIN)
% Choose default command line output for ZaShua
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ZaShua wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ZaShua_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ZaShua data k xn;
ZaShua.m=1;        ZaShua.u=0.15;           ZaShua.r=1;          ZaShua.g=9.8;%ZaShua 是对象，m，g，u等是属性，此处为面向对象的编程
ZaShua.v_0=4;       ZaShua.x_0=0;         ZaShua.w_0=-12;       xn=1;
ZaShua.t_0=0;       ZaShua.v_1=0;           ZaShua.step=1; 

% m 圆盘质量    u摩擦系数     r半径   g重力加速度
% v0初始速速    x0初始位移     w0初始角速度  xn。。。
%t0初始时刻     v1 最终速速     step步数

ZhiZuo_data=zeros(2,301); %支座
data=zeros(6,1000); % data_1 速度         data_2 角速度      data_3 位移      data_4 转角       data_5 时间
for i=0:3:300%支座下方的斜线
    ZhiZuo_data(1,i+1)=i/10;
    ZhiZuo_data(1,i+3)=i/10;
    ZhiZuo_data(1,i+2)=i/10+0.3;
    ZhiZuo_data(2,i+3)=-0.5;
end

%%%%%%%%%%%%%%%%%%%%%%%%        球
 ball_data=zeros(2,33);%球的图形数据
 ball_data(1,:)=ZaShua.r*sin(0:0.2:6.4);
 ball_data(2,:)=ZaShua.r*cos(0:0.2:6.4);
 
caculater();%计算最终速度等，，此函数位于此文件尾部
plot(handles.axes1,ZhiZuo_data(1,:)-15,ZhiZuo_data(2,:),'k');hold(handles.axes1,'on');%绘制支座
 ball=plot(handles.axes1,ball_data(1,:)+ZaShua.x_0,ball_data(2,:)+ZaShua.r,'b');%绘制圆盘
 line=plot(handles.axes1,[ZaShua.x_0 ZaShua.x_0+sin(data(4,1))],[ZaShua.r ZaShua.r+cos(data(4,1))],'b');%圆盘上的线
 set(handles.axes1,'xlim',[-15 15],'ylim',[-2 6]);%限制坐标范围
 
v_t=plot(handles.axes2,data(4,1),data(1,1),'g');hold(handles.axes2,'on');%v—t 图像
wr_t=plot(handles.axes2,data(4,1),data(2,1),'r');%角速度*半径-t图像
x_t=plot(handles.axes3,data(4,1),data(3,1));%位移-t图像

set(handles.axes1,'YTick',[],'FontSize',8);
set(handles.axes2,'XTick',[],'FontSize',8);
set(handles.axes3,'XTick',[],'FontSize',8);
while ishandle(ball)
        k=0;
        i=1;
        caculater();
    while k~=1&&ishandle(ball)%如果k=1，说明用户更改过初始量，将跳出演示循环，重新计算最终量
         i=i+ZaShua.step;%计算时刻
        if i>=998%到一定时刻之后重新开始演示
            break;
        end
        if ishandle(v_t)%检测演示窗口是否被关闭，余下ishandle部分同理
            set(v_t,'Xdata',data(5,1:i),'Ydata',data(1,1:i));%更新v-t图像
        end
         if ishandle(wr_t)
             set(wr_t,'Xdata',data(5,1:i),'Ydata',data(2,1:i));%刷新角速度*半径—t 图像
         end
         if ishandle(x_t)
             set(x_t,'Xdata',data(5,1:i),'Ydata',data(6,1:i));%刷新位移-时间图像
         end
         if ishandle(ball)
            set(ball,'Xdata',ZaShua.r*ball_data(1,:)+data(6,i),'Ydata',ZaShua.r*ball_data(2,:)+ZaShua.r);%刷新圆盘位置
         end
         if ishandle(line)
            set(line,'Xdata',[data(6,i) data(6,i)+ZaShua.r*sin(data(4,i))],'Ydata'...%续下一行
                ,[ZaShua.r ZaShua.r+ZaShua.r*cos(data(4,i))]);%刷新球转角线
         end
        pause( ZaShua.dt);%暂停dt时间
    end
end
% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ZaShua;
if(str2double(get(handles.edit4,'String')))<0
    msgbox('该数值应大于 0');
    set(handles.edit4,'String',num2str(ZaShua.m));
end
% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ZaShua;
if(str2double(get(handles.edit5,'String')))<0
    msgbox('该数值应大于 0');
    set(handles.edit5,'String',num2str(ZaShua.u));
end
% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ZaShua;
if(str2double(get(handles.edit6,'String')))<0
    msgbox('该数值应大于 0');%重力加速度不可小于0
    set(handles.edit6,'String',num2str(ZaShua.g));
end
% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ZaShua;
if(str2double(get(handles.edit7,'String')))<0
    msgbox('该数值应大于 0');%半径不可小于0
    set(handles.edit7,'String',num2str(ZaShua.r));
end
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ZaShua k;
if (str2double(get(handles.edit4,'String')))>0&&str2double(get(handles.edit5,'String'))...%读取用户定义的初始量
        >0&&str2double(get(handles.edit6,'String'))>0&&str2double(get(handles.edit7,'String'))>0
    ZaShua.v_0=str2double(get(handles.edit2,'String'));
    ZaShua.w_0=str2double(get(handles.edit3,'String'));
    ZaShua.x_0=str2double(get(handles.edit1,'String'));
    ZaShua.r=str2double(get(handles.edit7,'String'));
    ZaShua.m=str2double(get(handles.edit4,'String'));
    ZaShua.u=str2double(get(handles.edit5,'String'));
    ZaShua.g=str2double(get(handles.edit6,'String'));
end
caculater();
k=1;%将标记变量置1

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ZaShua;
ZaShua.step=round(get(handles.slider1,'value'));
set(handles.text15,'String',[num2str(ZaShua.step),'x']);
set(handles.slider1,'value',ZaShua.step);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function caculater()%根据初始量计算最终量
global ZaShua data xn;
    ZaShua.t_1=(ZaShua.w_0*ZaShua.r-ZaShua.v_0)/(-3*ZaShua.u*ZaShua.g);%滑动结束需要的时间
    if ZaShua.t_1<0     %小于0说明角速度过大
            ZaShua.t_2=0-ZaShua.t_1;
    else
        ZaShua.t_2=ZaShua.t_1;
    end
    
    ZaShua.dt=ZaShua.t_2/400;%时间步长
ZaShua.a=ZaShua.u*ZaShua.g;ZaShua.t=0;
for i=1:1:1000
    ZaShua.t=ZaShua.t+ZaShua.dt;%计算时刻
    if ZaShua.t_1>0 && ZaShua.t<ZaShua.t_2%情况不同，角速度可能增加，减少或不变等
        data(1,i)=ZaShua.v_0-ZaShua.a*ZaShua.t;%计算速度
        data(2,i)=ZaShua.w_0+2*ZaShua.a*ZaShua.t/ZaShua.r;%计算角速度
        data(3,i)=ZaShua.x_0+(2*ZaShua.v_0-ZaShua.a*ZaShua.t)*ZaShua.t/2;%计算位移
        data(4,i)=(ZaShua.w_0+ZaShua.a*ZaShua.t/ZaShua.r)*ZaShua.t;%计算转角
    end
    %余下同理
    
    
    if ZaShua.t_1<0 && ZaShua.t<ZaShua.t_2
        data(1,i)=ZaShua.v_0+ZaShua.a*ZaShua.t;
        data(2,i)=ZaShua.w_0-2*ZaShua.a*ZaShua.t/ZaShua.r;
        data(3,i)=ZaShua.x_0+ZaShua.v_0*ZaShua.t+ZaShua.a*ZaShua.t^2/2;
        data(4,i)=(ZaShua.w_0-ZaShua.a*ZaShua.t/ZaShua.r)*ZaShua.t;
    end
    if ZaShua.t_1>=0 && ZaShua.t>=ZaShua.t_2
        data(1,i)=ZaShua.v_0-ZaShua.a*ZaShua.t_2;
        data(2,i)=ZaShua.w_0+2*ZaShua.a*ZaShua.t_2/ZaShua.r;
        data(3,i)=ZaShua.x_0+ZaShua.v_0*ZaShua.t_2-ZaShua.a*ZaShua.t_2^2/2+(ZaShua.v_0-ZaShua.a*ZaShua.t_2)*(ZaShua.t-ZaShua.t_2);
        data(4,i)=ZaShua.w_0*ZaShua.t_2+ZaShua.a*ZaShua.t_2^2/ZaShua.r+(ZaShua.w_0+2*ZaShua.a/ZaShua.r*ZaShua.t_2)*(ZaShua.t-ZaShua.t_2);
    end
    if ZaShua.t_1<=0 && ZaShua.t>=ZaShua.t_2
        data(1,i)=ZaShua.v_0+ZaShua.a*ZaShua.t_2;
        data(2,i)=ZaShua.w_0-2*ZaShua.a*ZaShua.t_2/ZaShua.r;
        data(3,i)=ZaShua.x_0+ZaShua.v_0*ZaShua.t_2+ZaShua.a*ZaShua.t_2^2/2+(ZaShua.v_0+ZaShua.a*ZaShua.t_2)*(ZaShua.t-ZaShua.t_2);
        data(4,i)=ZaShua.w_0*ZaShua.t_2-ZaShua.a*ZaShua.r*ZaShua.t_2^2/ZaShua.r+(ZaShua.w_0-2*ZaShua.a/ZaShua.r*ZaShua.t_2)*(ZaShua.t-ZaShua.t_2);
    end
   data(5,i)=ZaShua.t;
   data(2,i)=ZaShua.r*data(2,i);
end
   data(6,:)=xn*data(3,:);

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data xn;
xn=0.05*2^(get(handles.slider2,'value'));
c=num2str(xn);
set(handles.text16,'String',[c(1:3),'x']);
data(6,:)=xn*data(3,:);%获取位移倍率数据

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
