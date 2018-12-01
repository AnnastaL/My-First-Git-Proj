clear
close all

%图像读入及预处理
img_path = '1.png';
img_name = img_path(1:end-4);
I1 = imread(img_path);

R=I1(:,:,1);%红色分量
G=I1(:,:,2);%绿色分量
B=I1(:,:,3);%蓝色分量

%从RGB空间到HSV空间转换,以及查看H,S,V分量的Matlab程序实现
hv_pra=rgb2hsv(I1); 

maxcom = double(max(max(R,G),B)); 
mincom = double(min(min(R,G),B)); 
max_tmp = maxcom(:);
min_tmp = mincom(:);

s = maxcom - mincom;
s = s(:);

r = double(R(:));
g = double(G(:));
b = double(B(:));
H = zeros(size(max_tmp));  

k = find(r == max_tmp);
H(k) = (g(k) - b(k))./s(k);  
k = find(g == max_tmp);  
H(k) = 2 + (b(k) - r(k))./s(k);  
k = find(b == max_tmp);  
H(k) = 4 + (r(k) - g(k))./s(k); 
H = H * 60;
for i = 1:length(H)
    if H(i) < 0
        H(i) = H(i) + 360;
    end
end
H = reshape(H,size(maxcom));
H = H/360;
V = maxcom/255; 
S = (maxcom - mincom)./maxcom;
hv(:,:,1) = H;
hv(:,:,2) = S;
hv(:,:,3) = V;
% 
%可以通过下面的程序看一幅图的HSV三个通道 
%H1=hv_pra(:,:,1);
%S1=hv_pra(:,:,2);
%V1=hv_pra(:,:,3);
I2 = hsv2rgb(hv);% 利用自带的函数转换回去

figure;
subplot(1,2,1);imshow(I1);title('原始图像'); 
subplot(1,2,2);imshow(I2);title('转换回的原图');

figure;
subplot(2,2,1);imshow(hv);title('HSV空间I图像');
subplot(2,2,2);imshow(H);title('HSV空间H分量图像');
subplot(2,2,3);imshow(S);title('HSV空间S分量图像');
subplot(2,2,4);imshow(V);title('HSV空间V分量图像');