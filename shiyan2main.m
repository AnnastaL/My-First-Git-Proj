clc;
close all;

[fn, pn, fi] = uigetfile('*.jpg', 'choose');
I = imread([pn fn]);
if ndims(I) == 3
    I = rgb2gray(I);
end

%spatial smoothness
%impact of template size--------------------------------
% 1)use average filter, template is 3*3
template_average3 = ones(3);
I_3 = filter(I,template_average3);

% 2)use average filter, template is 5*5
template_average5 = ones(5);
I_5 = filter(I,template_average5);

% 3)use average filter, template is 9*9
template_average9 = ones(9);
I_9 = filter(I,template_average9);

figure(1);
subplot(2,2,1);imshow(I);title('original');
subplot(2,2,2);imshow(I_3);title('average template 3');
subplot(2,2,3);imshow(I_5);title('average template 5');
subplot(2,2,4);imshow(I_9);title('average template 9');
%--------------------------------------------------------

%impact of template type------------------------------------------
% 1)use average filter, template is 3*3
% 2)use neighbour filter, template is 3*3
template_neighbour3 = ones(3);
template_neighbour3(2,2) = 0;
I_neighbour = filter(I,template_neighbour3);

% 3)use another 3*3 filter template
template3 = [ 1 2 1 ; 2 4 2 ; 1 2 1 ];
I_template3 = filter(I,template3);

figure(2);
subplot(2,2,1);imshow(I);title('original');
subplot(2,2,2);imshow(I_3);title('average template 3');
subplot(2,2,3);imshow(I_neighbour);title('neighbour template 3');
subplot(2,2,4);imshow(I_template3);title('another template 3');
%------------------------------------------------------------------


%space sharpening-------------------------------------
%edge enhancement
template_edge8 = [ -1 -1 -1; -1 8 -1; -1 -1 -1 ];
I_edge8 = detect(I,template_edge8);
%8 neighbourhood sharpening
template_sharpe8 = [ -1 -1 -1; -1 9 -1; -1 -1 -1 ];
I_sharpe8 = filter(I,template_sharpe8);

%edge enhancement
template_edge4 = [ 0 -1 0 ; -1 4 -1; 0 -1 0 ];
I_edge4 = detect(I,template_edge4);
%4 neighbourhood sharpening
template_sharpe4 = [ 0 -1 0 ; -1 5 -1; 0 -1 0 ];
I_sharpe4 = filter(I,template_sharpe4);

%edge enhancement
template_grad_en = [ -1 -2 -1; 0 0 0 ; 1 2 1 ];
I_grad_en = detect(I,template_grad_en);
%8 neighbourhood sharpening
template_grad_sharpe = [ -1 -2 -1; 0 1 0 ; 1 2 1 ];
I_grad_sharpe = filter(I,template_grad_sharpe);

figure(3);
imshow(I);title('original');
figure(4);
subplot(2,2,1);imshow(I_edge8);title('edge 8');
subplot(2,2,2);imshow(I_sharpe8);title('sharpe 8');
subplot(2,2,3);imshow(I_edge4);title('edge 4');
subplot(2,2,4);imshow(I_sharpe8);title('sharpe 4');
figure(5);
subplot(2,2,1);imshow(I_grad_en);title('gradient enhancement');
subplot(2,2,2);imshow(I_grad_sharpe);title('gardient sharpe');
subplot(2,2,3);imshow(I_edge4);title('edge 4');
subplot(2,2,4);imshow(I_sharpe8);title('sharpe 4');
%-----------------------------------------------------

function  I_filter = filter(I,t)

n = length(t);
[height,width] = size(I);
I = double(I);
I_filter = I;
for i = 1:height-n+1
    for j = 1:width-n+1
        c = I(i:i+n-1,j:j+n-1).*t;
        s = sum(sum(c));
        I_filter(i+(n-1)/2,j+(n-1)/2) = s/sum(sum(t));
    end
end
I_filter = uint8(I_filter);
end

function  I_detect = detect(I,t)

n = length(t);
[height,width] = size(I);
I = double(I);
I_detect = I;
for i = 1:height-n+1
    for j = 1:width-n+1
        c = I(i:i+n-1,j:j+n-1).*t;
        s = sum(sum(c));
        I_detect(i+(n-1)/2,j+(n-1)/2) = s;
    end
end
I_detect = uint8(I_detect);
end