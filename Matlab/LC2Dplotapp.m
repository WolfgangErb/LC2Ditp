function varargout = LC2Dplotapp(varargin)
%LC2DPLOTAPP M-file for LC2Dplotapp.fig
%      LC2DPLOTAPP, by itself, creates a new LC2DPLOTAPP or raises the existing
%      singleton*.
%
%      H = LC2DPLOTAPP returns the handle to a new LC2DPLOTAPP or the handle to
%      the existing singleton*.
%
%      LC2DPLOTAPP('Property','Value',...) creates a new LC2DPLOTAPP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to LC2Dplotapp_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      LC2DPLOTAPP('CALLBACK') and LC2DPLOTAPP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in LC2DPLOTAPP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LC2Dplotapp

% Last Modified by GUIDE v2.5 30-Nov-2017 20:53:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LC2Dplotapp_OpeningFcn, ...
                   'gui_OutputFcn',  @LC2Dplotapp_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before LC2Dplotapp is made visible.
function LC2Dplotapp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

handles.m1=16;
handles.m2=16;
set(handles.popupmenu4, 'value', 16);
set(handles.popupmenu5, 'value', 16);
handles.kappa1=0;
handles.kappa2=0;

axes(handles.label1);
text('Interpreter','LaTex',...
    'string','$m_1$',...
    'FontSize',14)
axis off

axes(handles.label2);
text('Interpreter','LaTex',...
    'string','$m_2$',...
    'FontSize',14)
axis off

axes(handles.label3);
text('Interpreter','LaTex',...
    'string','${\kappa_1}$',...
    'FontSize',14)
axis off

axes(handles.label4);
text('Interpreter','LaTex',...
    'string','${\kappa_2}$',...
    'FontSize',14)
axis off


% Choose default command line output for LC2Dplotapp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LC2Dplotapp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LC2Dplotapp_OutputFcn(hObject, eventdata, handles)
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

m = [handles.m1,handles.m2];          %frequency parameters of the variety
kappa = [handles.kappa1,handles.kappa2];      %phase shift parameters of the variety

range = [-1,1,-1,1];  %range for plotting

%compute gcd of m(1) and m(2) as well as the type of the variety
g = gcd(m(1),m(2));
e = mod(kappa(1)+kappa(2),2);

% Compute the single Lissajous curves of the variety
% and normalize to range

t = 0:0.001:2*pi;

x = zeros(g,length(t));
y = zeros(g,length(t));

for i = 1:g
  x(i,:) = cos(m(2)*t/g);
  y(i,:) = cos(m(1)*t/g+(2*(i-1)+e)*pi/m(2));
  [x(i,:),y(i,:)] = norm_range(x(i,:),y(i,:),[-1 1 -1 1],range);
end

% Compute the coordinates of the node points:
[xLC, yLC, wLC] = LC2Dpts(m,kappa,range);

% Compute the coordinates of the spectral index set

R = LC2Dmask(m,kappa,0);
NoLC = nnz(R);
gamma = zeros(NoLC,2);
i1 = 1; 

for i = 0:m(1)
    for j = 0:m(2)
            if (R(i+1,j+1) > 0)
                gamma(i1,:) = [i,j];
                i1 = i1+1;
             end
    end
end

% Plot Chebyshev variety and LC points

axes(handles.axes1); 

for i = 1:g
  plot(x(i,:),y(i,:),'Color' ,[183,207,246]/255,'LineWidth',2);
  hold on
end

plot(xLC,yLC,'o','LineWidth',2,'MarkerSize',10,...
             'MarkerEdgeColor','k','MarkerFaceColor',[65,105,225]/255);
         
axis([range(1)-0.1 range(2)+0.1 range(3)-0.1 range(4)+0.1]);
         
set(gca,'FontSize',14);

title(['\fontsize{14} LC^{(m)}_{\kappa} points and Chebyshev variety C^{(m)}_{\kappa}'])

hold off

% Plot spectral index set

axes(handles.axes2);

plot(gamma(:,1),gamma(:,2),'o','LineWidth',2,'MarkerSize',10,...
             'MarkerEdgeColor','k','MarkerFaceColor',[181,22,33]/255);
hold on

line([0,0],[0,m(2)],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1),0],[0,0],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1),0],[0,m(2)],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1)/2, m(1)/2 ],[0,m(2)/2],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1)/2,0],[m(2)/2, m(2)/2],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);

axis([-0.5,m(1)+0.5,-0.5,m(2)+0.5]);
  
set(gca,'FontSize',14);

title(['\fontsize{14} Spectral index set \Gamma^{(m)}_{\kappa}'])

hold off


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

val = get(hObject,'Value');
% Set current data to the selected data set.
handles.kappa1=val-1;
% Save the handles structure.
guidata(hObject,handles)


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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

val = get(hObject,'Value');
% Set current data to the selected data set.
handles.kappa2=val-1;
% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

% Determine the selected data set.
val = get(hObject,'Value');
% Set current data to the selected data set.
handles.m1=val;
% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5

val = get(hObject,'Value');
% Set current data to the selected data set.
handles.m2=val;
% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
