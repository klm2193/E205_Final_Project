function varargout = satelliteGUI(varargin)
% SATELLITEGUI MATLAB code for satelliteGUI.fig
%      SATELLITEGUI, by itself, creates a new SATELLITEGUI or raises the existing
%      singleton*.
%
%      H = SATELLITEGUI returns the handle to a new SATELLITEGUI or the handle to
%      the existing singleton*.
%
%      SATELLITEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SATELLITEGUI.M with the given input arguments.
%
%      SATELLITEGUI('Property','Value',...) creates a new SATELLITEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before satelliteGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to satelliteGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help satelliteGUI

% Last Modified by GUIDE v2.5 10-Dec-2014 23:23:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @satelliteGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @satelliteGUI_OutputFcn, ...
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


% --- Executes just before satelliteGUI is made visible.
function satelliteGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to satelliteGUI (see VARARGIN)

% Choose default command line output for satelliteGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes satelliteGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = satelliteGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function I_Callback(hObject, eventdata, handles)
% hObject    handle to I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I as text
%        str2double(get(hObject,'String')) returns contents of I as a double


% --- Executes during object creation, after setting all properties.
function I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I (see GCBO)
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

% clear plots
cla;

% define constants
r = 1; % rad
zeta = 1;
wn = 10; % rad/s
J = 2;
Jhat = 1;
thetar = r;
T = 0.01; % s
N = 1/T;
thetardot = 0;
mup = 10;
mud = 10;

P = J*wn^2;
D = J*2*zeta*wn;

I = get(handles.I, 'String');
I = str2double(I);
disturbance = get(handles.disturbance, 'String');
disturbance = str2double(disturbance);

% send variables to workspace
assignin('base', 'I', I);
assignin('base', 'disturbance', disturbance);
assignin('base', 'zeta', zeta);
assignin('base', 'wn', wn);
assignin('base', 'J', J);
assignin('base', 'Jhat', Jhat);
assignin('base', 'thetar', thetar);
assignin('base', 'thetardot', thetardot);
assignin('base', 'mup', mup);
assignin('base', 'mud', mud);
assignin('base', 'P', P);
assignin('base', 'D', D);

% run the simulation
tspan = [0:T:100];
[t,x,y] = sim('satelliteSim', tspan);
axes(handles.axes1);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,5),t,y(:,6))
title('PD Control System (\mu_P = 10, \mu_D = 10)')
xlabel('time (s)')
legend('\theta', 'P', 'D','\theta dot', 'u = J\theta double dot')


function disturbance_Callback(hObject, eventdata, handles)
% hObject    handle to disturbance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disturbance as text
%        str2double(get(hObject,'String')) returns contents of disturbance as a double


% --- Executes during object creation, after setting all properties.
function disturbance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disturbance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
