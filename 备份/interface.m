function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes propert    y application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 22-May-2019 18:53:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=handles.str;
[x,Fs]=audioread(str);
handles.x=x;
guidata(hObject,handles)
axes(handles.axes1);
plot(x);title('Original speech');
hold on
t=(0:length(x)-1)/Fs;
noise=[0.03*cos(2*pi*200*t)]';  %噪声为500kHz的余弦信号
x_n=x+noise;
handles.x_n=x_n;
guidata(hObject,handles)
axes(handles.axes2);
plot(x_n);title('Speech with noise');
hold on



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=handles.x;
x_n=handles.x_n;
[n1,n2,z,e]=vad(x);
axes(handles.axes1);
plot([n1,n1],[-0.5,0.5]);
hold on
plot([n2,n2],[-0.5,0.5]);
hold off
handles.n1=n1;
guidata(hObject,handles)
handles.n2=n2;
guidata(hObject,handles)
[n3,n4,z_n,e_n]=vad(x_n);
handles.z_n=z_n;
guidata(hObject,handles)
handles.e_n=e_n;
guidata(hObject,handles)
handles.n3=n3;
guidata(hObject,handles)
handles.n4=n4;
guidata(hObject,handles)
axes(handles.axes2);
plot([n3,n3],[-0.5,0.5]);
hold on
plot([n4,n4],[-0.5,0.5]);
hold off



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z_n=handles.z_n;
e_n=handles.e_n;
axes(handles.axes3);
plot(z_n);title('Zero crossing rate');
axes(handles.axes4);
plot(e_n);title('Speech power');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% path = 'D:\研究生\语音信号处理\project';
% dir = './speech/';
% files = ls(dir);
% mfcc_coe = zeros(12,length(files));
% for i = 3:size(files,1)
%     speech = audioread([dir,files(i,:)]);
%     [start_point,end_point]=vad(speech);
%     mfcc_coe(:,i) = mfcc(speech(start_point:end_point));
% end
% mfcc_coe = mfcc_coe(1:12,3:7);
% handles.mfcc_coe=mfcc_coe;
% guidata(hObject,handles)
% 
% open('output1.fig')
% h=guihandles;
% set(h.output,'string','提取特征结束');
n1=handles.n1;
n2=handles.n2;
n3=handles.n3;
n4=handles.n4;
axes(handles.axes1);
plot([n1,n1],[-0.5,1]);
hold on
plot([n2,n2],[-0.5,1]);
hold off
axes(handles.axes2);
plot([n3,n3],[-0.5,1]);
hold on
plot([n4,n4],[-0.5,1]);
hold off





% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = 'D:\研究生\语音信号处理\project';
dir = './speech/';
files = ls(dir);
mfcc_coe = zeros(12,length(files));
for i = 3:size(files,1)
    speech = audioread([dir,files(i,:)]);
    [start_point,end_point]=vad(speech);
    mfcc_coe(:,i) = mfcc(speech(start_point:end_point));
end
mfcc_coe = mfcc_coe(1:12,3:7);
% handles.mfcc_coe=mfcc_coe;
% guidata(hObject,handles)

% open('output1.fig')
% h=guihandles;
% set(h.output,'string','提取特征结束');
n3=handles.n3;
n4=handles.n4;
x_n=handles.x_n;
% mfcc_coe=handles.mfcc_coe;
test_mfcc_coe = mfcc(x_n(n3:n4));
distance = zeros(5,1);
for i = 1:5
    distance(i) = dtw(mfcc_coe(:,i),test_mfcc_coe);
end

min_distance = min(distance);
result = find(distance==min_distance);
handles.result=result;
guidata(hObject,handles)

open('output2.fig')
h=guihandles;
set(h.output,'string','识别结束');




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile('*.mp3','speech');
str=[pathname filename];
handles.str=str;
guidata(hObject,handles)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result=handles.result;
switch result
    case 1
        set(handles.text2,'string',num2str('The speech is a.mp3'))
        %fprintf('The speech is a.mp3')
    case 2
        set(handles.text2,'string',num2str('The speech is hi.mp3'))
        %fprintf('The speech is hi.mp3')
    case 3
        set(handles.text2,'string',num2str('The speech is mom.mp3'))
        %fprintf('The speech is mom.mp3')
    case 4
        set(handles.text2,'string',num2str('The speech is o.mp3'))
        %fprintf('The speech is o.mp3')
    case 5
        set(handles.text2,'string',num2str('The speech is u.mp3'))
        %fprintf('The speech is u.mp3')
end
