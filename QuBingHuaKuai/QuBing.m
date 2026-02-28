function varargout = QuBing(varargin)
% MATLAB 规定：运行函数文件时，默认执行「和文件名同名的主函数」；
% QUBING MATLAB code for QuBing.fig
%      QUBING, by itself, creates a new QUBING or raises the existing
%      singleton*.
%
%      H = QUBING returns the handle to a new QUBING or the handle to
%      the existing singleton*.
%
%      QUBING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUBING.M with the given input arguments.
%
%      QUBING('Property','Value',...) creates a new QUBING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QuBing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QuBing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QuBing

% Last Modified by GUIDE v2.5 25-Jul-2018 23:32:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QuBing_OpeningFcn, ...
                   'gui_OutputFcn',  @QuBing_OutputFcn, ...
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


% --- Executes just before QuBing is made visible.
% 这个函数是 GUI 显示在屏幕上之前 执行的初始化函数，相当于 GUI 的 "启动准备工作"。
function QuBing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QuBing (see VARARGIN)
global c;
set(handles.text9,'visible','off');
set(handles.text10,'visible','off');
set(handles.text14,'visible','off');
set(handles.text15,'visible','off');
set(handles.text16,'visible','off');
set(handles.text17,'visible','off');
set(handles.text18,'visible','off');
set(handles.text19,'visible','off');
set(handles.text20,'visible','off');
set(handles.text21,'visible','off');
set(handles.text22,'visible','off');
set(handles.text23,'visible','off');
set(handles.text24,'visible','off');
set(handles.text25,'visible','off');
set(handles.text26,'visible','off');
set(handles.edit1,'visible','off');
set(handles.edit2,'visible','off');
set(handles.edit3,'visible','off');
set(handles.edit4,'visible','off');
set(handles.edit5,'visible','off');
set(handles.pushbutton3,'visible','off');
c=[1 2 1 1 1];
% Choose default command line output for QuBing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QuBing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
% GUI 启动完成后的输出控制，负责向命令行返回数据，是 "结果返回阶段"。
function varargout = QuBing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global a;
a=1;
varargout{1} = handles.output;
%{
保留默认（输出 Figure 句柄）
优点：运行 GUI 后能拿到窗口句柄，方便后续通过句柄操作窗口（比如隐藏、关闭、修改属性）；
场景：需要在命令行中控制 GUI 窗口时适用。
%}

QuBIng_display1(handles.axes1,handles.axes2,handles.axes3);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
set(handles.pushbutton2,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.pushbutton1,'BackgroundColor',[1 1 1]);

set(handles.text9,'visible','on');
set(handles.text10,'visible','on');
set(handles.text14,'visible','on');
set(handles.text15,'visible','on');
set(handles.text16,'visible','on');
set(handles.text17,'visible','on');
set(handles.text18,'visible','on');
set(handles.text19,'visible','on');
set(handles.text20,'visible','on');
set(handles.text21,'visible','on');
set(handles.text22,'visible','on');
set(handles.text23,'visible','on');
set(handles.text24,'visible','on');
set(handles.text25,'visible','on');
set(handles.text26,'visible','on');
set(handles.pushbutton3,'visible','on');
set(handles.edit1,'visible','on');
set(handles.edit2,'visible','on');
set(handles.edit3,'visible','on');
set(handles.edit4,'visible','on');
set(handles.edit5,'visible','on');

set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
set(handles.text4,'visible','off');
set(handles.text5,'visible','off');
set(handles.text6,'visible','off');
set(handles.text7,'visible','off');
set(handles.slider1,'visible','off');
a=0;
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.pushbutton2,'BackgroundColor',[1 1 1]);

cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
set(handles.text9,'visible','off');
set(handles.text10,'visible','off');
set(handles.text14,'visible','off');
set(handles.text15,'visible','off');
set(handles.text16,'visible','off');
set(handles.text17,'visible','off');
set(handles.text18,'visible','off');
set(handles.text19,'visible','off');
set(handles.text20,'visible','off');
set(handles.text21,'visible','off');
set(handles.text22,'visible','off');
set(handles.text23,'visible','off');
set(handles.text24,'visible','off');
set(handles.text25,'visible','off');
set(handles.text26,'visible','off');
set(handles.edit1,'visible','off');
set(handles.edit2,'visible','off');
set(handles.edit3,'visible','off');
set(handles.edit4,'visible','off');
set(handles.edit5,'visible','off');
set(handles.pushbutton3,'visible','off');

set(handles.axes1,'visible','on');
set(handles.axes2,'visible','on');
set(handles.axes3,'visible','on');
set(handles.text4,'visible','on');
set(handles.text5,'visible','on');
set(handles.text6,'visible','on');
set(handles.text7,'visible','on');
set(handles.slider1,'visible','on');
set(handles.slider1,'value',8);
global a;
a=1;
QuBIng_display1(handles.axes1,handles.axes2,handles.axes3);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global st;
st=floor(get(hObject,'value'));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
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



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global c;
c(1)=str2double(get(handles.edit1,'string'));

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
global c;
c(2)=str2double(get(handles.edit2,'string'));

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
global c;
c(3)=str2double(get(handles.edit3,'string'));

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
global c;
c(4)=str2double(get(handles.edit4,'string'));

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
global c;
c(5)=str2double(get(handles.edit5,'string'));

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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c;
if c(1)>c(2)
    msgbox('连杆长度应大于等于曲柄长度！');
else
x=QuBing_calculator(c );
set(handles.text23,'String',x(1));
set(handles.text24,'String',x(2));
set(handles.text25,'String',x(3));
set(handles.text26,'String',x(4));
end
