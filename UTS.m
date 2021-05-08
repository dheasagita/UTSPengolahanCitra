function varargout = UTS(varargin)
% UTS MATLAB code for UTS.fig
%      UTS, by itself, creates a new UTS or raises the existing
%      singleton*.
%
%      H = UTS returns the handle to a new UTS or the handle to
%      the existing singleton*.
%
%      UTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTS.M with the given input arguments.
%
%      UTS('Property','Value',...) creates a new UTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UTS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UTS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UTS

% Last Modified by GUIDE v2.5 02-May-2021 11:53:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UTS_OpeningFcn, ...
                   'gui_OutputFcn',  @UTS_OutputFcn, ...
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


% --- Executes just before UTS is made visible.
function UTS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UTS (see VARARGIN)

% Choose default command line output for UTS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UTS wait for user response (see UIRESUME)
% uiwait(handles.figure1);





% --- Outputs from this function are returned to the command line.
function varargout = UTS_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile({'*.jpg';'*.png';'*.jpeg'}, 'File Select');
image = strcat(pathname, filename);
[~, name, ext] = fileparts(filename);
fileinfo = imfinfo(image);
FileSize1 = fileinfo.FileSize(1,1);
sizew = fileinfo.Width(1,1);
sizeh = fileinfo.Height(1,1);
if ~isequal(filename,0)
    gambar = imread(fullfile(pathname,filename));
    [~,~,m] = size(gambar);
    if m == 3
        axes(handles.axes2)
        imshow(gambar)
        handles.gambar = gambar;
        guidata(hObject, handles)
    else
        msgbox('harap pilih citra RGB')
    end
else
    return
end
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);

axes(handles.axes2)
imshow(image)
set(handles.edit2, 'string', name);
set(handles.edit3, 'string', ext);
set(handles.edit4, 'string', sizew);
set(handles.edit6, 'string', sizeh);
set(handles.edit7, 'string', FileSize1);
set(handles.edit8, 'string', image);

axes(handles.axes4)
imshow(image)
title('Citra RGB')

axes(handles.axes5)
cla('reset')
imhist(R);
title('\color{red}Red')

axes(handles.axes6)
cla('reset')
imhist(G);
title('\color{green}Green')

axes(handles.axes7)
cla('reset')
imhist(B);
title('\color{blue}Blue')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;

axes(handles.axes4)
cla ('reset')
abu2 = rgb2gray(gambar);
imshow(abu2)
title('Citra Grayscale')

axes(handles.axes5)
cla('reset')
imhist(abu2);
title('Grayscale')

axes(handles.axes6)
cla reset
set(handles.axes6, 'Visible', 'off');

axes(handles.axes7)
cla reset
set(handles.axes7, 'Visible', 'off');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;

axes(handles.axes4)
bw = im2bw(gambar,0.5);
imshow(bw)
title('Citra B/W')

axes(handles.axes5)
cla('reset')
h = histogram(double(bw(:)),2);
h.FaceColor = [0 0 0];
h.EdgeColor = [0 0 0];
set(gca,'Xlim',[0 1])
grid on
title('B/W')

axes(handles.axes6)
cla reset
set(handles.axes6, 'Visible', 'off');

axes(handles.axes7)
cla reset
set(handles.axes7, 'Visible', 'off');



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);

% Untuk merubah gambar RGB menjadi layer Red
RedOnly = cat(3,R,G*0,B*0);
axes(handles.axes4)
cla('reset')
imshow(RedOnly)
title('Red Only')

axes(handles.axes5)
cla('reset')
imhist(R);
title('\color{red}Red Only')

axes(handles.axes6)
cla reset
set(handles.axes6, 'Visible', 'off');

axes(handles.axes7)
cla reset
set(handles.axes7, 'Visible', 'off');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);

% Untuk merubah gambar RGB menjadi layer Green
GreenOnly = cat(3,R*0,G,B*0);
axes(handles.axes4)
cla('reset')
imshow(GreenOnly)
title('Green Only')

axes(handles.axes5)
cla('reset')
imhist(G);
title('\color{green}Green Only')

axes(handles.axes6)
cla reset
set(handles.axes6, 'Visible', 'off');

axes(handles.axes7)
cla reset
set(handles.axes7, 'Visible', 'off');


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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);

% Untuk merubah gambar RGB menjadi layer Blue
BlueOnly = cat(3,R*0,G*0,B);
axes(handles.axes4)
cla('reset')
imshow(BlueOnly)
title('Blue Only')

axes(handles.axes5)
cla('reset')
imhist(B);
title('\color{blue}Blue Only')

axes(handles.axes6)
cla reset
set(handles.axes6, 'Visible', 'off');

axes(handles.axes7)
cla reset
set(handles.axes7, 'Visible', 'off');

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);


axes(handles.axes4)
imshow(gambar)
title('Citra RGB')

axes(handles.axes5)
cla('reset')
imhist(R);
title('\color{red}Red')

axes(handles.axes6)
cla('reset')
imhist(G);
title('\color{green}Green')

axes(handles.axes7)
cla('reset')
imhist(B);
title('\color{blue}Blue')


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = handles.gambar;

% Untuk merubah gambar RGB menjadi Negatif
Negatif = imcomplement(gambar);
axes(handles.axes4)
cla('reset')
imshow(Negatif)
title('Citra Negatif')

% Menampilkan histogram original
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);
 
axes(handles.axes5)
cla('reset')
h = histogram(R(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on
title('Original')
 
h = histogram(G(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
 
h = histogram(B(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';
set(gca,'Xlim',[0 255])
grid on
hold off

% Menampilkan histogram negatif
R = Negatif(:,:,1);
G = Negatif(:,:,2);
B = Negatif(:,:,3);

axes(handles.axes6)
cla('reset')
h = histogram(R(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on
title('Negatif')
 
h = histogram(G(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
 
h = histogram(B(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';
set(gca,'Xlim',[0 255])
grid on
hold off

axes(handles.axes7)
cla reset
set(handles.axes7, 'Visible', 'off');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S = getframe(handles.axes4);
Simpan = frame2im(S);
imwrite(Simpan, 'Image.jpg')
