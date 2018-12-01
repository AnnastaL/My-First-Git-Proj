% clear
% close all
%ͼ����뼰Ԥ����
img_path = '1.png';
img_name = img_path(1:end-4);
I1 = imread(img_path);

%I1 = mat2gray(I1);
R = I1(:,:,1);%��ɫ����
G = I1(:,:,2);%��ɫ����
B = I1(:,:,3);%��ɫ����

h = rgb2hsv(I1);
H = h (:,:,1);
S = h (:,:,2);
V = h (:,:,3);

%������˹V
lapMatrix=[1 1 1;1 -8 1;1 1 1];    
v_tmp=imfilter(V,lapMatrix,'replicate'); 
V_sharped=imsubtract(V,v_tmp); 
img_v_sharped = cat(3,H,S,V_sharped); 
rgb_v_sharped = hsv2rgb(img_v_sharped);
%grid on
figure;
subplot(1,2,1);imshow(I1); title('ԭͼ');
subplot(1,2,2);imshow(rgb_v_sharped); title('V�����񻯺�');


% %������˹��
% lapMatrix=[1 1 1;1 -8 1;1 1 1];    
% i_tmp=imfilter(I1,lapMatrix,'replicate'); 
% i_sharped=imsubtract(I1,i_tmp); 
% figure;   
% imshow(i_sharped); title('�񻯺�');
% % imwrite(i_sharped, 'RGB��ɫ�ռ��񻯺�.jpg');

% %���ͼ������������������������ǿ
% %�ֱ������ɫ������ֱ��ͼ���⻯
% subplot(4,2,1),imshow(I1);       %���Ƹ�������ͼ����ֱ��ͼ  
% title('ԭʼ���ɫͼ��');            
% subplot(4,2,3),imshow(R);  
% title('���ɫͼ��ĺ�ɫ����');  
% subplot(4,2,4), imhist(R);  
% title('���ɫͼ��ĺ�ɫ����ֱ��ͼ');  
% subplot(4,2,5),imshow(G);  
% title('���ɫͼ�����ɫ����');  
% subplot(4,2,6), imhist(G);  
% title('���ɫͼ�����ɫ����ֱ��ͼ');  
% subplot(4,2,7),imshow(B);  
% title('���ɫͼ�����ɫ����');  
% subplot(4,2,8), imhist(B);  
% title('���ɫͼ�����ɫ����ֱ��ͼ');  
%   
% r=histeq(R);             %�Ը�����ֱ��ͼ���⻯���õ����������⻯ͼ��     
% g=histeq(G);    
% b=histeq(B);   
% figure,  
% subplot(3,2,1),imshow(r);  
% title('��ɫ�������⻯��ͼ��');  
% subplot(3,2,2), imhist(r);  
% title('��ɫ�������⻯��ͼ��ֱ��ͼ');  
% subplot(3,2,3),imshow(g);  
% title('��ɫ�������⻯��ͼ��');  
% subplot(3,2,4), imhist(g);  
% title('��ɫ�������⻯��ͼ��ֱ��ͼ');  
% subplot(3,2,5), imshow(b);  
% title('��ɫ�������⻯��ͼ��');  
% subplot(3,2,6), imhist(b);  
% title('��ɫ�������⻯��ͼ��ֱ��ͼ');  
%   
% figure,       %ͨ�����⻯���ͼ��ԭ���ԭͼ��                      
% newimg = cat(3,r,g,b);                  
% imshow(newimg,[]);  
% title('���⻯�����ͼ��ԭ���ԭͼ');  

% 
% %������˹H
% lapMatrix=[1 1 1;1 -8 1;1 1 1];    
% i_tmp=imfilter(H,lapMatrix,'replicate'); 
% H_sharped=imsubtract(H,i_tmp); 
% img_h_sharped = cat(3,H_sharped,S,V); 
% rgb_h_sharped = hsi2rgb(img_h_sharped);
% imwrite(rgb_h_sharped, 'H�����񻯺�.jpg');
% subplot(2,2,1);imshow(I1);  title('ԭͼ');
% subplot(2,2,2); imshow(rgb_h_sharped); title('H�����񻯺�');
% 
% % %������˹S
% lapMatrix=[1 1 1;1 -8 1;1 1 1];    
% i_tmp=imfilter(S,lapMatrix,'replicate'); 
% s_sharped=imsubtract(S,i_tmp); 
% img_s_sharped = cat(3,H,s_sharped,V); 
% rgb_s_sharped = hsi2rgb(img_s_sharped);
% 
% imwrite(rgb_s_sharped, 'S�����񻯺�.jpg');
% grid on
% subplot(2,2,3); imshow(rgb_s_sharped); title('S�����񻯺�');