clear
close all

%ͼ����뼰Ԥ����
img_path = '1.png';
img_name = img_path(1:end-4);
I1 = imread(img_path);

R=I1(:,:,1);%��ɫ����
G=I1(:,:,2);%��ɫ����
B=I1(:,:,3);%��ɫ����

%��RGB�ռ䵽HSV�ռ�ת��,�Լ��鿴H,S,V������Matlab����ʵ��
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
%����ͨ������ĳ���һ��ͼ��HSV����ͨ�� 
%H1=hv_pra(:,:,1);
%S1=hv_pra(:,:,2);
%V1=hv_pra(:,:,3);
I2 = hsv2rgb(hv);% �����Դ��ĺ���ת����ȥ

figure;
subplot(1,2,1);imshow(I1);title('ԭʼͼ��'); 
subplot(1,2,2);imshow(I2);title('ת���ص�ԭͼ');

figure;
subplot(2,2,1);imshow(hv);title('HSV�ռ�Iͼ��');
subplot(2,2,2);imshow(H);title('HSV�ռ�H����ͼ��');
subplot(2,2,3);imshow(S);title('HSV�ռ�S����ͼ��');
subplot(2,2,4);imshow(V);title('HSV�ռ�V����ͼ��');