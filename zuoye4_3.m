clear
close all
% ����󷽲���ֵ��ͼ����зָ�ָ�ǰ��Ч����ͼ��ʾ��

p = imread('lena.jpg');
p1 = rgb2gray(p);
thresh = graythresh(p1);   %ʹ��Ostu�㷨�������ֵ
g = im2bw(p1,thresh);    %ʹ��thresh��ͼ����зָ� 
figure(1), imshow(p);
figure(2), imshow(g);
