clear
close all
%�õ�����ֵѡȡ������ͼ��ȫ����ֵ����ͼ����зָ�

p= imread('lena.jpg');
p=rgb2gray(p);
p=im2double(p);    %ת��Ϊdouble
thresh = 0.5*(min(p(:)) + max(p(:)));   %��ֵΪ�м�ֵ
flag = false;   %������������
while ~flag
    g = p>=thresh;   %����ǰ��ֵ����
    thresh_1= 0.5*(mean(p(g)) + mean(p(~g))); %����ֵ
    flag = abs(thresh - thresh_1)<0.5;  %���µ�����־
    thresh = thresh_1;  %������ֵ
end
figure(1),imshow(p);
figure(2), imshow(g);