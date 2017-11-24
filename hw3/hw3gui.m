function varargout = hw3gui(varargin)
%Weiheng Li for CSE411 hw3
%wel615@lehigh.edu
% HW3GUI MATLAB code for hw3gui.fig
%      HW3GUI, by itself, creates a new HW3GUI or raises the existing
%      singleton*.
%
%      H = HW3GUI returns the handle to a new HW3GUI or the handle to
%      the existing singleton*.
%
%      HW3GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW3GUI.M with the given input arguments.
%
%      HW3GUI('Property','Value',...) creates a new HW3GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hw3gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hw3gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hw3gui

% Last Modified by GUIDE v2.5 16-Nov-2017 00:25:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hw3gui_OpeningFcn, ...
                   'gui_OutputFcn',  @hw3gui_OutputFcn, ...
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


% --- Executes just before hw3gui is made visible.
function hw3gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hw3gui (see VARARGIN)

k=3;
handles.k=k;
d=5;
handles.d=d;
sep = 20;
handles.sep=sep;
startx = 10;
handles.startx = startx;
starty = 10;
handles.starty=starty;
nums = 30;
handles.nums=nums;
colors = ['r' 'g' 'b' 'y' 'm' 'c' 'w'];
handles.colors=colors;
for n=0:k-1
    a=startx+sep*n;
    b=starty+sep*n;
    x = d.*randn(nums,1) + a;
    y = d.*randn(nums,1) + b;
    if n == 0
        res = [x y];
    else
        res = [res;[x y]];
    end
end
handles.res=res;



% Choose default command line output for hw3gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hw3gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hw3gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.edit1,'String'); %edit1 being Tag of ur edit box
if isempty(x)
fprintf('Error: Enter Text first\n');
else
    k=x-'0';
    handles.k=k;
    guidata(hObject,handles);
% Write code for computation you want to do 
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.edit2,'String'); %edit1 being Tag of ur edit box
if isempty(x)
fprintf('Error: Enter Text first\n');
else
    k=handles.k;
    d=handles.d;
    sep = str2num(x);
    startx = handles.startx;
    starty = handles.starty;
    nums = handles.nums;
    for n=0:k-1
        disp(n)
        a=startx+sep*n;
        b=starty+sep*n;
        x = d.*randn(nums,1) + a;
        y = d.*randn(nums,1) + b;
        if n == 0
            res = [x y];
        else
            res = [res;[x y]];
        end
    end
    handles.res=res;
    
    
    
    handles.sep=sep;
    guidata(hObject,handles);
% Write code for computation you want to do 
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.edit3,'String'); %edit1 being Tag of ur edit box
if isempty(x)
fprintf('Error: Enter Text first\n');
else
    k=handles.k;
    d=str2num(x);
    sep = handles.sep;
    startx = handles.startx;
    starty = handles.starty;
    nums = handles.nums;
    for n=0:k-1
        disp(n)
        a=startx+sep*n;
        b=starty+sep*n;
        x = d.*randn(nums,1) + a;
        y = d.*randn(nums,1) + b;
        if n == 0
            res = [x y];
        else
            res = [res;[x y]];
        end
    end
    handles.res=res;
    
    
    
    handles.d=d;
    guidata(hObject,handles);
% Write code for computation you want to do 
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;

hold on;
res = handles.res;
disp(res);
num = length(res);

for i=1:num
    plot(res(i,1),res(i,2),'b','Marker','.','LineStyle','none');
end
hold off;




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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.edit4,'String'); %edit1 being Tag of ur edit box
if isempty(x)
fprintf('Error: Enter Text first\n');
else
    n=str2num(x);
    
    [x,y] = ginput(n);
    res =  handles.res;
    res = [res;[x,y]];
    handles.res = res;
    guidata(hObject,handles);
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clusters = handles.k;
res = handles.res;
num = length(res);
% initialize
index = randperm(num, clusters);
dis = zeros(num, clusters);
label = zeros(num, 1);
center = res(index, :);
step = 0;
colors = handles.colors;

while(1) 
   % save the centers for each clutters of last iteration
   pre_center = center;
   % calculate distance between data points and clutter centers
   for i = 1:num
       for j = 1:clusters
           dis(i, j) = norm(res(i,:) - center(j, :));
       end
   end
   % construct new clutters
   for i = 1:num
       label(i) = find(dis(i,:)==min(dis(i,:)));
   end
   % attain new centers
   for i = 1:clusters
       one_clutter = res(find(label==i), :);
       center(i, :) = mean(one_clutter);
   end
   % test the terminating condition
   if (center == pre_center)
       break;
   end
   step = step + 1;
end
hold on
for i=1:clusters
    plot(center(i,1),center(i,2),'k','Marker','*','LineStyle','none');
end
for i=1:num
    l = label(i);
    plot(res(i,1),res(i,2),colors(l),'Marker','.','LineStyle','none');
end
hold off



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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.edit2,'String'); %edit1 being Tag of ur edit box
if isempty(x)
fprintf('Error: Enter Text first\n');
else
    k=str2num(x);
    d=handles.d;
    sep =handles.sep;
    startx = handles.startx;
    starty = handles.starty;
    nums = handles.nums;
    for n=0:k-1
        disp(n)
        a=startx+sep*n;
        b=starty+sep*n;
        x = d.*randn(nums,1) + a;
        y = d.*randn(nums,1) + b;
        if n == 0
            res = [x y];
        else
            res = [res;[x y]];
        end
    end
    handles.res=res;
    
    
    
    handles.k=k;
    guidata(hObject,handles);
% Write code for computation you want to do 
end
