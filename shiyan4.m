clc;
close all;

[fn, pn, fi] = uigetfile('*.jpg', 'choose');
I = imread([pn fn]);
if ndims(I) == 3
    I = rgb2gray(I);
end


%Ƶ�����˲� 
I = im2double(I);
f = fftshift(fft2(I));
F = log(1+abs(f));

%�����ͨ�˲�   
F_out1 = ideal_LPF(I, f, 32);           %�����ͨ�˲���r = 32
I_out1 = ifft2(ifftshift(F_out1)); 
I_out1 = abs(I_out1);                   %��ģ
figure(1);
subplot(2, 2, 1);
imshow(I);
title("ԭͼ");
subplot(2, 2, 2);
imshow(I_out1, []);
title("�����ͨ�˲�");

%������˹��ͨ�˲�   
F_out2 = Butterworth_LPF(I, f, 2, 32);        
I_out2 = ifft2(ifftshift(F_out2)); 
I_out2 = abs(I_out2);                              
subplot(2, 2, 3);
imshow(I_out2, []);
title("������˹��ͨ�˲�");

%��˹��ͨ�˲�   
F_out3 = Gauss_LPF(I, f, 32);        
I_out3 = ifft2(ifftshift(F_out3)); 
I_out3 = abs(I_out3);                              
subplot(2, 2, 4);
imshow(I_out3, []);
title("��˹��ͨ�˲�");

%�����ͨ�˲�   
F_out4 = ideal_HPF(I, f, 32);    
I_out4 = ifft2(ifftshift(F_out4)); 
I_out4 = abs(I_out4);                   %��ģ
figure(2);
subplot(2, 2, 1);
imshow(I);
title("ԭͼ");
subplot(2, 2, 2);
imshow(I_out4, []);
title("�����ͨ�˲�");

%������˹��ͨ�˲�   
F_out5 = Butterworth_HPF(I, f, 2, 32);        
I_out5 = ifft2(ifftshift(F_out5)); 
I_out5 = abs(I_out5);                              
subplot(2, 2, 3);
imshow(I_out5, []);
title("������˹��ͨ�˲�");

%��˹��ͨ�˲�   
F_out6 = Gauss_HPF(I, f, 32);        
I_out6 = ifft2(ifftshift(F_out6)); 
I_out6 = abs(I_out6);                              
subplot(2, 2, 4);
imshow(I_out6, []);
title("��˹��ͨ�˲�");

%�����Ƶ��ǿ
I_out7 = im2double(I_out4);  
I_out7 = I_out7 + I;          %��ԭͼ����Դﵽ��ǿЧ��
figure(3);
subplot(2, 2, 1);
imshow(I);
title("ԭͼ");
subplot(2, 2, 2);
imshow(I_out7,[]);
title("�����Ƶ��ǿ");
%������˹��Ƶ��ǿ
I_out8 = im2double(I_out5); 
I_out8 = I_out8 + I;
subplot(2, 2, 3);
imshow(I_out8,[]);
title("������˹Ƶ��ǿ");
%��˹��Ƶ��ǿ
I_out9 = im2double(I_out6);
I_out9 = I_out9 + I;
subplot(2, 2, 4);
imshow(I_out9,[]);
title("������˹Ƶ��ǿ");

%������˹���Ӹ�ͨ�˲�
I_out10 = Laplace_HPF(I);                           
I_out10 = mapminmax(I_out10, 0, 1);                        
I_out10 = I + I_out10;
figure(4);
subplot(1, 2, 1);
imshow(I);
title("ԭͼ");
subplot(1, 2, 2);
imshow(I_out10,[]);
title("������˹�˲���ǿ");

%������˹�����˲�
function I_out = Laplace_HPF(I)                   
I = (I - min(I(:))) / (max(I(:)) - min(I(:)) + eps);
[M, N] = size(I);
padsiz = [3 3];
bP = padsiz(1);
bQ = padsiz(2);
Ib = padarray(I,padsiz,'replicate');
P = 2 * (M + 2 * bP); 
Q = 2 * (N + 2 * bQ);
Ibp = zeros(P,Q);
Ibp(1 : M + 2 * bP, 1 : N + 2 * bQ) = Ib;
Fbp = fftshift(fft2(Ibp)); 
H = zeros(P, Q);
for i = 1 : P 
    for j = 1 : Q
        D = (i - 1 - P / 2)^2 + ( j - 1 - Q / 2)^2;
        H(i, j) =  -4 * pi * pi * D;
    end
end
F_out = Fbp .* H;
I_out = abs(ifft2(ifftshift(F_out)));
I_out = I_out(1 + bP : M+ bP, 1 + bQ : N + bQ);
end


%�����ͨ�˲���rΪ�뾶
function F_out = ideal_LPF(I, f, r)             
[M, N] = size(I);  
H = ones(M, N);  
for i = 1 : M  
    for j = 1 : N  
        if (sqrt(((i - M / 2)^2 + (j - N / 2)^2)) > r)  
            H(i, j) = 0;  
        end  
    end  
end
F_out = f .* H;        %��ӦԪ�����ʵ��Ƶ���˲�
end


%�����ͨ�˲�
function F_out = ideal_HPF(I, f, r)                
[M, N] = size(I);  
H = ones(M, N);  
for i = 1 : M  
    for j = 1 : N  
        if (sqrt(((i - M / 2)^2 + (j - N / 2)^2)) < r)  
            H(i, j) = 0;  
        end  
    end  
end
F_out = f .* H;
end


%������˹��ͨ�˲���nΪ������D0Ϊ��ֹƵ��
function F_out = Butterworth_LPF(I, f, n, D0)               
[M, N] = size(I);
H = zeros(M, N);
for i = 1 : M
    for j = 1 : N
        D = sqrt((i - M / 2)^2 + (j - N / 2)^2);
        H(i, j) = 1 / (1 + (D / D0)^(2 * n));
    end
end
F_out = f .* H;
end

%������˹��ͨ�˲�����nΪ������D0Ϊ��ֹƵ��
function F_out = Butterworth_HPF(I, f, n, D0)
[M, N] = size(I);
H = zeros(M, N);
for i = 1 : M
    for j = 1 : N
        D = sqrt((i - M / 2)^2 + (j - N / 2)^2);
        if D == 0
            H(i, j) = 0;
        else
            H(i, j) = 1 / (1 + (D0 / D)^(2 * n));
        end
    end
end
F_out = f .* H;
end


%��˹��ͨ�˲���D0Ϊ��ֹƵ��
function F_out = Gauss_LPF(I, f, D0)               
[M, N] = size(I);
H = zeros(M, N);
for i = 1 : M
    for j = 1 : N
        D = sqrt((i - M / 2)^2 + (j - N / 2)^2);
        H(i, j) = exp(-(D.^2)./(2*(D0^2)));
    end
end
F_out = f .* H;
end

%��˹��ͨ�˲���D0Ϊ��ֹƵ��
function F_out = Gauss_HPF(I, f, D0)               
[M, N] = size(I);
H = zeros(M, N);
for i = 1 : M
    for j = 1 : N
        D = sqrt((i - M / 2)^2 + (j - N / 2)^2);
        H(i, j) = 1 - exp(-(D.^2)./(2*(D0^2)));
    end
end
F_out = f .* H;
end