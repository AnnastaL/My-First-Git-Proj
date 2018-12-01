clear
close all
%极小值点阈值
p = imread('lena.jpg');
p = rgb2gray(p);
imshow(p);
figure;
imhist(p);

count = zeros(1,255);
for n = 1:256
    a = (p == n-1);
    count(n) = sum(sum(a));
end

a = min(count(50:100));
t = find(count==a);
t = t/255;
g = im2bw(p,t);
figure;
imshow(g);