clear
close all
% 用最大方差阈值对图像进行分割。分割前后效果如图所示。

p = imread('lena.jpg');
p1 = rgb2gray(p);
thresh = graythresh(p1);   %使用Ostu算法求得新阈值
g = im2bw(p1,thresh);    %使用thresh对图像进行分割 
figure(1), imshow(p);
figure(2), imshow(g);
