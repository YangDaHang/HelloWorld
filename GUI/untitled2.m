function varargout = untitled2(varargin)
% UNTITLED2 MATLAB code for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 23-Oct-2016 21:19:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
input = str2num(get(hObject,'String')); 
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles); 

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
range = str2num(get(hObject,'String')); 


if (isempty(range))
     set(hObject,'String','0')
end
guidata(hObject, handles); 


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

  


function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.range = str2num(get(handles.edit3,'String'));
cla
handles.e_bat1 = str2num(get(handles.edit4,'String'));
cla
[handles.data,handles.result]=km_cost_weight(handles.range);
cla
number=round((handles.e_bat1-24000)/1000);
%
guidata(hObject, handles);



%edit 4 to show e bat1 exceeded 
% e_bat1=handles.e_bat1;
if (handles.e_bat1<25000)||(handles.e_bat1>40000)
    set(handles.edit4,'String','exceed');    
end    


%text2--minimum need cell number
if handles.data(number).v==0
    c='E_bat1 is not enough';
else
    c=1200+((handles.data(number).index(1,2)-1)*100);
end
set(handles.text2,'String',c);


%figure1
A=handles.result(1,1:16); %E_bat1
B=handles.result(7,1:16); %E_rex
Z=zeros(1,16);
C=handles.result(2,:);    %socA
r=[A',B'];
m=1:16;
axes(handles.axes3);    % axes3
cla;
reset(gca)
bar([A',B'],'stacked')
hold on
% % legend({'E Bat1';'E Bat2'});
[ax,h1,h2]=plotyy(m,Z,m,C,@bar,@plot);
hold on;
% legend('E Bat1','E bat2');
s=[zeros(1,16)',zeros(1,16)'];
s(number,1)=A(number);
s(number,2)=B(number);    
h=bar(s,'stacked');
set(h(1),'facecolor','b');
set(h(2),'facecolor','g');
hold on
set(get(ax(2),'Ylabel'),'string','SOC [%]','color','r') 
set(get(ax(1),'Ylabel'),'string','E Bat1&E REX [Wh]','color','k') 
xlabel(' ');
set(h2,'linestyle','-','color','r','linewidth',3);   
set(ax(:),'Ycolor','k') 
set(ax(2),'ytick',[0:10:100]); 
set(ax(1),'ytick',[0:10000:40000])
set(ax,'xlim',[0 17]) 
hold on
title('Energy & SOC');
handles.legend_figure1 = legend('E Bat1','E bat2'); 


%figure2
number=round((handles.e_bat1-24000)/1000);
v2=find(handles.data(number).rex_dr_range(2:11,1)==3); %current = 3A
v2_max=max(v2);
X=handles.data(number).rex_dr_range(1,2:end);       %2000 2100......4000
Y=handles.data(number).rex_dr_range(1+v2_max:11,1);
Z=handles.data(number).dr(v2_max:10,1:end);

x=handles.data(number).rex_dr_range(1,2:end);
y=handles.data(number).rex_dr_range(1+v2_max:end,1);
z=handles.data(number).dr(v2_max:10,1:end);
axes(handles.axes4);
cla;
reset(gca)
surf(x,y,z);
shading faceted;
hold on;
[c,h]=contour3(X,Y,Z,10,'w','linewidth',3);    
clabel(c);
xlabel('cell number of REX'),ylabel('I rex'),zlabel('driving range');
hold on; 
handles.legend_figure2 = legend; % ????????????



%figure3 

data1=handles.data(number).dr(v2_max:end,handles.data(number).index(1,2))';
data_ref=zeros(1,11-v2_max)+round(handles.range); %as reference driving range line to compare
m1=handles.data(number).rex_dr_range(1+v2_max:11,1)';
axes(handles.axes5);
cla;
reset(gca)
plot(m1,handles.data(number).dr(v2_max:end,4)','linewidth',2);
hold on;
plot(m1,data1,'linewidth',2);
hold on;
plot(m1,handles.data(number).dr(v2_max:end,21)','linewidth',2);hold on;
plot(m1,data_ref,'linewidth',2);
data2=handles.data(number).dr(v2_max:end,29);
legend('cell1500','cell min','cell4000','demanded range'); 
xlabel('I rex');
xlim([min(m1) max(m1)])
ylim([200 round(max(data2))])
title(['range@I rex@E bat1 ',get(handles.edit4,'String'),'Wh']);
hold on;
handles.legend_figure3 = legend('data'); 


%figure4--cost pie
index_pie=handles.data(number).index(1,2)+1;
cost_pie=[handles.data(number).cost(2,index_pie),handles.data(number).cost(3,index_pie)];
axes(handles.axes6);
cla;
pie(cost_pie);
legend('Battery 1','REX');
title('Cost');
cost_bat1=[num2str(handles.data(number).cost(2,index_pie)),' EUR'];
cost_rex=[num2str(handles.data(number).cost(3,index_pie)),' EUR'];
cost_total=[num2str(handles.data(number).cost(4,index_pie)),' EUR'];
cost_display={cost_bat1;cost_rex;cost_total};
set(handles.text9,'String',cost_display);
cost_only_bat1=['only bat1';num2str(handles.data(number).cost(5,index_pie)),' EUR'];
set(handles.text12,'String',cost_only_bat1);
handles.legend_figure4 = legend('data'); 


%figure5--weight pie
weight_pie=[handles.data(number).weight(2,index_pie),handles.data(number).weight(3,index_pie)];
axes(handles.axes7);
cla;
pie(cost_pie);
legend('Battery 1','REX');
title('weight');
weight_bat1=[num2str(handles.data(number).weight(2,index_pie)),' KG'];
weight_rex=[num2str(handles.data(number).weight(3,index_pie)),' KG'];
weight_total=[num2str(handles.data(number).weight(4,index_pie)),' KG'];
weight_display={weight_bat1;weight_rex;weight_total};
set(handles.text11,'String',weight_display);
handles.legend_figure5 = legend('data'); 

guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
savePlotWithinGUI(handles.axes3,handles.legend_figure1);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
savePlotWithinGUI(handles.axes4,handles.legend_figure2);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
savePlotWithinGUI(handles.axes5,handles.legend_figure3);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
savePlotWithinGUI(handles.axes6,handles.legend_figure4);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
savePlotWithinGUI(handles.axes7,handles.legend_figure5);
