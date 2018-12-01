clear
close all
%��Ե���
p=imread('lena.jpg');
p = rgb2gray(p);
p=im2double(p);  %ת��Ϊdouble

[e1,s1] = edge(p,'sobel',0.03,'both');     % sobel�����
[e2,s2] = edge(p,'roberts',0.03,'both');   % roberts�����
[e3,s3] = edge(p,'prewitt',0.04,'both');   % prewitt�����
[e4,s4] = edge(p,'log',0.003,2.10);        % LoG�����
[e5,s5] = edge(p,'canny',[0.05 0.12],1.6); %canny�����

subplot(2,3,1),imshow(p);subplot(2,3,2),imshow(e1);
subplot(2,3,3),imshow(e2);subplot(2,3,4);imshow(e3);
subplot(2,3,5),imshow(e4);subplot(2,3,6),imshow(e5);
