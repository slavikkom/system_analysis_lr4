function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 04-Dec-2016 18:15:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N X1 X2 X3 Y t
N = 1313;
fid=fopen(strcat('../data/', strcat(get(handles.edit3, 'String'),'.txt')));
X1_t=textscan(fid,'%n%n%n%n%n',N);
fclose(fid);

fid=fopen(strcat('../data/', strcat(get(handles.edit4, 'String'),'.txt')));
X2_t=textscan(fid,'%n%n%n',N);
fclose(fid);

fid=fopen(strcat('../data/', strcat(get(handles.edit5, 'String'),'.txt')));
X3_t=textscan(fid,'%n%n%n%n',N);
fclose(fid);

fid=fopen(strcat('../data/', strcat(get(handles.edit6, 'String'),'.txt')));
Y_t=textscan(fid,'%n%n%n%n',N);
fclose(fid);
X1 = zeros(N,4);
X2 = zeros(N,2);
X3 = zeros(N,3);
Y = zeros(N,3);

for i = 1:4
    X1(:,i) = X1_t{1,i+1}(:);
end
for i = 1:2
    X2(:,i) = X2_t{1,i+1}(:);
end
for i = 1:3
    X3(:,i) = X3_t{1,i+1}(:);
end
for i = 1:3
    Y(:,i) = Y_t{1,i+1}(:);
end
t = Y_t{1,1}(:);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N X1 X2 X3 Y t q1 q2 q3 qY qN p1 p2 p3

global stop
stop = 0;
set(handles.pushbutton7,'Enable','on');

Y_N = ones(N,3);
Y_N(:,1)=Y_N(:,1)*11.7;
Y_N(:,2)=Y_N(:,2)*1;
Y_N(:,3)=Y_N(:,3)*11.7;
Y_C = ones(N,3);
Y_C(:,1)=Y_C(:,1)*10.9;
Y_C(:,2)=Y_C(:,2)*0.55;
Y_C(:,3)=Y_C(:,3)*10.9;
Y_A = ones(N,3);
Y_A(:,1)=Y_A(:,1)*10.5;
Y_A(:,2)=Y_A(:,2)*0;
Y_A(:,3)=Y_A(:,3)*10.5;

R = ones(N,3);
r = zeros(N,1);
R_L = zeros(N,1);
for i=1:N
R(i,1)=Risk(Y(i,1),Y_A(i,1),Y_N(i,1));
R(i,2)=Risk(Y(i,2),Y_A(i,2),Y_N(i,2));
R(i,3)=Risk(Y(i,3),Y_A(i,3),Y_N(i,3));

[ r(i) R_L(i) ] = Risk_Level(R(i,:));
end
T = t/10;
string1 = get(handles.edit1, 'String');
string2 = get(handles.edit7, 'String');
string3 = get(handles.edit8, 'String');
T_max = str2double(string1);
T_min = str2double(string2);
duration = str2double(string3);

%{    
subplot(3,10,3:4); % 1:2
    plot(T(T_min:T_max),Y(T_min:T_max,1),T(T_min:T_max),Y_N(T_min:T_max,1),T(T_min:T_max),Y_C(T_min:T_max,1),T(T_min:T_max),Y_A(T_min:T_max,1))
    title('������� �����')
subplot(3,10,6:7); % 4:5
    plot(T(T_min:T_max),Y(T_min:T_max,2),T(T_min:T_max),Y_N(T_min:T_max,2),T(T_min:T_max),Y_C(T_min:T_max,2),T(T_min:T_max),Y_A(T_min:T_max,2))
    title('г���� ������')
subplot(3,10,9:10); % 7:8
    plot(T(T_min:T_max),Y(T_min:T_max,3),T(T_min:T_max),Y_N(T_min:T_max,3),T(T_min:T_max),Y_C(T_min:T_max,3),T(T_min:T_max),Y_A(T_min:T_max,3))
    title('������� ������������� ������')
subplot(3,10,13:14);
    plot(T(T_min:T_max),R(T_min:T_max,1))
subplot(3,10,16:17);
    plot(T(T_min:T_max),R(T_min:T_max,2))
subplot(3,10,19:20);
    plot(T(T_min:T_max),R(T_min:T_max,3))
%}

    
%


for i = T_min:T_max
    pause(duration);
    if (stop == 1)
        break;
    end
    if ((i > 50) && (get(handles.checkbox2, 'Value') == 1))
        subplot(3,10,23.5:24.5); % 1:2
            plot(T(T_min:i+10),[Y(T_min:i,1);  Forecast( Y( i - 50 : i, 1))],...
                T(T_min:i+10),Y_N(T_min:i+10,1),T(T_min:i+10),Y_C(T_min:i+10,1),T(T_min:i+10),Y_A(T_min:i+10,1))
            hold on
            plot(T(i),Y(i,1),'*')
            title('Network voltage')
        subplot(3,10,26.25:27.25); % 4:5
            plot(T(T_min:i+10),[Y(T_min:i,2);  Forecast( Y( i - 50 : i, 2))],...
                T(T_min:i+10),Y_N(T_min:i+10,2),T(T_min:i+10),Y_C(T_min:i+10,2),T(T_min:i+10),Y_A(T_min:i+10,2))
            hold on
            plot(T(i),Y(i,2),'*')
            title('Fuel level')
        subplot(3,10,29:30); % 7:8
            plot(T(T_min:i+10),[Y(T_min:i,3);  Forecast( Y( i - 50 : i, 3))],...
                T(T_min:i+10),Y_N(T_min:i+10,3),T(T_min:i+10),Y_C(T_min:i+10,3),T(T_min:i+10),Y_A(T_min:i+10,3))
            hold on
            plot(T(i),Y(i,3),'*')
            title('Battery voltage')
        subplot(3,10,13.5:14.5);
            plot(T(T_min:i+10),R(T_min:i+10,1))
            hold on
            plot(T(i),R(i,1),'*')
            title('Network voltage Risk')
        subplot(3,10,16.25:17.25);
            plot(T(T_min:i+10),R(T_min:i+10,2))
            hold on
            plot(T(i),R(i,2),'*')
            title('Fuel level Risk')
        subplot(3,10,19:20);
            plot(T(T_min:i+10),R(T_min:i+10,3))
            hold on
            plot(T(i),R(i,3),'*')
            title('Battery voltage Risk') 
    else
        subplot(3,10,23.5:24.5); % 1:2
            plot(T(T_min:i),Y(T_min:i,1),T(T_min:i),Y_N(T_min:i,1),T(T_min:i),Y_C(T_min:i,1),T(T_min:i),Y_A(T_min:i,1))
            title('Network voltage')
        subplot(3,10,26.25:27.25); % 4:5
            plot(T(T_min:i),Y(T_min:i,2),T(T_min:i),Y_N(T_min:i,2),T(T_min:i),Y_C(T_min:i,2),T(T_min:i),Y_A(T_min:i,2))
            title('Fuel level')
        subplot(3,10,29:30); % 7:8
            plot(T(T_min:i),Y(T_min:i,3),T(T_min:i),Y_N(T_min:i,3),T(T_min:i),Y_C(T_min:i,3),T(T_min:i),Y_A(T_min:i,3))
            title('Battery voltage')
        subplot(3,10,13.5:14.5);
            plot(T(T_min:i),R(T_min:i,1))
            title('Network voltage Risk')
        subplot(3,10,16.25:17.25);
            plot(T(T_min:i),R(T_min:i,2))
            title('Fuel level Risk')
        subplot(3,10,19:20);
            plot(T(T_min:i),R(T_min:i,3))
            title('Battery voltage Risk')    
    end
    
    set(handles.text2, 'String', int2str(i));
    if R_L(i)==0 
        F_State = 'Normally state';
        set(handles.uitable3,'BackgroundColor',[1, 0.81, 0.86]);
    else 
        F_State = 'Emergency situation';
        set(handles.uitable3,'BackgroundColor',[1, 0.21, 0.43]);
    end
    Probab = strcat(num2str(round(r(i)*100)),'%');
    Level = R_L(i);
    
    Problem = ' ';

    if R(i,1)>0
        Problem = strcat(Problem, 'Low network voltage; ');
    end
    if R(i,2)>0
        Problem = strcat(Problem, 'Low fuel level; ');
    end
    if R(i,3)>0
        Problem = strcat(Problem, 'Low battety voltage; ');
    end
    
        
    
    dat(i,:)={T(i), Y(i,1), Y(i,2), Y(i,3), F_State,Probab, Problem, Level};
    set(handles.uitable3 ,'Data', flipud(dat)); 
    if ((i > 50) && (get(handles.checkbox2, 'Value') == 1))
        subplot(3, 10, 11:12); % 4:5
            plot(T(T_min:i+10), R_L(T_min:i+10));
            hold on
            plot(T(i), R_L(i), '*')
            title('Risk level')
    else
        subplot(3, 10, 11:12); % 4:5
            plot(T(T_min:i), R_L(T_min:i));
            title('Risk level')
    end
    q1 = 4;
    q2 = 2;
    q3 = 3;
    qY = 3;
    qN = 50;
    p1 = 4;
    p2 = 4;
    p3 = 4;
    
    %Future = Forecast( Y( i - 50 : i, 1));

    
    if ((i > 50) && (get(handles.checkbox1, 'Value') == 1))
        %dlmwrite('result.txt', 33);
        X1_50 = X1( i - 50 : i,:);
        X2_50 = X2( i - 50 : i,:);
        X3_50 = X3( i - 50 : i,:);
        Y_50 = Y( i - 50 : i,:);
        Restore(X1_50, X2_50, X3_50, Y_50, i);
        %dlmwrite('result.txt', 'Succesful','-append');
        %print A
        %print C
    end
    
end
%set(handles.uitable3 ,'Data',dat); 
%
%
%tt=timer('ExecutionMode', 'fixedDelay', 'Period', 0.5, 'TasksToExecute', 2, 'TimerFcn', 'dummy=1;');
%j=0;
%{
while j < T_max-50
    j=j+1;
    start(tt);
    X1_50 = X1( j : j+qN,:);
    X2_50 = X2( j : j+qN,:);
    X3_50 = X3( j : j+qN,:);
    Y_50 = Y( j : j+qN,:);
    Restore(X1_50, X2_50, X3_50, Y_50);
    X1_10 = [Forecast(X1_50,1) Forecast(X1_50,2) Forecast(X1_50,3) Forecast(X1_50,4) ];
    X2_10 = [Forecast(X2_50,1) Forecast(X2_50,2) ];
    X3_10 = [Forecast(X3_50,1) Forecast(X3_50,2) Forecast(X3_50,3) ];
    Y_rest = F_restored(X1_10, X2_10, X3_10);

    N_save = N;
    Y_save = Y;
    Y = Y_rest;
    N = 10;
    Y_N = ones(N,3);
    Y_N(:,1)=Y_N(:,1)*11.7;
    Y_N(:,2)=Y_N(:,2)*1;
    Y_N(:,3)=Y_N(:,3)*11.7;
    Y_C = ones(N,3);
    Y_C(:,1)=Y_C(:,1)*10.9;
    Y_C(:,2)=Y_C(:,2)*0.55;
    Y_C(:,3)=Y_C(:,3)*10.9;
    Y_A = ones(N,3);
    Y_A(:,1)=Y_A(:,1)*10.5;
    Y_A(:,2)=Y_A(:,2)*0;
    Y_A(:,3)=Y_A(:,3)*10.5;

    R = ones(N,3);
    r = zeros(N,1);
    R_L = zeros(N,1);
    for i=1:N
    R(i,1)=Risk(Y(i,1),Y_A(i,1),Y_N(i,1));
    R(i,2)=Risk(Y(i,2),Y_A(i,2),Y_N(i,2));
    R(i,3)=Risk(Y(i,3),Y_A(i,3),Y_N(i,3));

    [ r(i) R_L(i) ] = Risk_Level(R(i,:));
    end
    T = t/10;
    string1 = get(handles.edit1, 'String');
    T_max = str2double(string1);

    subplot(3,10,3);
        plot(T(j+1:j+10),Y(1:10,1),T(j+1:j+10),Y_N(1:10,1),T(j+1:j+10),Y_C(1:10,1),T(j+1:j+10),Y_A(1:10,1))
    subplot(3,10,6);
        plot(T(j+1:j+10),Y(1:10,1),T(j+1:j+10),Y_N(1:10,1),T(j+1:j+10),Y_C(1:10,1),T(j+1:j+10),Y_A(1:10,1))
    subplot(3,10,9);
        plot(T(j+1:j+10),Y(1:10,1),T(j+1:j+10),Y_N(1:10,1),T(j+1:j+10),Y_C(1:10,1),T(j+1:j+10),Y_A(1:10,1))

    subplot(3,10,13);
        plot(T(j+1:j+10),R(1:10,1))
    subplot(3,10,16);
        plot(T(j+1:j+10),R(1:10,1))
    subplot(3,10,19);
        plot(T(j+1:j+10),R(1:10,1))
    N = N_save;
    Y = Y_save;
    wait(tt);
    
    if (R(10)~=0)
        set(handles.pushbutton8,'BackgroundColor','red');
    else
        set(handles.pushbutton8,'BackgroundColor','green');
    end
    
    if (stop == 1)
        j = T_max-50+1;
    end
end 
  %}  
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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop
stop = 1;
set(handles.pushbutton7,'Enable','of');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitable3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
switch get(hObject, 'Value')
   case 1
      set(handles.edit3, 'String', strcat('X1_', 'Warn2_Fault'));
      set(handles.edit4, 'String', strcat('X2_', 'Warn2_Fault'));
      set(handles.edit5, 'String', strcat('X3_', 'Warn2_Fault'));
      set(handles.edit6, 'String', strcat('Y_', 'Warn2_Fault'));
   case 2
      set(handles.edit3, 'String', strcat('X1_', 'Norm'));
      set(handles.edit4, 'String', strcat('X2_', 'Norm'));
      set(handles.edit5, 'String', strcat('X3_', 'Norm'));
      set(handles.edit6, 'String', strcat('Y_', 'Norm'));
    case 3
      set(handles.edit3, 'String', strcat('X1_', 'Warn1'));
      set(handles.edit4, 'String', strcat('X2_', 'Warn1'));
      set(handles.edit5, 'String', strcat('X3_', 'Warn1'));
      set(handles.edit6, 'String', strcat('Y_', 'Warn1'));
    case 4
      set(handles.edit3, 'String', strcat('X1_', 'Warn2'));
      set(handles.edit4, 'String', strcat('X2_', 'Warn2'));
      set(handles.edit5, 'String', strcat('X3_', 'Warn2'));
      set(handles.edit6, 'String', strcat('Y_', 'Warn2'));
    case 5
      set(handles.edit3, 'String', strcat('X1_', 'Fault'));
      set(handles.edit4, 'String', strcat('X2_', 'Fault'));
      set(handles.edit5, 'String', strcat('X3_', 'Fault'));
      set(handles.edit6, 'String', strcat('Y_', 'Fault')); 
end
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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over popupmenu1.



function edit7_Callback(hObject, eventdata, handles)
set(handles.text2, 'String', get(hObject, 'String'));
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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
