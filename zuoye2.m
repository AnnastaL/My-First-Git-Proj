q = imread('Fig01.tif');
t = im2double(q);
s = imadjust(t,[0,0.6],[0,1]);
subplot(1,2,1);
imshow(q);
subplot(1,2,2);
imshow(s);

figure;
w = imread('Fig02.tif');
e = im2double(w);
r = e.^0.3;
subplot(1,2,1);
imshow(w);
subplot(1,2,2);
imshow(r);

figure;
d = imread('Fig03.tif');
f = im2double(d);
g = f.^3;
subplot(1,2,1);
imshow(d);
subplot(1,2,2);
imshow(g);

figure;
f4 = imread('Fig04.tif');
[m,n] = size(f4);
subplot(3,3,1);
imshow(f4);
tmp = double(f4);
for i = 1:8
    t = bitget(tmp,i);
    subplot(3,3,i+1);
    imshow(t);
end
