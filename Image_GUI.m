function varargout = Image_GUI(varargin)
% IMAGE_GUI MATLAB code for Image_GUI.fig
%      IMAGE_GUI, by itself, creates a new IMAGE_GUI or raises the existing
%      singleton*.
%
%      H = IMAGE_GUI returns the handle to a new IMAGE_GUI or the handle to
%      the existing singleton*.
%
%      IMAGE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_GUI.M with the given input arguments.
%
%      IMAGE_GUI('Property','Value',...) creates a new IMAGE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_GUI

% Last Modified by GUIDE v2.5 22-Jul-2015 13:16:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_GUI_OutputFcn, ...
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


% --- Executes just before Image_GUI is made visible.
function Image_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_GUI (see VARARGIN)

% Choose default command line output for Image_GUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
movegui(gcf,'center');
t=timer('executionmode','fixedrate','period',1,'TimerFcn',{@onTimer,handles});
start(t);

function onTimer(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
xingqi={'��','һ','��','��','��','��','��'};
set(handles.time,'string',[datestr(now,'yyyy mm dd HH:MM:SS') ' ����' xingqi{weekday(now)}]);


% --- Outputs from this function are returned to the command line.
function varargout = Image_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --------------------------------------------------------------��ʼ------------------------------------------------------------
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ---------------��-----------------------------------------------------
function open_Callback(hObject, eventdata, handles) 
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.png';'*.jpg';'*.bmp';'*.tif'},'����ͼ��');
if isequal(filename,0)||isequal(pathname,0)
    %errordlg('û�д��ļ���','error');
    return;
else
    file=[pathname,filename];
    global S %����һ��ȫ�ֱ����������ʼͼ��·�������ڻ�ԭ
    S=file;
    I=imread(file);
    axes(handles.axes1);%��TagֵΪaxes1����������Ϊ��ǰ
    cla reset%���ԭ������
    imshow(I); 
    axes(handles.axes2);%��TagֵΪaxes2����������Ϊ��ǰ
    cla reset
    imshow(I);
    clear T map PSF;
end


% --------------����------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
[sfilename,spathname]=uiputfile({'*.jpg';'*.png';'*.bmp';'*.tif';'*.*'},'����ͼ��');
if ~isequal([sfilename,spathname],[0,0])
    sfilefullname=[spathname sfilename];%���ȫ·������һ�ַ���
    axes(handles.axes2);
    T=getimage;%���������2��ͼ����Ϣ������T
    imwrite(T,sfilefullname);
else
   % errordlg('û�д���ͼ��','error');
   return
end

% --------------����------------------------------------------------------
function repeal_Callback(hObject, eventdata, handles)
% hObject    handle to repeal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T;
axes(handles.axes2);
imshow(T);


% --------------��ʼ��------------------------------------------------------
function initialize_Callback(hObject, eventdata, handles)
% hObject    handle to initialize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
clear T map PSF;
axes(handles.axes1);
imshow(S);
axes(handles.axes2);
cla reset
imshow(S);


% --------------------------------------------------------------------
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T;
axes(handles.axes2);
T=getimage;
printpreview


% --------------�ر�------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
B=questdlg('ȷ�Ϲر�����ͼ�δ�����ʾϵͳ?','��ʾ','Yes','No','Yes')
switch B
   case 'Yes'
   close(gcf);
   clear all;
   clc; 
end


%% -----------------------------------------------ͼ�����ͱ任-------------------------------------------------------
function transformation_Callback(hObject, eventdata, handles)
% hObject    handle to transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Im2bw_Callback(hObject, eventdata, handles)
% hObject    handle to Im2bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   I=rgb2gray(T);
 else
  I=T; 
 end
%thresh=graythresh(I);
bw=im2bw(I,0.6);
imshow(bw);


% --------------------------------------------------------------------
function RGB2gray_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   I=rgb2gray(T);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��
   imshow(I);
 else
   msgbox('�ⲻ��RGBͼ��!','����','error'); 
 end


% --------------------------------------------------------------------
function Gray2ind_Callback(hObject, eventdata, handles)
% hObject    handle to Gray2ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T  
global map
axes(handles.axes2);
T=getimage;
if isgray(T)==1
    [X,map]=gray2ind(T,64);
    I=imshow(X,map);

else
    msgbox('�ⲻ�ǻҶ�ͼ��!','����','error');
 end


% --------------------------------------------------------------------
function Ind2gray_Callback(hObject, eventdata, handles)
% hObject    handle to Ind2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global map
axes(handles.axes2);
T=getimage;
if isind(T)==1 
    I=ind2gray(T,map);
    imshow(I);
else
    msgbox('�ⲻ������ͼ��!','����','error');
 end


% --------------------------------------------------------------------
function RGB2ind_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global map
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   [X,map]=rgb2ind(T,64);%����ɫͼ��ת��Ϊ����ͼ��
   imshow(X,map); 
 else
   msgbox('�ⲻ��RGBͼ��!','����','error');
 end

% --------------------------------------------------------------------
function ind2rgb_Callback(hObject, eventdata, handles)
% hObject    handle to ind2rgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global map
axes(handles.axes2);
T=getimage;
if isind(T)==1 
   I=ind2rgb(T,map);
   imshow(I);
else
   msgbox('�ⲻ������ͼ��!','����','error');
 end


% --------------------------------------------------------------------
function Mat2gray_Callback(hObject, eventdata, handles)
% hObject    handle to Mat2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.txt';'*.*'},'�����ļ�');
if isequal(filename,0)||isequal(pathname,0)
    %errordlg('û�д��ļ���','error');
    return;
else
  file=[pathname,filename];
  A=textread(file);
  I=mat2gray(A);
  axes(handles.axes1);
  imshow(I);
  axes(handles.axes2);
  imshow(I);
end
   
%% -----------------------------------------------------ͼ�μ��α任-------------------------------------------------------

function Geometric_Operation_Callback(hObject, eventdata, handles)
% hObject    handle to Geometric_Operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ----------��ת----------------------------------------------------------
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle to rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Nearest_Neighbor1_Callback(hObject, eventdata, handles)
% hObject    handle to Nearest_Neighbor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'��������ת�Ƕ�:'};
defans={'45'};
p=inputdlg(prompt,'��ת',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
p1=str2num(p{1});
I=imrotate(T,p1,'nearest','crop');
axes(handles.axes2);
imshow(I);
end


% --------------------------------------------------------------------
function Bilinear1_Callback(hObject, eventdata, handles)
% hObject    handle to Bilinear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'��������ת�Ƕ�:'};
defans={'45'};
p=inputdlg(prompt,'��ת',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
p1=str2num(p{1});
I=imrotate(T,p1,'bilinear','crop');
axes(handles.axes2);
imshow(I);
end


% --------------------------------------------------------------------
function Bicubic1_Callback(hObject, eventdata, handles)
% hObject    handle to Bicubic1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'��������ת�Ƕ�:'};
defans={'45'};
p=inputdlg(prompt,'��ת',1,defans);
if isempty(p)==1
    %errordlg('û�����룡','error');
     return
else
p1=str2num(p{1});
I=imrotate(T,p1,'bicubic','crop');
axes(handles.axes2);
imshow(I);
end



% ------------����--------------------------------------------------------
function resize_Callback(hObject, eventdata, handles)
% hObject    handle to resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Nearest2_Callback(hObject, eventdata, handles)
% hObject    handle to Nearest2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'������(����1��Ŵ�С��1����С)'};
defans={'2'};
p=inputdlg(prompt,'����',1,defans);
if isempty(p)==1
    %errordlg('û�����룡','error');
     return
else
p1=str2num(p{1});
I=imresize(T,p1,'nearest');
axes(handles.axes2);
imshow(I);
end


% --------------------------------------------------------------------
function Bilinear2_Callback(hObject, eventdata, handles)
% hObject    handle to Bilinear2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'������(����1��Ŵ�С��1����С)'};
defans={'2'};
p=inputdlg(prompt,'����',1,defans);
if isempty(p)==1
    %errordlg('û�����룡','error');
     return
else
p1=str2num(p{1});
I=imresize(T,p1,'bilinear');
axes(handles.axes2);
imshow(I);
end

% --------------------------------------------------------------------
function Bicubic2_Callback(hObject, eventdata, handles)
% hObject    handle to Bicubic2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'������(����1��Ŵ�С��1����С)'};
defans={'2'};
p=inputdlg(prompt,'Imresize',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
p1=str2num(p{1});
I=imresize(T,p1,'bicubic');
axes(handles.axes2);
imshow(I);
end


% --------------����------------------------------------------------------
function Mirror_Callback(hObject, eventdata, handles)
% hObject    handle to Mirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Vertical_Callback(~, eventdata, handles)
% hObject    handle to Vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
T1=double(T);
H=size(T1);
if numel(size(T))>2
   T2(1:H(1),1:H(2),1:H(3))=T1(H(1):-1:1,1:H(2),1:H(3)); %��ֱ����
   axes(handles.axes2);
   imshow(uint8(T2));
else
    T2(1:H(1),1:H(2))=T1(H(1):-1:1,1:H(2));
    axes(handles.axes2);
    imshow(uint8(T2));
end

% --------------------------------------------------------------------
function Horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to Vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
T1=double(T);
H=size(T1);
if numel(size(T))>2
   T2(1:H(1),1:H(2),1:H(3))=T1(1:H(1),H(2):-1:1,1:H(3)); %ˮƽ����
   axes(handles.axes2);
   imshow(uint8(T2));
else
   T2(1:H(1),1:H(2))=T1(1:H(1),H(2):-1:1); %ˮƽ����
   axes(handles.axes2);
   imshow(uint8(T2));
end

% --------------------------------------------------------------------
function Diagonal_Callback(hObject, eventdata, handles)
% hObject    handle to Diagonal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I1=double(T);
H=size(I1);
if numel(size(T))>2
    I2(1:H(1),1:H(2),1:H(3))=I1(H(1):-1:1,H(2):-1:1,1:H(3)); %�ԽǾ���
    axes(handles.axes2);
    imshow(uint8(I2));
else
    I2(1:H(1),1:H(2))=I1(H(1):-1:1,H(2):-1:1); 
    axes(handles.axes2);
    imshow(uint8(I2));
end


% --------------------------------------------------------------------
function translate_Callback(hObject, eventdata, handles)
% hObject    handle to translate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'Y:(y>0������;y<0,������)','X:(x>0������;y<0,������)'};
defans={'50','50'};
p=inputdlg(prompt,'ƽ��',1,defans);
if isempty(p)==1
  %  errordlg('û�����룡','error');
   return
else
p1=str2num(p{1});
p2=str2num(p{2});
se=translate(strel(1),[p1 p2]);%[y,x]����
I=imdilate(T,se);
axes(handles.axes2);
imshow(I);
end


% --------�ü�------------------------------------------------------------
function Crop_Callback(hObject, eventdata, handles)
% hObject    handle to Crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=imcrop(T);
imshow(I);



%% ---------------------------------------------ͼ��任------------------------------------------------
% ------------------------------------------------------------------
function image_transformation_Callback(hObject, eventdata, handles)
% hObject    handle to image_transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
% --------------------------------------------------------------------
function discrete_Fourier_transform_Callback(hObject, eventdata, handles)
% hObject    handle to discrete_Fourier_transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
 if numel(mysize)>2
   I=rgb2gray(T);
 else
   I=T; 
 end
F=fft2(I);
F=fftshift(F);
imshow(log(abs(F)),[0.1,10]);
colorbar;

% --------------------------------------------------------------------
function discrete_cosine_transform_Callback(hObject, eventdata, handles)
% hObject    handle to discrete_cosine_transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
if numel(mysize)>2
   I=rgb2gray(T);
 else
   I=T; 
end
I=dct2(I);
imshow(log(abs(I)),[0.1 10]);
colorbar;

% --------------------------------------------------------------------
function Hough_Callback(hObject, eventdata, handles)
% hObject    handle to Hough (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
if numel(mysize)>2
   I=rgb2gray(T);
 else
   I=T; 
end
BW = edge(I,'canny'); % extract edges
[H,T1,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);
% display the hough matrix
imshow(imadjust(mat2gray(H)),'XData',T1,'YData',R,'InitialMagnification','fit');
xlabel('\theta');
ylabel('\rho');
axis on, axis normal
% colormap(hot);
colorbar;
set(handles.time,'visible','off');


% --------------------------------------------------------------------
function Radon_Callback(hObject, eventdata, handles)
% hObject    handle to Radon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
if numel(mysize)>2
   I=rgb2gray(T);
 else
   I=T; 
end
BW = edge(I,'canny'); 
theta = 0:2:180;
[R,xp] = radon(BW,theta);
imshow(R,[],'Xdata',theta,'Ydata',xp, 'InitialMagnification','fit');
xlabel('\theta');
ylabel('x''');
axis on, axis normal
% colormap(hot);
colorbar;
set(handles.time,'visible','off');


%% ---------------------------------------------ͼ���������---------------------------
% --------------------------------------------------------------------
function add_noise_Callback(hObject, eventdata, handles)
% hObject    handle to add_inose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'��������Ϊ:'},'����',1,{'0.05'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=imnoise(T,'gaussian',0,p);       %��Ӱ���������ƽ��ֵΪ0������Ϊ0.05
imshow(I);
end

% --------------------------------------------------------------------
function salt_pepper_Callback(hObject, eventdata, handles)
% hObject    handle to salt_pepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'�����ܶ�Ϊ:'},'����',1,{'0.05'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=imnoise(T,'salt & pepper',p);    %��ӽ�������,��ƽ��ֵΪ0������Ϊ0.05
imshow(I);
end

% --------------------------------------------------------------------
function speckle_Callback(hObject, eventdata, handles)
% hObject    handle to speckle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'��������Ϊ:'},'����',1,{'0.05'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=imnoise(T,'speckle',p);    %��Ӱߵ�����,��ƽ��ֵΪ0������Ϊ0.05
imshow(I);
end
% --------------------------------------------------------------------
function poisson_Callback(hObject, eventdata, handles)
% hObject    handle to poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=imnoise(T,'poisson');    %��Ӳ�������
imshow(I);

% --------------------------------------------------------------------
function randn_Callback(hObject, eventdata, handles)
% hObject    handle to randn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'����ϵ��Ϊ:'},'����',1,{'30'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=T+uint8(p*randn(size(T)));
imshow(I);
end


% ------------�����˶�ģ��ͼ��----------------------------------------
function motion_Callback(hObject, eventdata, handles)
% hObject    handle to motion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global PSF
axes(handles.axes2);
T=getimage;
p=inputdlg({'�˶�λ����Ϊ:','�Ƕ�Ϊ��'},'����',1,{'20','20'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p1=str2num(p{1});
p2=str2num(p{2});
PSF=fspecial('motion', p1, p2);
I=imfilter(T, PSF, 'conv', 'circular');
imshow(I);
end


%% -------------------------------------------------------------ͼ��ԭ-------
function image_restoration_Callback(hObject, eventdata, handles)
% hObject    handle to image_restoration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function spatial_restoration_Callback(hObject, eventdata, handles)
% hObject    handle to spatial_restoration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function average_restoration_Callback(hObject, eventdata, handles)
% hObject    handle to average_restoration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function geometric_mean_Callback(hObject, eventdata, handles)
% hObject    handle to geometric_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
PSF1=fspecial('average', p);
I=exp(imfilter(log(I), PSF1));%���ξ�ֵ
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end

% --------------------------------------------------------------------
function arithmetic_mean_Callback(hObject, eventdata, handles)
% hObject    handle to arithmetic_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
PSF1=fspecial('average', p);
I=imfilter(I, PSF1);%������ֵ
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end


% ---------------˳��ͳ���˲�-----------------------------------------------------
function order_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to order_statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function median_fliter_Callback(hObject, eventdata, handles)
% hObject    handle to median_fliter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
if isrgb(T)==1
    msgbox('��������RGBͼ��!','����','error'); 
else
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
I=medfilt2(I, [p,p]);%��ֵ��ֵ
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end
end

% --------------------------------------------------------------------
function max_fliter_Callback(hObject, eventdata, handles)
% hObject    handle to max_fliter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
if isrgb(T)==1
    msgbox('��������RGBͼ��!','����','error'); 
else
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
I=ordfilt2(I,1,ones(p,p));
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end
end

% --------------------------------------------------------------------
function min_fliter_Callback(hObject, eventdata, handles)
% hObject    handle to min_fliter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
if isrgb(T)==1
    msgbox('��������RGBͼ��!','����','error'); 
else
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
I=ordfilt2(I,p*p,ones(p,p));
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end
end

% ------------����Ӧ�˲���ԭ--------------------------------------------------------
function self_adjust_Callback(hObject, eventdata, handles)
% hObject    handle to self_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
if isrgb(T)==1
    msgbox('��������RGBͼ��!','����','error'); 
else
p=inputdlg({'ģ�����ά��:'},'����',1,{'5'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
I=wiener2(I,[p,p]);
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end
end


% -----------���˲���ԭ---------------------------------------------------------
function inverse_restoration_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_restoration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage; 
if isrgb(T)==1
    msgbox('��������RGBͼ��!','����','error'); 
else
I=im2double(T);
[m,n]=size(I);
M=2*m; n=2*n;
u=-m/2:m/2-1;
v=-n/2:n/2-1;
[U, V]=meshgrid(u, v);
D=sqrt(U.^2+V.^2);
D0=130;
H=exp(-(D.^2)./(2*(D0^2)));
N=0.01*ones(size(I,1), size(I,2));
N=imnoise(N, 'gaussian', 0, 0.001);
J=fftfilter(I, H)+N;
HC=zeros(m, n);
% M1=H>0.1;
% HC(M1)=1./H(M1);
% K=fftfilter(J, HC);
% HC=zeros(m, n);
M2=H>0.01;
HC(M2)=1./H(M2);
L=fftfilter(J, HC);
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(L,[]);
end


% -----------------ά���˲�---------------------------------------------------
function wiener_Callback(hObject, eventdata, handles)
% hObject    handle to wiener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global PSF
axes(handles.axes2);
T=getimage; 
if isempty(PSF)==1
    msgbox('���������˶�ģ��ͼ��','����','error')
else
I=im2double(T);
NSR=0;
I=deconvwnr(I, PSF, NSR);
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end


% -----------------��С�����˲�---------------------------------------------------
function OLS_restoration_Callback(hObject, eventdata, handles)
% hObject    handle to OLS_restoration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global PSF
axes(handles.axes2);
T=getimage; 
if isempty(PSF)==1
    msgbox('���������˶�ģ��ͼ��','����','error')
else
I=im2double(T);
v=0.02;
NP=v*prod(size(I));
I=deconvreg(I, PSF, NP);
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end


% -----------------------Lucy_Richardson�˲�---------------------------------------------
function Lucy_Richardson_Callback(hObject, eventdata, handles)
% hObject    handle to Lucy_Richardson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global PSF
axes(handles.axes2);
T=getimage; 
if isempty(PSF)==1
    msgbox('���������˶�ģ��ͼ��','����','error')
else
p=inputdlg({'��������:'},'����',1,{'20'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
I=deconvlucy(I, PSF,p);
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end
end

% --------------------ä�����˲�------------------------------------------------
function blind_solve_Callback(hObject, eventdata, handles)
% hObject    handle to blind_solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
global PSF
axes(handles.axes2);
T=getimage; 
if isempty(PSF)==1
    msgbox('���������˶�ģ��ͼ��','����','error')
else
p=inputdlg({'��������:'},'����',1,{'20'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
I=im2double(T);
INITPSF=ones(size(PSF));
I=deconvblind(I, INITPSF, p);
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I);
end
end






%% -----------------------------------------------------------ͼ����ǿ---------------
% -----------����任��ǿ---------------------------------------------------------
function image_enforcement_Callback(hObject, eventdata, handles)
% hObject    handle to image_enforcement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function spatial_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to spatial_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function gray_linear_Callback(hObject, eventdata, handles)
% hObject    handle to gray_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
if isgray(T)~=1
    msgbox('�ⲻ�ǻҶ�ͼ��','����','error'); 
else 
    P=T; 
end 
P=double(P); 
[m,n]=size(P); 
I=zeros(m,n); 
p=inputdlg({'��ԭ��ͼ�������ֵ���쵽��СΪ��','���Ϊ��'},'����',1,{'0','255'});
if isempty(p)==1
    %errordlg('û�����룡','error');
     return
else
    p1=str2num(p{1});
    p2=str2num(p{2});
bmin=min(min(P)); 
bmax=max(max(P)); 
for i=1:m     
    for j=1:n 
        I(i,j)=(p2-p1)*(P(i,j)-bmin)/(bmax-bmin)+p1;     
    end
end
% axes(handles.axes1);
% imshow(T); 
axes(handles.axes2);
imshow(uint8(I)); 
end
% --------------------------------------------------------------------
function inverse_linear_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
J=double(T);
I=256-1-J;
imshow(uint8(I));

% --------------------------------------------------------------------
function unlinear_Callback(hObject, eventdata, handles)
% hObject    handle to unlinear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
J=double(T);
I=45*log(J+1);
imshow(uint8(I));

% --------------------------------------------------------------------
function contour_Callback(hObject, eventdata, handles)
% hObject    handle to contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
imcontour(T)
% --------------------------------------------------------------------
function Histogram_Callback(hObject, eventdata, handles)
% hObject    handle to Histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);% =isrgb %
 if numel(mysize)>2
   I=rgb2gray(T);
 else
   I=T; 
 end
axes(handles.axes2);
imhist(I);

% --------------------------------------------------------------------
function Brightness_Callback(hObject, eventdata, handles)
% hObject    handle to Brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'������(����1������С��1�䰵)'},'����',1,{'0.5'});
if isempty(p)==1
    %errordlg('û�����룡','error');
     return
else
    p1=str2num(p{1});
    I=immultiply(T,p1);
    imshow(I);
end


% --------------------------------------------------------------------
function Contrast_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=imadjust(T);
imshow(I);

% --------------------------------------------------------------------
function histeq_Callback(hObject, eventdata, handles)
% hObject    handle to histeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=histeq(T);
imshow(I);


% ----------------------------�����˲���ǿ----------------------------------------------------------
function spatial_filtering_Callback(hObject, eventdata, handles)
% hObject    handle to spatial_filtering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function smooth_filtering_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_filtering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function average_fliter_Callback(hObject, eventdata, handles)
% hObject    handle to average_fliter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
    %errordlg('û�����룡','error');
    return
else
p=str2num(p{1});
h=ones(p,p)./(p*p);%ģ�����
I=imfilter(T,h);  %�þ�ֵģ���ͼ������˲�
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I,[]);
end
% --------------------------------------------------------------------
function Median_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Median_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
p=inputdlg({'ģ�����ά��:'},'����',1,{'3'});
if isempty(p)==1
   % errordlg('û�����룡','error');
else
p=str2num(p{1});
I=medfilt2(T,[p p]); 
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(I,[]);
end


% ------------------���˲���ǿ--------------------------------------------------
function sharpening_filter_Callback(hObject, eventdata, handles)
% hObject    handle to sharpening_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function laplacian_Callback(hObject, eventdata, handles)
% hObject    handle to laplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%��ͼ�����ת��Ϊdouble��
global T
axes(handles.axes2);
T=getimage;
T1=double(T);
h=fspecial('laplacian');
T2=filter2(h,T1); %���ϱ任
I=T1-T2;
imshow(uint8(I));

% --------------------------------------------------------------------
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
h=fspecial('sobel');  %ѡ��Sobel����
I=filter2(h,T);  %�������
imshow(uint8(I));

% --------------------------------------------------------------------
function gradient_Callback(hObject, eventdata, handles)
% hObject    handle to gradient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I1=double(T);                    %��������ת��
[IX,IY]=gradient(I1);            %�ݶ�
I=sqrt(IX.*IX+IY.*IY);
imshow(uint8(I));

% ------Ƶ����ǿ--------------------------------------------------------------
function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function LPF_Callback(hObject, eventdata, handles)
% hObject    handle to LPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function ideal_LPF_Callback(hObject, eventdata, handles)
% hObject    handle to ideal_LPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'�����ͨ�˲����Ľ�ֹƵ��D0:'};
defans={'35'};
p=inputdlg(prompt,'LPF����',1,defans);
if isempty(p)==1
  %  errordlg('û�����룡','error');
else
d0=str2num(p{1});
J=double(T);
f=fft2(J);%���ø���Ҷ�任
g=fftshift(f);%���ݾ���ƽ��
color(jet(64));
[M,N]=size(f);
n1=floor(M/2);
n2=floor(N/2);
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        if d<=d0;
            h=1;
        else
            h=0;
        end
        g(i,j)=h*g(i,j);
    end
end
g=ifftshift(g);
I=uint8(real(ifft2(g)));
imshow(I);
end
% --------------------------------------------------------------------
function B_LPF_Callback(hObject, eventdata, handles)
% hObject    handle to B_LPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'������˹��ͨ�˲����Ľ�ֹƵ��D0:','����'};
defans={'35','2'};
p=inputdlg(prompt,'LPF����',1,defans);
if isempty(p)==1
  %  errordlg('û�����룡','error');
else
d0=str2num(p{1});
n=str2num(p{2});
f=double(T);
k=fft2(f);
g=fftshift(k);
[N1,N2]=size(g);
u0=round(N1/2);
v0=round(N2/2);
for i=1:N1
    for j=1:N2
        d=sqrt((i-u0)^2+(i-v0)^2);
        h=1/(1+0.414*d/d0)^(2*n);
        y(i,j)=h*g(i,j);
    end
end
y=ifftshift(y);
I1=ifft2(y);
I=uint8(real(I1));
imshow(I);
end
% --------------------------------------------------------------------
function exp_LPF_Callback(hObject, eventdata, handles)
% hObject    handle to exp_LPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'ָ����ͨ�˲����Ľ�ֹƵ��D0:','����'};
defans={'35','2'};
p=inputdlg(prompt,'LPF����',1,defans);
if isempty(p)==1
  %  errordlg('û�����룡','error');
else
d0=str2num(p{1});
n=str2num(p{2});
f=double(T);
k=fft2(f);
g=fftshift(k);
[N1,N2]=size(g);
u0=round(N1/2);
v0=round(N2/2);
for i=1:N1
    for j=1:N2
        d=sqrt((i-u0)^2+(i-v0)^2);
        h=exp(-(d/d0)^2);
        y(i,j)=h*g(i,j);
    end
end
y=ifftshift(y);
I1=ifft2(y);
I=uint8(real(I1));
imshow(I);
end

% --------------------------------------------------------------------
function HPF_Callback(hObject, eventdata, handles)
% hObject    handle to HPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function ideal_HPF_Callback(hObject, eventdata, handles)
% hObject    handle to ideal_HPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'�����ͨ�˲����Ľ�ֹƵ��D0:'};
defans={'5'};
p=inputdlg(prompt,'HPF����',1,defans);
if isempty(p)==1
  %  errordlg('û�����룡','error');
else
d0=str2num(p{1});
J=double(T);
f=fft2(J);        %���ø���Ҷ�任
g=fftshift(f);    %���ݾ���ƽ��
[M,N]=size(f);
n1=floor(M/2);
n2=floor(N/2);
%���������ͨ�˲�
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        if d>=d0;
            h=1;
        else
            h=0;
        end
        g(i,j)=h*g(i,j);
    end
end
g=ifftshift(g);
I=uint8(real(ifft2(g)));
imshow(I);
end

% --------------------------------------------------------------------
function B_HPF_Callback(hObject, eventdata, handles)
% hObject    handle to B_HPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'������˹��ͨ�˲����Ľ�ֹƵ��D0:','����'};
defans={'5','2'};
p=inputdlg(prompt,'HPF����',1,defans);
if isempty(p)==1
  %  errordlg('û�����룡','error');
else
d0=str2num(p{1});
nn=str2num(p{2});
J=double(T);
f=fft2(J);        %���ø���Ҷ�任
g=fftshift(f);    %���ݾ���ƽ��
[M,N]=size(f);
m=fix(M/2);
n=fix(N/2);
for i=1:M
    for j=1:N
        d=sqrt((i-m)^2+(j-n)^2);
        if(d==0)
            h=0;
        else
            h=1/(1+0.414*(d0/d)^(2*nn));      %���㴫�ݺ���
        end
        s(i,j)=h*g(i,j);
    end
end
s=ifftshift(s);
J1=ifft2(s);
I=uint8(real(J1));
imshow(I);
end


% --------------------------------------------------------------------
function exp_HPF_Callback(hObject, eventdata, handles)
% hObject    handle to exp_HPF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'ָ����ͨ�˲����Ľ�ֹƵ��D0:','����'};
defans={'5','2'};
p=inputdlg(prompt,'HPF����',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
   return
else
d0=str2num(p{1});
n=str2num(p{2});
J=double(T);
f=fft2(J);        %���ø���Ҷ�任
g=fftshift(f);    %���ݾ���ƽ��
[M,N]=size(f);
u0=round(M/2);
v0=round(N/2);
for i=1:M
    for j=1:N
        d=sqrt((i-u0)^2+(j-v0)^2);
        h=exp(-(d0/d)^n);
        y(i,j)=h*g(i,j);        
    end
end
y=ifftshift(y);
J1=ifft2(y);
I=uint8(real(J1));
imshow(I);
end


% ------------------̬ͬ�˲�--------------------------------------------------
function homomorphic_filter_Callback(hObject, eventdata, handles)
% hObject    handle to homomorphic_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
prompt={'̬ͬ�˲����Ľ�ֹƵ��D0:'};
defans={'5',};
p=inputdlg(prompt,'����',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
   return
else
d0=str2num(p{1});
J=double(T);
f=fft2(J);        %���ø���Ҷ�任
g=fftshift(f);    %���ݾ���ƽ��
[M,N]=size(f);
r1=0.5;
rh=2;
c=4;
n1=floor(M/2);
n2=floor(N/2);
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        h=(rh-r1)*(1-exp(-c*(d.^2/d0.^2)))+r1;
        g(i,j)=h*g(i,j);        
    end
end
g=ifftshift(g);
J1=ifft2(g);
I=uint8(real(J1));
imshow(I);
end



% -----��ɫ��ǿ---------------------------------------------------------------
function color_Callback(hObject, eventdata, handles)
% hObject    handle to color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function density_slice_Callback(hObject, eventdata, handles)
% hObject    handle to density_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=T;
c=zeros(size(I));
pos=find(I<20);
c(pos)=I(pos);
b(:,:,3)=c;
c=zeros(size(I));
pos=find((I>=20)&(I<40));
c(pos)=I(pos);
b(:,:,2)=c;
c=zeros(size(I));
pos=find(I>=40);
c(pos)=I(pos);
b(:,:,1)=c;
imshow(uint8(b));

% ----------------α��ɫ��ǿ----------------------------------------------------
function Pseudo_Color_Callback(hObject, eventdata, handles)
% hObject    handle to Pseudo_Color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=T;
[M,N]=size(I);
f=fft2(I);
F=fftshift(f);
re=100;
gr=200;
be=150;
bw=100;
bu=10;
bv=10;
for u=1:M
    for v=1:N
        D(u,v)=sqrt(u^2+v^2);
        redh(u,v)=1/(1+(sqrt(2)-1)*(D(u,v)/re)^2);
        greenh(u,v)=1/(1+(sqrt(2)-1)*(gr/D(u,v))^2);
        blued(u,v)=sqrt((u-bu)^2+(v-bv)^2);
        blueh(u,v)=1-1/(1+blued(u,v)*bw/((blued(u,v))^2-(be)^2)^2);
    end
end
Red=redh.*F;
rc=ifft2(Red);
Green= greenh.*F;
grc=ifft2(Green);
Blue=blued.*F;
blc=ifft2(Blue);
rc=real(rc)/256;
grc=real(grc)/256;
blc=real(blc)/256;
for i=1:M
    for j=1:N
        out(i,j,1)=rc(i,j);
        out(i,j,2)=grc(i,j);
        out(i,j,3)=blc(i,j);
    end
end
imshow(abs(out));


%% ------------------------------------------------ͼ��ָ�------------------
function Segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to Segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ---------������ֵ�ָ�-----------------------------------------------------------
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function iteration_Callback(hObject, eventdata, handles)
% hObject    handle to iteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   I=rgb2gray(T);
 else
  I=T; 
 end
ZMAX=max(max(I));         %ȡ�����Ҷ�ֵ
ZMIN=min(min(I));         %ȡ����С�Ҷ�ֵ
TK=(ZMAX+ZMIN)/2;
bcal=1;
ISIZE=size(I);
%ͼ���С
while(bcal)
    %����ǰ���ͱ�����
    ifground=0;
    ibground=0;
    %����ǰ���ͱ����Ҷ��ܺ�
    FgroundS=0;
    BgroundS=0;
    for i=1:ISIZE(1)
        for j=1:ISIZE(2)
            tmp=I(i,j);
            if(tmp>=TK)
                ifground=ifground+1;
                FgroundS=FgroundS+double(tmp);  %ǰ���Ҷ�ֵ
            else
                ibground=ibground+1;
                BgroundS=BgroundS+double(tmp);
            end
        end
    end
    %����ǰ���ͱ�����ƽ��ֵ
    ZO=FgroundS/ifground;
    ZB=BgroundS/ibground;
    TKTmp=uint8((ZO+ZB)/2);
    if(TKTmp==TK)
        bcal=0;
    else
        TK=TKTmp;
    end
    %����ֵ���ٱ仯��ʱ��˵����������
end
newI=im2bw(I,double(TK)/255);
imshow(newI);
s=strcat('���������ֵ��',num2str(TK));
msgbox(s,'������','help')


% --------------------------------------------------------------------
function OTSU_Callback(hObject, eventdata, handles)
% hObject    handle to OTSU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   I=rgb2gray(T);
 else
   I=T; 
 end
%ʹ��graythresh����������ֵ����򷨼���ȫ��ͼ��I����ֵ
level = graythresh(I);
BW=im2bw(I,level);
imshow(BW);
s=strcat('��򷨼���Ҷ���ֵ��',num2str(uint8(level*255)));
msgbox(s,'���','help')

% --------------------------------------------------------------------
function watershed_Callback(hObject, eventdata, handles)
% hObject    handle to watershed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   I=rgb2gray(T);
 else
  I=T; 
 end
I=watershed(I,4);
imshow(I);


% ----------��Ե���----------------------------------------------------------
function edge_measure_Callback(hObject, eventdata, handles)
% hObject    handle to edge_measure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Roberts_Callback(hObject, eventdata, handles)
% hObject    handle to Roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   T=rgb2gray(T); 
 end
[I,thresh]=edge(T,'roberts');%���Զ���ֵѡ�񷨶�ͼ�����Roberts���Ӽ��
imshow(I);
s=strcat('Roberts�����Զ�ѡ�����ֵΪ��',num2str(thresh));%���ص�ǰRoberts���ӱ�Ե������ֵ
msgbox(s,'��Ե���','help')

% --------------------------------------------------------------------
function Sobel_edge_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   T=rgb2gray(T); 
 end
[I,thresh]=edge(T,'sobel');%���Զ���ֵѡ�񷨶�ͼ�����Sobel���Ӽ��
imshow(I);
s=strcat('Sobel�����Զ�ѡ�����ֵΪ��',num2str(thresh));%���ص�ǰSobel���ӱ�Ե������ֵ
msgbox(s,'��Ե���','help')

% --------------------------------------------------------------------
function Prwitte_Callback(hObject, eventdata, handles)
% hObject    handle to Prwitte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   T=rgb2gray(T); 
 end
[I,thresh]=edge(T,'prewitt');%���Զ���ֵѡ�񷨶�ͼ�����Prewitt���Ӽ��
imshow(I);
s=strcat('Prewitt�����Զ�ѡ�����ֵΪ��',num2str(thresh));%���ص�ǰPrewitt���ӱ�Ե������ֵ
msgbox(s,'��Ե���','help')

% --------------------------------------------------------------------
function LoG_Callback(hObject, eventdata, handles)
% hObject    handle to LoG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   T=rgb2gray(T); 
 end
[I,thresh]=edge(T,'log');%���Զ���ֵѡ�񷨶�ͼ�����log���Ӽ��
imshow(I);
s=strcat('LoG�����Զ�ѡ�����ֵΪ��',num2str(thresh));%���ص�ǰlog���ӱ�Ե������ֵ
msgbox(s,'��Ե���','help')

% --------------------------------------------------------------------
function Canny_Callback(hObject, eventdata, handles)
% hObject    handle to Canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isrgb(T)==1
   T=rgb2gray(T); 
 end
[I,thresh]=edge(T,'canny');%���Զ���ֵѡ�񷨶�ͼ�����canny���Ӽ��
imshow(I);
s=strcat('Canny�����Զ�ѡ�����ֵΪ��',num2str(thresh));%���ص�ǰcanny���ӱ�Ե������ֵ
msgbox(s,'��Ե���','help')


% ------------�����������ָ�--------------------------------------------------------
function region_growing_Callback(hObject, eventdata, handles)
% hObject    handle to region_growing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes1);
T=getimage;
if isrgb(T)==1
   I=rgb2gray(T); 
else
    I=T;
end
I=double(I);                  %ͼ������ת��
msgbox('ѡ��ԭͼ��ĳ������㣬Ȼ�󰴻س���','����������','help')
axes(handles.axes1);
[t,s]=getpts          %�������������ʼ��

t=floor(t);
s=floor(s);
if numel(s)==1
    si=I==s;
    s1=s;
else
    si=bwmorph(s,'shrink',Inf);
    j=find(si);
    s1=I(j);
end
ti=false(size(I));
for k=1:length(s1)
    sv=s1(k);
    s=abs(I-sv)<=t;
    ti=ti|s;
end
[g,nr]=bwlabel(imreconstruct(si,ti));      %ͼ���ʶ
axes(handles.axes2);
imshow(g);
ss=strcat('����������',num2str(nr));
msgbox(ss,'����������','help')

% ---------�Ĳ����ָ�-----------------------------------------------------------
function Quad_tree_Callback(hObject, eventdata, handles)
% hObject    handle to Quad_tree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
[a,b]=size(T);
if a~=b
    T=imresize(T,[512,512]);
end
if isrgb(T)==1
   I=rgb2gray(T); 
else
   I=T;
end
S = qtdecomp(I,0.5);
blocks = repmat(uint8(0),size(S));
for dim = [512 256 128 64 32 16 8 4 2 1];    
  numblocks = length(find(S==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks = qtsetblk(blocks,S,dim,values);
  end
end
blocks(end,1:end) = 1;
blocks(1:end,end) = 1;
imshow(blocks,[]);


% --------------------------------------------------------------------
function image_math_Callback(hObject, eventdata, handles)
% hObject    handle to image_math (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function base_operation_Callback(hObject, eventdata, handles)
% hObject    handle to base_operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function imerode_Callback(hObject, eventdata, handles)
% hObject    handle to imerode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
 if numel(mysize)>2
   I=rgb2gray(T);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��
 else
   I=T; 
 end
prompt={'������ṹԪ������:','����'};
defans={'square','3'};
p=inputdlg(prompt,'��������',1,defans)
if isempty(p)==1
  %  errordlg('û�����룡','error');
   return
else
 p2=str2num(p{2});
 se=strel(p{1},p2);
 I=imerode(I,se);
 imshow(I,[]);
end

% --------------------------------------------------------------------
function imdilate_Callback(hObject, eventdata, handles)
% hObject    handle to imdilate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
 if numel(mysize)>2
   I=rgb2gray(T);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��
 else
   I=T; 
 end
prompt={'������ṹԪ������:','����'};
defans={'square','3'};
p=inputdlg(prompt,'��������',1,defans)
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
 p2=str2num(p{2});
 se=strel(p{1},p2);
 I=imdilate(I,se);
 imshow(I,[]);
end

% --------------------------------------------------------------------
function imopen_Callback(hObject, eventdata, handles)
% hObject    handle to imopen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
 if numel(mysize)>2
   I=rgb2gray(T);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��
 else
  I=T; 
 end
prompt={'������ṹԪ������:','����'};
defans={'square','3'};
p=inputdlg(prompt,'��������',1,defans)
if isempty(p)==1
   % errordlg('û�����룡','error');
     return
else
 p2=str2num(p{2});
 se=strel(p{1},p2);
 I=imopen(I,se);
 imshow(I,[]);
end

% --------------------------------------------------------------------
function imclose_Callback(hObject, eventdata, handles)
% hObject    handle to imclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
 if numel(mysize)>2
   I=rgb2gray(T);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��
 else
   I=T; 
 end
prompt={'������ṹԪ������:','����'};
defans={'square','3'};
p=inputdlg(prompt,'��������',1,defans)
if isempty(p)==1
   % errordlg('û�����룡','error');
     return
else
 p2=str2num(p{2});
 se=strel(p{1},p2);
 I=imclose(I,se);
 imshow(I,[]);
end
% �б�ѡ��Ի���  
% [sel,ok]=listdlg('liststring',{'�Կ�ԭ��','�Զ����','��Ƭ��Ƕ��ʽ','����ԭ��','��������'},...  
%    'listsize',[180 80],'OkString','ȷ��','CancelString','ȡ��',...  
%    'promptstring','�γ̿�Ŀ','name','ѡ����������Ȥ�Ŀ�Ŀ����ѡ��','selectionmode','multiple');  

% --------------------------------------------------------------------
function bwmorph_Callback(hObject, eventdata, handles)
% hObject    handle to bwmorph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
mysize=size(T);
 if numel(mysize)>2
   I=rgb2gray(T);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��
 else
   I=T; 
 end
prompt={'�������������:','�������'};
defans={'skel','inf'};
p=inputdlg(prompt,'��������',1,defans)
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
 p2=str2num(p{2});
 I=bwmorph(I,p{1},p2);
 imshow(I,[]);
end


% -----��ֵͼ���Ե��ȡ---------------------------------------------------------------
function edge_extract_Callback(hObject, eventdata, handles)
% hObject    handle to edge_extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isbw(T)==0
   I=im2bw(T);%��ͼ��ת��Ϊ��ֵͼ��
 else
   I=T; 
 end
prompt={'������������:'};
defans={'8'};
p=inputdlg(prompt,'��Ե��ȡ',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
p1=str2num(p{1});
I=bwperim(I,p1); 
imshow(I);
end

% --------------------------------------------------------------------
function feature_extract_Callback(hObject, eventdata, handles)
% hObject    handle to feature_extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function bwarea_Callback(hObject, eventdata, handles)
% hObject    handle to bwarea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isbw(T)==0
   I=im2bw(T);%��ͼ��ת��Ϊ��ֵͼ��
 else
   I=T; 
 end
imshow(I);
q=bwarea(I);
s=strcat('ͼ���ɫ�������(����)Ϊ��',num2str(q));
msgbox(s,'�������','help')

% --------------------------------------------------------------------
function euler_Callback(hObject, eventdata, handles)
% hObject    handle to euler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isbw(T)==0
   I=im2bw(T);%��ͼ��ת��Ϊ��ֵͼ��
 else
   I=T; 
 end
imshow(I);
q=bweuler(I);
s=strcat('ͼ���ŷ����Ϊ��',num2str(q));
msgbox(s,'����ŷ����','help')

% --------------------------------------------------------------------
function remove_objection_Callback(hObject, eventdata, handles)
% hObject    handle to remove_objection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isbw(T)==0
   I=im2bw(T);%��ͼ��ת��Ϊ��ֵͼ��
 else
   I=T; 
 end
prompt={'������Pֵ(�Ƴ����б�PС�Ķ���):'};
defans={'50'};
p=inputdlg(prompt,'�Ƴ�����',1,defans);
if isempty(p)==1
   % errordlg('û�����룡','error');
    return
else
p1=str2num(p{1});
I=bwareaopen(I,p1); 
imshow(I);
end

% --------------------------------------------------------------------
function area_fill_Callback(hObject, eventdata, handles)
% hObject    handle to area_fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
 if isbw(T)==0
   I=im2bw(T);%��ͼ��ת��Ϊ��ֵͼ��
 else
   I=T; 
 end
I=imfill(I);
imshow(I);


% ---------С��ͼ����-----------------------------------------------------------
function wavelet_image_process_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_image_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function single_layer_Callback(hObject, eventdata, handles)
% hObject    handle to single_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=T; 
s=size(I);
%��ͼ����е����ά��ɢС���ֽ�
[cA1,cH1,cV1,cD1] = dwt2(I,'db4');%С��������
%��ͼ������ع�
I0=idwt2(cA1,cH1,cV1,cD1,'db4',s);
imshow(uint8(I0));
I=double(I);
q=max(max(abs(I-I0)));
string=strcat('С��������db4��ԭͼ�����ع�ͼ�����Ϊ:',num2str(q));
msgbox(string ,'�����ά��ɢС���ع�','help')
% --------------------------------------------------------------------
function multiply_layer_Callback(hObject, eventdata, handles)
% hObject    handle to multiply_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
I=T; 
%����sym4������ͼ����зֽ�
[c,s] = wavedec2(I,2,'sym4');
%����sym4������ͼ������ع�
I0 = waverec2(c,s,'sym4');
axes(handles.axes2);
imshow(uint8(I0));
% ����ع����
I=double(I);
q=max(max(abs(I-I0)));
string=strcat('С��������sym4��ԭͼ�����ع�ͼ�����Ϊ:',num2str(q));
msgbox(string ,'����ά��ɢС���ع�','help')


% -----------------С��ͼ��ѹ��---------------------------------------------------
function wavelet_compression_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_compression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
%��������db3С����ͼ��X����2��ֽ�
[c,l]=wavedec2(T,2,'db3');
%ȫ����ֵ
[thr,sorh,keepapp]=ddencmp('cmp','wv',T);
%ѹ������:�����и�Ƶϵ������ͬ������ֵ��������
[Icmp,cxc,lxc,perf0,perfl2]=wdencmp('gbl',c,l,'db3',2,thr,sorh,keepapp);
axes(handles.axes2);
imshow(uint8(Icmp));
%��ѹ�����ͼ����ԭʼͼ����Ƚ�
string=strcat('С���ֽ�ϵ����Ϊ0��ϵ�������ٷֱ�:',num2str(perf0),'ѹ�����������ٷֱ�:',num2str(perfl2));
msgbox(string ,'С��ͼ��ѹ��','help')

% ------------С��ͼ��ȥ��--------------------------------------------------------
function wavelet_inose_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_inose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
[C,S]=wavedec2(T,2,'sym4');
a1=wrcoef2('a',C,S,'sym4',1);      %ͼ���һ�����봦��
a2=wrcoef2('a',C,S,'sym4',2);   %ͼ��ڶ������봦��
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(uint8(a2));


% ----------------С��ͼ����ǿ----------------------------------------------------
function wavelet_enhance_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_enhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
[C,S]=wavedec2(T,2,'sym5');        %���ж���С���ֽ�
sizec=size(C);                    %����ֽ�ϵ����ͻ������������ϸ��
for i=1:sizec(2)                  %С��ϵ������
    if(C(i)>350);
        C(i)=2*C(i);
    else        
        C(i)=0.5*C(i);
    end
end
I=waverec2(C,S,'sym5');     %С���任�����ع�
axes(handles.axes1);
imshow(T); 
axes(handles.axes2);
imshow(uint8(I));

% ------------------С��ͼ���ں�--------------------------------------------------
function wavelet_fusion_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_fusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.png';'*.jpg';'*.bmp';'*.tif';'*.*'},'������Ҫ�ںϵ�ͼ��');
if isequal(filename,0)||isequal(pathname,0)
    %errordlg('û�д��ļ���','error');
    return;
else
    file=[pathname,filename];
    I=imread(file);
    axes(handles.axes2);%��ͼ�񱣴��ڵڶ���������
    imshow(I); 
end
global T
axes(handles.axes1);
X1=getimage;
[a1,b1,c1]=size(X1)
axes(handles.axes2);
X2=getimage;
[a2,b2,c2]=size(X2)
if isbw(X1)|isbw(X2)==1
    msgbox('�벻Ҫѡ���ֵͼ�����ں�','����','error');
    return
end
if c1~=c2
    msgbox('��ѡ����ͬ���͵�ͼ��','����','error')
else
X2=imresize(X2,[a1,b1]); %��֤ͼ���Сһ��
[C1,S1]=wavedec2(X1,2,'sym5');        %���ж���С���ֽ�
sizec1=size(C1);                    %����ֽ�ϵ����ͻ������������ϸ��
for i=1:sizec1(2)                  %С��ϵ������
    C1(i)=1.3*C1(i);
end
[C2,S2]=wavedec2(X2,2,'sym5');        %���ж���С���ֽ�
C=(C1+C2)*0.6;
I=waverec2(C,S1,'sym5');     %С���任�����ع�
figure('Name','�ںϺ��ͼ��','NumberTitle','off'); 
imshow(uint8(I));
end


%% ----------------------------------------------------------����ͼ����ʵ��Ӧ��---------------------------------------------------------
function real_application_Callback(hObject, eventdata, handles)
% hObject    handle to real_application (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -----------ˮӡ������ʵ��------------------------------------------------------------------
function watermark_Callback(hObject, eventdata, handles)
% hObject    handle to watermark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes1);
T=getimage;
%С������
 if isrgb(T)==1
   I=rgb2gray(T);
 else
   I=T; 
 end
[a,b]=size(I)%������ͼ��
if a~=b
   I=imresize(I,[1024,1024]);
end
type='db1';
%2ά��ɢDaubechiesС���任
[CA1,CH1,CV1,CD1]=dwt2(I,type);
C1=[CH1,CV1,CD1];
%ϵ�������С
[len1,wid1]=size(CA1);
[M1,N1]=size(C1);
%������ֵT1
T1=50;
alpha=0.2;
%��ͼ���м���ˮӡ
for count2=1:1:N1
    for count1=1:1:M1
        if(C1(count1,count2)>T1)
            mark1(count1,count2)=randn(1,1);
            newc1(count1,count2)=double(C1(count1,count2))+alpha*...
abs(double(C1(count1,count2)))*mark1(count1,count2);
        else
            mark1(count1,count2)=0;
            newc1(count1,count2)=double(C1(count1,count2));
        end
    end
end
%�ع�ͼ��
newch1=newc1(1:len1,1:wid1);
newcv1=newc1(1:len1,wid1+1:2*wid1);
newcd1=newc1(1:len1,2*wid1+1:3*wid1);
R1=double(idwt2(CA1,newch1,newcv1,newcd1,type));
watermark1=double(R1)-double(I);
%��ʾˮӡͼ��
axes(handles.axes2);
imshow(watermark1*10^16);        


% -----ͼ����бУ��---------------------------------------------------------------
function Lean_adjustment_Callback(hObject, eventdata, handles)
% hObject    handle to Lean_adjustment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes1);
T=getimage;
if isrgb(T)==1
   I1=rgb2gray(T);
else
   I1=T; 
end   
I2=wiener2(I1,[5,5]);            %��ͼ�����ά���˲�I2  
I3=edge(I2,'sobel', 'horizontal');%��Sobelˮƽ���Ӷ�ͼ���Ե��
theta=0:179;    %����ѡ��Ƕ�
r=radon(I3,theta);%��ͼ�����Radon�任
[m,n]=size(r);
c=1;
for i=1:m
    for j=1:n
        if  r(1,1)<r(i,j)
           r(1,1)=r(i,j);
            c=j;
        end
    end
end                              %���Radon�任�����еķ�ֵ����Ӧ��������
rot=90-c;%ȷ����ת�Ƕ�
I4=imrotate(I2,rot,'crop');        %��ͼ�������ת����
% set(0,'defaultFigurePosition',[100,100,1200,450]); %�޸�ͼ��ͼ��λ�õ�Ĭ������
% set(0,'defaultFigureColor',[1 1 1])                 %�޸�ͼ�α�����ɫ������
axes(handles.axes2);
imshow(I4)


% ------����ʶ����--------------------------------------------------------------
function face_detection_Callback(hObject, eventdata, handles)
% hObject    handle to face_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes1);
T=getimage; 
if isrgb(T)~=1
    msgbox('��ѡ��RGBͼ��!','����','error'); 
else 
I1=T;             %����ͼ�����T
R=I1(:,:,1);      %��ȡRGBͼ�����I��R��G��Bȡֵ
G=I1(:,:,2);
B=I1(:,:,3);
Y=0.299*R+0.587*G+0.114*B; %������ɫ�ռ�ת�� ����Y ��Cb
Cb=-0.1687*R-0.3313*G+0.5000*B+128;
for Cb=133:165
    r=(Cb-128)*1.402+Y;  %��YCrCb�ռ���Cb=133:165�е�����ȷ��
    r1=find(R==r);       %������ɫ����Ķ�ֵ����
    R(r1)=255;           %�Է�ɫ���������
    G(r1)=255;
    B(r1)=255;
end
I1(:,:,1)=R;            %���ɷ�ɫ������ͼ��
I1(:,:,2)=G;
I1(:,:,3)=B;
I=im2bw(I1,0.99);       %ת���ɻҶ�ͼ��
axes(handles.axes2);
imshow(I);
end 


% --------------------------------------------------------------------
function drive_card_Callback(hObject, eventdata, handles)
% hObject    handle to drive_card (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes1);
T=getimage; 
% ��ȡ�������ͼ�񣬽���ת��Ϊ��ֵͼ��
I = T;
I2 = rgb2gray(I);
I4 = im2bw(I2, 0.2);
% ȥ��ͼ���������С�ġ����Կ϶����ǳ��Ƶ�����
bw = bwareaopen(I4, 500);
% Ϊ��λ���ƣ�����ɫ�������ͣ���ʴȥ�޹ص�С���
se = strel('disk',15);
bw = imclose(bw,se);
bw = imfill(bw,[1 1]);
% ������ͨ��߽�
[B,L] = bwboundaries(bw,4);
%imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
% �ҳ�������ͨ����������ǳ��Ƶ���һ��
for k = 1:length(B)
 boundary = B{k};
 plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
end
% �ҵ�ÿ����ͨ�������
stats = regionprops(L,'Area','Centroid');
% ѭ������ÿ����ͨ��ı߽�
for k = 1:length(B)
  % ��ȡһ���߽��ϵ����е�
  boundary = B{k};
  % ����߽��ܳ�
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  % ��ȡ�߽���Χ���
  area = stats(k).Area;
  % ����ƥ���
  metric = 27*area/perimeter^2;
  % Ҫ��ʾ��ƥ����ִ�
  metric_string = sprintf('%2.2f',metric);
  % ��ǳ�ƥ��Ƚӽ�1����ͨ��
  if metric >= 0.9 && metric <= 1.1
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
    % ��ȡ����ͨ������Ӧ�ڶ�ֵͼ���еľ�������
    goalboundary = boundary; 
    s = min(goalboundary, [], 1);
    e = max(goalboundary, [], 1);
  goal = imcrop(I4,[s(2) s(1) e(2)-s(2) e(1)-s(1)]); 
  end
  % ��ʾƥ����ִ�
  text(boundary(1,2)-35,boundary(1,1)+13,...
    metric_string,'Color','g',...
'FontSize',14,'FontWeight','bold');
end
goal = ~goal;
goal(256,256) = 0;
axes(handles.axes2);
imshow(goal);



% ----------------����----------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function notice_Callback(hObject, eventdata, handles)
% hObject    handle to notice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('��ӭʹ������ͼ������ʾϵͳ����ϵͳÿ�������һ�β������ͼ������ٴ���Ӧ�Ĵ��������ԭʼ��ͼ����д������Ƚ�ͼ���ʼ�������´�ͼ��','����','help'); 


% --------------------------------------------------------------------
function contract_Callback(hObject, eventdata, handles)
% hObject    handle to contract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('������������ϵ����dingkeyan93@outlook.com','����','help'); 
