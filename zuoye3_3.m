% clear
% close all
%图像读入及预处理
img_path = '1.png';
img_name = img_path(1:end-4);
I1 = imread(img_path);

%I1 = mat2gray(I1);
R = I1(:,:,1);%红色分量
G = I1(:,:,2);%绿色分量
B = I1(:,:,3);%蓝色分量

h = rgb2hsv(I1);
H = h (:,:,1);
S = h (:,:,2);
V = h (:,:,3);

%拉普拉斯V
lapMatrix=[1 1 1;1 -8 1;1 1 1];    
v_tmp=imfilter(V,lapMatrix,'replicate'); 
V_sharped=imsubtract(V,v_tmp); 
img_v_sharped = cat(3,H,S,V_sharped); 
rgb_v_sharped = hsv2rgb(img_v_sharped);
%grid on
figure;
subplot(1,2,1);imshow(I1); title('原图');
subplot(1,2,2);imshow(rgb_v_sharped); title('V分量锐化后');


% %拉普拉斯锐化
% lapMatrix=[1 1 1;1 -8 1;1 1 1];    
% i_tmp=imfilter(I1,lapMatrix,'replicate'); 
% i_sharped=imsubtract(I1,i_tmp); 
% figure;   
% imshow(i_sharped); title('锐化后');
% % imwrite(i_sharped, 'RGB彩色空间锐化后.jpg');

% %输出图像轮廓更清晰，亮度明显增强
% %分别对三基色分量做直方图均衡化
% subplot(4,2,1),imshow(I1);       %绘制各分量的图像及其直方图  
% title('原始真彩色图像');            
% subplot(4,2,3),imshow(R);  
% title('真彩色图像的红色分量');  
% subplot(4,2,4), imhist(R);  
% title('真彩色图像的红色分量直方图');  
% subplot(4,2,5),imshow(G);  
% title('真彩色图像的绿色分量');  
% subplot(4,2,6), imhist(G);  
% title('真彩色图像的绿色分量直方图');  
% subplot(4,2,7),imshow(B);  
% title('真彩色图像的蓝色分量');  
% subplot(4,2,8), imhist(B);  
% title('真彩色图像的蓝色分量直方图');  
%   
% r=histeq(R);             %对个分量直方图均衡化，得到个分量均衡化图像     
% g=histeq(G);    
% b=histeq(B);   
% figure,  
% subplot(3,2,1),imshow(r);  
% title('红色分量均衡化后图像');  
% subplot(3,2,2), imhist(r);  
% title('红色分量均衡化后图像直方图');  
% subplot(3,2,3),imshow(g);  
% title('绿色分量均衡化后图像');  
% subplot(3,2,4), imhist(g);  
% title('绿色分量均衡化后图像直方图');  
% subplot(3,2,5), imshow(b);  
% title('蓝色分量均衡化后图像');  
% subplot(3,2,6), imhist(b);  
% title('蓝色分量均衡化后图像直方图');  
%   
% figure,       %通过均衡化后的图像还原输出原图像                      
% newimg = cat(3,r,g,b);                  
% imshow(newimg,[]);  
% title('均衡化后分量图像还原输出原图');  

% 
% %拉普拉斯H
% lapMatrix=[1 1 1;1 -8 1;1 1 1];    
% i_tmp=imfilter(H,lapMatrix,'replicate'); 
% H_sharped=imsubtract(H,i_tmp); 
% img_h_sharped = cat(3,H_sharped,S,V); 
% rgb_h_sharped = hsi2rgb(img_h_sharped);
% imwrite(rgb_h_sharped, 'H分量锐化后.jpg');
% subplot(2,2,1);imshow(I1);  title('原图');
% subplot(2,2,2); imshow(rgb_h_sharped); title('H分量锐化后');
% 
% % %拉普拉斯S
% lapMatrix=[1 1 1;1 -8 1;1 1 1];    
% i_tmp=imfilter(S,lapMatrix,'replicate'); 
% s_sharped=imsubtract(S,i_tmp); 
% img_s_sharped = cat(3,H,s_sharped,V); 
% rgb_s_sharped = hsi2rgb(img_s_sharped);
% 
% imwrite(rgb_s_sharped, 'S分量锐化后.jpg');
% grid on
% subplot(2,2,3); imshow(rgb_s_sharped); title('S分量锐化后');