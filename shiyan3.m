clc;
close all;

[fn, pn, fi] = uigetfile('*.jpg', 'choose');
I = imread([pn fn]);
if ndims(I) == 3
    I = rgb2gray(I);
end

% show the original image
figure(1);imshow(I);

% convert the image to binary
I_double = double(I);

%------------------------------------------------------
% call Fourier transform function
[F,f] = fouriertrans(I_double);
figure(2);
subplot(1,2,1);
imshow(F,[]);title('Fourier');

% take the inverse Fourier transform of the image.
Fc = ifftshift(f);
Ic = ifft2(Fc);
Ic = abs(Ic);
subplot(1,2,2);
imshow(Ic, []);title('image restored');
%-------------------------------------------------------

%-------------------------------------------------------
% enlarge the image and use the bilinear 
% nearest&bicubic
I_bi_enlarge = imresize(I_double,2,'bilinear'); % 2 is the magnification of the image.
figure(3);
imshow(I_bi_enlarge,[]);title('2 bilinear enlarge image');

% enlarge the image and use the nearest
I_near_enlarge = imresize(I_double,2,'nearest'); % 2 is the magnification of the image.
figure(4);
imshow(I_near_enlarge,[]);title('2 nearest enlarge image');

% compare bilinear enlarged image and ordinary image's Fourier
[I_enlarge_fft,enlarge_f] = fouriertrans(I_bi_enlarge);
figure(5);
subplot(1,2,1);imshow(F,[]);title('ordinary fourier');
subplot(1,2,2);imshow(I_enlarge_fft,[]);title('enlarged fourier');
%-------------------------------------------------------

%-------------------------------------------------------
% rotate the image and use bilinear
I_rotate = imrotate(I_double,60,'bilinear','loose'); % default counterclockwise
figure(6);
subplot(2,2,1);imshow(I_double,[]);title('ordinary image');
subplot(2,2,2);imshow(I_rotate,[]);title('rotate image');

% compare rotated image and ordinary image's Fourier
[I_rotate_fft,rotate_f] = fouriertrans(I_rotate);
subplot(2,2,3);imshow(F,[]);title('ordinary fourier');
subplot(2,2,4);imshow(I_rotate_fft,[]);title('rotate fourier');
%-------------------------------------------------------

%-------------------------------------------------------
% translate the image
se = translate(strel(1),[-30,30]);
I_translate = imdilate(I,se);  %use the expansion function to shift the image.
%I_translate = circshift(I,[30,30]);% cyclic shift
I_translate = double(I_translate);
figure(7);
subplot(2,2,1);imshow(I_double,[]);title('ordinary image');
subplot(2,2,2);imshow(I_translate,[]);title('translate image');
% compare translated image and ordinary image's Fourier
[I_translate_fft,translate_f] = fouriertrans(I_translate);
subplot(2,2,3);imshow(F,[]);title('ordinary fourier');
subplot(2,2,4);imshow(I_translate_fft,[]);title('translate fourier');
%-------------------------------------------------------

%figure;
%imhist(I);

% the function of the Fourier transform
function [I_Fourier,f] = fouriertrans(I)
f = fft2(I);
f = fftshift(f);
I_Fourier = log(1 + abs(f));
end
