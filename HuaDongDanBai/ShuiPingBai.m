function varargout = ShuiPingBai(varargin)
% SHUIPINGBAI MATLAB code for ShuiPingBai.fig
%      SHUIPINGBAI, by itself, creates a new SHUIPINGBAI or raises the existing
%      singleton*.
%
%      H = SHUIPINGBAI returns the handle to a new SHUIPINGBAI or the handle to
%      the existing singleton*.
%
%      SHUIPINGBAI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHUIPINGBAI.M with the given input arguments.
%
%      SHUIPINGBAI('Property','Value',...) creates a new SHUIPINGBAI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShuiPingBai_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShuiPingBai_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ShuiPingBai

% Last Modified by GUIDE v2.5 16-Apr-2019 16:48:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ShuiPingBai_OpeningFcn, ...
    'gui_OutputFcn',  @ShuiPingBai_OutputFcn, ...
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


% --- Executes just before ShuiPingBai is made visible.
function ShuiPingBai_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShuiPingBai (see VARARGIN)

% Choose default command line output for ShuiPingBai
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ShuiPingBai wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ShuiPingBai_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global data kk dt;%现实、标记、速度变量
set(handles.slider1,'value',10);%初始化滑动条
data= test1;
data.write_A(60);%摆幅60度
data.write_l(2);%杆长2米
t=data.t;%
HuaKuai_data=[-0.2 0.2 0.2 -0.2 -0.2;%滑块图形数据
    -0.1 -0.1 0.1 0.1 -0.1];
ShuiPing=data.ShuiPing_s();%水平面数据
ball_data=[sin(t);cos(t)]*0.2;%球图形数据
dt=10;
c_x=data.get_c_x();%滑块位移数组
c_y=data.get_c_y();
ball_x=data.get_ball_x();%摆锤位移数组
ball_y=data.get_ball_y();

fy=data.get_fy();%支反力
c_a=data.get_a_c();%滑块加速度
c_v=data.get_a_v();%滑块速度

line=plot(handles.axes1,ball_x(),ball_y(),'b');%杆
hold(handles.axes1,'on')
set(handles.axes1,'xlim',[-4 4],'ylim',[-4 4]*0.617-1,'XTick',[],'YTick',[]);
ball=plot(handles.axes1,ball_data(1,:),ball_data(2,:),'color','r');%摆锤
HuaKuai=plot(handles.axes1,HuaKuai_data(1,:),HuaKuai_data(2,:),'color','r');
GuiJi=plot(handles.axes1,ball_x(),ball_y(),'LineStyle',':','color','k');%摆锤轨迹
ShuiPingMian=plot(handles.axes1,ShuiPing(1,:)-1.9,ShuiPing(2,:)-0.11,'k');
forcet=plot(handles.axes2,t,fy,'g');hold(handles.axes2,'on');%支反力曲线
force=plot(handles.axes2,t,fy,'color','g','Marker','o');%支反力标记点

ca=plot(handles.axes3,t,c_a,'color','r','Marker','o');hold(handles.axes3,'on');%加速度标记点
cv=plot(handles.axes3,t,c_v,'color','g','Marker','o');%速度标记点
cx=plot(handles.axes3,t,c_x,'color','b','Marker','o');%位移标记点
cat=plot(handles.axes3,t,c_a,'r');%加速度曲线
cvt=plot(handles.axes3,t,c_v,'g');%速度曲线
cxt=plot(handles.axes3,t,c_x,'b');%位移曲线
legend(handles.axes3,'加速度','速度','位移');

set(handles.axes2,'xlim',[0 6.28],'XTick',[]);
set(handles.axes3,'xlim',[0 12],'XTick',[]);

i=1;
while ishandle(ball)
    i=i+dt;
    if i>628
        i=1;
    end
        set(line,'xdata',[c_x(i) ball_x(i)],'ydata',[c_y(i) ball_y(i)]);
        set(ball,'xdata',ball_data(1,:)+ball_x(i),'ydata',ball_data(2,:)+ball_y(i));
        set(HuaKuai,'xdata',HuaKuai_data(1,:)+c_x(i),'ydata',HuaKuai_data(2,:)+c_y(i));
        
        set(cx,'xdata',t(i),'ydata',c_x(i));
        set(cv,'xdata',t(i),'ydata',c_v(i));
        set(ca,'xdata',t(i),'ydata',c_a(i));
        set(force,'xdata',t(i),'ydata',fy(i));
        pause(0.04);
        if kk==1
            c_x=data.get_c_x();
            c_y=data.get_c_y();
            ball_x=data.get_ball_x();
            ball_y=data.get_ball_y();
            
            fy=data.get_fy();
            c_a=data.get_a_c();
            c_v=data.get_a_v();
            set(GuiJi,'xdata',ball_x,'ydata',ball_y);
            set(cat,'ydata',c_a);
            set(cvt,'ydata',c_v);
            set(cxt,'ydata',c_x);
            set(forcet,'ydata',fy);
            kk=0;
        end
end


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data kk;
len=str2double(get(handles.edit1,'String'));
m1=str2double(get(handles.edit2,'String'));
m2=str2double(get(handles.edit3,'String'));
p=str2double(get(handles.edit4,'String'));
if len>4||len<0.5
    msgbox('杆长不易为此值');
else
    data.write_l(len)
end
if m1<=0||m2<=0
    msgbox('质量应大于0');
else
    data.write_m(m1,m2)
end
if p>=90||p<=0
    msgbox('摆幅应介于0~90之间');
else
    data.write_A(p)
end
kk=1;

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global dt;
n=get(handles.slider1,'value');
dt=round(n);
set(handles.slider1,'value',dt);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
