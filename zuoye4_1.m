clear
close all
%±ßÔµ¼ì²â
p=imread('lena.jpg');
p = rgb2gray(p);
p=im2double(p);  %×ª»»Îªdouble

[e1,s1] = edge(p,'sobel',0.03,'both');     % sobel¼ì²âÆ÷
[e2,s2] = edge(p,'roberts',0.03,'both');   % roberts¼ì²âÆ÷
[e3,s3] = edge(p,'prewitt',0.04,'both');   % prewitt¼ì²âÆ÷
[e4,s4] = edge(p,'log',0.003,2.10);        % LoG¼ì²âÆ÷
[e5,s5] = edge(p,'canny',[0.05 0.12],1.6); %canny¼ì²âÆ÷

subplot(2,3,1),imshow(p);subplot(2,3,2),imshow(e1);
subplot(2,3,3),imshow(e2);subplot(2,3,4);imshow(e3);
subplot(2,3,5),imshow(e4);subplot(2,3,6),imshow(e5);
