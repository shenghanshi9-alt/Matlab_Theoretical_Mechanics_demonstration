function varargout = QuBingHuaDao(varargin)
% QUBINGHUADAO MATLAB code for QuBingHuaDao.fig
%      QUBINGHUADAO, by itself, creates a new QUBINGHUADAO or raises the existing
%      singleton*.
%
%      H = QUBINGHUADAO returns the handle to a new QUBINGHUADAO or the handle to
%      the existing singleton*.
%
%      QUBINGHUADAO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUBINGHUADAO.M with the given input arguments.
%
%      QUBINGHUADAO('Property','Value',...) creates a new QUBINGHUADAO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QuBingHuaDao_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QuBingHuaDao_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QuBingHuaDao

% Last Modified by GUIDE v2.5 17-Apr-2019 11:19:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QuBingHuaDao_OpeningFcn, ...
                   'gui_OutputFcn',  @QuBingHuaDao_OutputFcn, ...
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


% --- Executes just before QuBingHuaDao is made visible.
function QuBingHuaDao_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QuBingHuaDao (see VARARGIN)

% Choose default command line output for QuBingHuaDao
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QuBingHuaDao wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QuBingHuaDao_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kk dt kk2 w h;%全局变量
dt=3;
set(handles.slider1,'value',dt);%岩石速度滑块初始位置

data1=data;
data1.start(1,1.2);%初始化，T形杆宽1，高1.2
data1.caculater();%计算
t=data1.t;
N=data1.N;
T_x=data1.T_x2;     T_y=data1.T_y2;%T形杆数据矩阵，行为形态数据，列为时间数据，其他构件于此相同
OA_x=data1.OA_x2;   OA_y=data1.OA_y2;
HuaTao_x=data1.HuaTao_x2;   HuaTao_y=data1.HuaTao_y2;
a_x=data1.a_x4;a_y=data1.a_y4;v_x=data1.v_x4;v_y=data1.v_y4;

GuiJi=plot(handles.axes1,T_x(:,3),T_y(:,3),'color','k','LineStyle',':');hold(handles.axes1,'on');
OA=plot(handles.axes1,OA_x(1,:),OA_y(1,:),'marker','o','color','g');%%画出OA杆
T_Gan=plot(handles.axes1,T_x(1,:),T_y(1,:),'marker','.','color','b','linewidth',2);
HuaTao=plot(handles.axes1,HuaTao_x(1,:),HuaTao_y(1,:),'marker','.','color','r','linewidth',4);
Zhi=plot(handles.axes1,1,0,'marker','o','color','k');%画出OA的支座O
set(handles.axes1,'xlim',[-3 5],'ylim',[-4 4]*0.672,'XTick',[],'YTick',[]);
set(handles.axes2,'XTick',[]);
set(handles.axes3,'XTick',[]);

hold(handles.axes2,'on');ax=plot(handles.axes2,t,a_x,'r');vx=plot(handles.axes2,t,v_x,'g');%x向速速加速度曲线
axt=plot(handles.axes2,t,a_x,'color','r','Marker','o');vxt=plot(handles.axes2,t,v_x,'color','g','Marker','o');%x向速速加速度曲线标记点
hold(handles.axes3,'on');ay=plot(handles.axes3,t,a_y,'r');vy=plot(handles.axes3,t,v_y,'g');%y向速速加速度曲线
ayt=plot(handles.axes3,t,a_y,'color','r','Marker','o');vyt=plot(handles.axes3,t,v_y,'color','g','Marker','o');%y向速速加速度曲线标记点



kk=1;%相对坐标系选择标志
kk1=2;%相对坐标系选择辅助标志
kk2=0;%重新计算所有数据标志
i=1;%循环变量
dt=3;%演示速度调节变量

while ishandle(GuiJi)
    i=i+dt;
    if i>N||kk~=kk1||kk2~=0
        if i>N
            i=1;
        end
        if kk~=kk1||kk2~=0
            if kk2~=0
                data1.start(w,h);
                data1.caculater();
                kk2=0;
                
            end
            kk1=kk;
            switch kk  %根据kk值，选择不同的演示数据
                case 4  %T杆为参考
                     T_x=data1.T_x2;     T_y=data1.T_y2;
                      OA_x=data1.OA_x2;   OA_y=data1.OA_y2;
                      HuaTao_x=data1.HuaTao_x2;   HuaTao_y=data1.HuaTao_y2;
                       a_y=t*0;v_y=t*0; a_x=t*0;v_x=t*0;
                case 3%滑套为参考
                     T_x=data1.T_x3;     T_y=data1.T_y3;
                      OA_x=data1.OA_x3;   OA_y=data1.OA_y3;
                      HuaTao_x=data1.HuaTao_x3;   HuaTao_y=data1.HuaTao_y3;
                      a_y=-sin(t);v_y=cos(t); a_x=t*0;v_x=t*0;
                case 2%OA为参考
                     T_x=data1.T_x4;     T_y=data1.T_y4;
                      OA_x=data1.OA_x4;   OA_y=data1.OA_y4;
                      HuaTao_x=data1.HuaTao_x4;   HuaTao_y=data1.HuaTao_y4;
                      a_x=data1.a_x4;a_y=data1.a_y4;v_x=data1.v_x4;v_y=data1.v_y4;
                case 1%一般定系为参考
                     T_x=data1.T_x6;     T_y=data1.T_y6;
                      OA_x=data1.OA_x6;   OA_y=data1.OA_y6;
                      HuaTao_x=data1.HuaTao_x6;   HuaTao_y=data1.HuaTao_y6;
                      a_x=cos(t);v_x=-sin(t); a_y=t*0;v_y=t*0;
            end
            set(GuiJi,'xdata',T_x(:,2),'ydata',T_y(:,2));%重绘轨迹及速度、加速度曲线
            set(ax,'ydata',a_x); set(ay,'ydata',a_y);
            set(vx,'ydata',v_x); set(vy,'ydata',v_y);
        end
    end
         set(T_Gan,'xdata',T_x(i,:),'ydata',T_y(i,:));%刷新图形
         set(HuaTao,'xdata',HuaTao_x(i,:),'ydata',HuaTao_y(i,:));
         set(OA,'xdata',OA_x(i,:),'ydata',OA_y(i,:));
         set(Zhi,'xdata',OA_x(i,2),'ydata',OA_y(i,2));
         set(axt,'xdata',t(i),'ydata',a_x(i)); set(ayt,'xdata',t(i),'ydata',a_y(i));
         set(vxt,'xdata',t(i),'ydata',v_x(i)); set(vyt,'xdata',t(i),'ydata',v_y(i));
         pause(0.04);
    
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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global dt;
dt1=get(handles.slider1,'value');
dt=round(dt1);
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


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kk;
kk=get(handles.popupmenu1,'value')
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global w h kk2;
w1=str2double(get(handles.edit1,'String'));
h1=str2double(get(handles.edit2,'String'));
if  (w1<1)||(w1>3)||(h1<1)||(h1>3)
    msgbox('长度与宽度宜取1~3');
else
    w=w1;
    h=h1;
    kk2=1;
end
