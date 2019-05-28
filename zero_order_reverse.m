%% DeFilter

% A method from the paper Zero-order Reverse Filtering
% by Xin Tao et al.

%%

% The DeFilter is based on the fixed-point theroem
% INPUT: J_s - the filtering result of image I
%        f - an unknown filter
%        N - iterations
% OUTPUT: X_s - the final estimate of the defiltered image

%%

close all;
clc;

image = double(imread('Baker_Street.jpeg'));

figure(1);
imshow(uint8(image));
title('Original Image', 'fontsize', 14);

image = image/255;

N = 3;
window_width = 5;
sigma_r = 30;
sigma_d = 1;

%%

% First apply a filter to the image (bilateral or rolling guidance)
J_s = bilateral_filtering(image, window_width, sigma_r, sigma_d);
%J_s = rolling_guidance(image, window_width, 2, 0.1, N);

figure(2);
imshow(J_s);
title('Result of Filtering', 'fontsize', 14);

X = J_s;

% Use the expressions below instead in an enhacement situation
%J_s = image;
%X = image;



%%
for i = 1:5
    X = X + (J_s - bilateral_filtering(X, window_width, sigma_r, sigma_d));
    %X = X + (J_s - rolling_guidance(X, window_width, 2, 0.1, N));
end

figure(3);
imshow(X);
title('Result of Zero-Order Reverse Filtering', 'fontsize', 14);

