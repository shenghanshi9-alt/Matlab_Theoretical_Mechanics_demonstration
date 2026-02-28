function varargout = MoCaXiShu(varargin)
% MOCAXISHU MATLAB code for MoCaXiShu.fig
%      MOCAXISHU, by itself, creates a new MOCAXISHU or raises the existing
%      singleton*.
%
%      H = MOCAXISHU returns the handle to a new MOCAXISHU or the handle to
%      the existing singleton*.
%
%      MOCAXISHU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOCAXISHU.M with the given input arguments.
%
%      MOCAXISHU('Property','Value',...) creates a new MOCAXISHU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MoCaXiShu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MoCaXiShu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MoCaXiShu

% Last Modified by GUIDE v2.5 29-Jan-2019 14:18:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MoCaXiShu_OpeningFcn, ...
    'gui_OutputFcn',  @MoCaXiShu_OutputFcn, ...
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


% --- Executes just before MoCaXiShu is made visible.
function MoCaXiShu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MoCaXiShu (see VARARGIN)

% Choose default command line output for MoCaXiShu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MoCaXiShu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MoCaXiShu_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a l t data1 k u d A X;
a=30;       l=2;        t=0.00001;        k=1;        d=3;
T=0;        X=0;        g=9.8;           k1=1;        dt=0;
t1=0;       t2=0;       t1_1=0;        t2_1=0;
%a 倾角    L滑块初始位置          t时间步长     k标记变量   d滑块长度   A加速度
%T时刻      X位移                         k1 光电门标记变量   dt计数变量
%t1、t2 进入、离开光电门的时刻，t1-1、t2-1经过光电门的时间

data1=MoCa_data;%见data.m文件，data为类，包含所需的大部分函数
GuiDao_data=data1.GuiDao_s(a);     %轨道
GuiDao=plot(GuiDao_data(1,:),GuiDao_data(2,:),'Color','k','linewidth',2);hold on;
set(handles.axes1,'Xlim',[0 35],'Ylim',[-7.82 20],'Xtick',[],'Ytick',[]);
ShuiPing_data=data1.ShuiPing_s();       %水平面
ShuiPing=plot(ShuiPing_data(1,:),ShuiPing_data(2,:),'Color','k');
GuangDian_data=data1.GuangDian_s(a);%光电门
GuangDian=plot(GuangDian_data(1,:),GuangDian_data(2,:),'Color','k','linewidth',2,'Linestyle',':');
HuaKuai_data=data1.HuaKuai_s(27,a,d*0.6);   %滑块
HuaKui= plot(HuaKuai_data(1, : ),HuaKuai_data(2, : ),'Color','r');
u=0.1;%rand(1,1);
A=data1.A(u,g,a);

while k==1
    if ishandle(HuaKui)~=1%如果滑块对象不存在，说明窗口已经被关闭，标记变量k置0，退出程序
        k=0;
    end
    
    if X>44%每次滑动到结尾，进行一次重置并刷新轨道等图像
        X=0;
        T=0;k1=1;
        if ishandle(handles.edit6)==1
            set(handles.edit6,'String',num2str(data1.U(t1_1,t2_1,30,9.8,a,d)));%计算速度并显示
        end
        GuiDao_data=data1.GuiDao_s(a);     %获取新的轨道数据
        GuangDian_data=data1.GuangDian_s(a);%光电门数据
        pause(1);
        HuaKuai_data=data1.HuaKuai_s((45-X)/30*18,a,d*0.6);   %滑块数据
        if ishandle(HuaKui)==1
            set(HuaKui,'Xdata',HuaKuai_data(1, : ),'Ydata',HuaKuai_data(2, : ));%刷新图形
            set(GuiDao,'Xdata',GuiDao_data(1,:),'Ydata',GuiDao_data(2,:));
            set(GuangDian,'Xdata',GuangDian_data(1,:),'Ydata',GuangDian_data(2,:));
        end
        pause(1);
    end
    
    dt=dt+1;
    X=T^2*A/2;%计算位位移
    T=T+t;
    
    if dt>200%如果时间超过200，对滑块位置进行重置
        HuaKuai_data=data1.HuaKuai_s((45-X)/30*18,a,d*0.6);   %滑块
        if ishandle(HuaKui)==1
            set(HuaKui,'Xdata',HuaKuai_data(1, : ),'Ydata',HuaKuai_data(2, : ));
        end
        pause(0.01);
        dt=0;
    end
    
    if X>=5-d/2&&k1==1%进入第一个光电门
        k1=2;%记录下已经经进入第一个光电门
        t1=T;%记录下此时刻
        if ishandle(handles.edit4)==1
            set(handles.edit4,'String',num2str(t1));%显示t1
        end
    end
    
    if X>=5+d/2&&k1==2%离开第一个光电门
        k1=3;
        t2=T;
        t1_1=t2-t1;
        if ishandle(handles.edit5)==1
            set(handles.edit5,'String',num2str(t2));
        end
    end
    
    if X>=35-d/2&&k1==3%进入第二个光电门
        t1=T;
        k1=4;
        if ishandle(handles.edit7)==1
            set(handles.edit7,'String',num2str(t1));
        end
    end
    
    if X>=35+d/2&&k1==4%离开第二个光电门
        k1=0;
        t2=T;
        t2_1=t2-t1;%计算时间差
        if ishandle(handles.edit8)==1
            set(handles.edit8,'String',num2str(t2));
        end
    end
end
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function    pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global u a  d data1 A X;
if str2double(get(handles.edit3,'String'))==-1
    u=rand(1,1);%用户输入u=-1时，生成随机数
else if str2double(get(handles.edit3,'String'))>0&&1>str2double(get(handles.edit3,'String'))
        u=str2double(get(handles.edit3,'String'));%输入为0-1时取用户输入的值
    else
        msgbox('摩擦因数应介于0与1之间');%输入错误时发出提示
    end
end
if str2double(get(handles.edit1,'String'))>0&&90>str2double(get(handles.edit1,'String'))
    a=str2double(get(handles.edit1,'String'));%如果倾角为0-90，取用户输入的值
else
    msgbox('导轨倾角应介于0与90度之间');%否则发出提示
end
if str2double(get(handles.edit2,'String'))>1&&10>str2double(get(handles.edit2,'String'))
    d=str2double(get(handles.edit2,'String'));%如果滑块长度合适，取用户输入的值，否则提示
else
    msgbox('滑块宽度应在适当范围内');
end
A=data1.A(u,9.8,a);%计算加速度
X=45;%位移置为最大，结束当前仿真并进行刷新


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



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
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
