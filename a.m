I1 = zeros(256, 256);
I2 = zeros(256, 256);
for i = 1 : 128
    I1(:, i) = 1;
end

for i = 1 : 8 : 256
    for j = 1 : 8 : 256
        I2(i:i+3,j:j+3) = 1;
    end
end
for i = 5 : 8 : 256
    for j = 5 : 8 : 256
        I2(i:i+3,j:j+3) = 1;
    end
end

figure(1);
imshow(I1);
figure(2);
imshow(I2);

template_average3 = ones(3);
I_31 = filter(I1,template_average3);
I_32 = filter(I2,template_average3);


figure(3);
subplot(2,2,1);imshow(I1);title('image 1');
subplot(2,2,2);imhist(I_31);title('hist image 1');
subplot(2,2,3);imshow(I2);title('image 2');
subplot(2,2,4);imhist(I_32);title('hist image 2');

function  I_filter = filter(I,t)

n = length(t);
[height,width] = size(I);
I = double(I);
I_filter = I;
for i = 1:height-n+1
    for j = 1:width-n+1
        c = I(i:i+n-1,j:j+n-1).*t;
        s = sum(sum(c));
        I_filter(i+(n-1)/2,j+(n-1)/2) = s/sum(sum(t));
    end
end
I_filter = uint8(I_filter);
end

