clear
close all
%用迭代阈值选取法计算图像全局阈值并对图像进行分割

p= imread('lena.jpg');
p=rgb2gray(p);
p=im2double(p);    %转换为double
thresh = 0.5*(min(p(:)) + max(p(:)));   %初值为中间值
flag = false;   %迭代步长控制
while ~flag
    g = p>=thresh;   %按当前阈值划分
    thresh_1= 0.5*(mean(p(g)) + mean(p(~g))); %新阈值
    flag = abs(thresh - thresh_1)<0.5;  %更新迭代标志
    thresh = thresh_1;  %更新阈值
end
figure(1),imshow(p);
figure(2), imshow(g);