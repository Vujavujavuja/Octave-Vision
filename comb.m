img1 = double(imread('C:/Users/nvuji/Downloads/cat.jpg'));
img2 = double(imread('C:/Users/nvuji/Downloads/dog.jpg'));

cutoff = 20;

[rows, cols, ~] = size(img1);

low_freq_img1 = zeros(rows, cols, 3);
high_freq_img2 = zeros(rows, cols, 3);

[X, Y] = meshgrid(1:cols, 1:rows);
D = sqrt((X - cols/2).^2 + (Y - rows/2).^2);

low_pass_filter = D <= cutoff;
high_pass_filter = 1 - low_pass_filter;

for channel = 1:3
    F1 = fftshift(fft2(img1(:, :, channel)));
    F2 = fftshift(fft2(img2(:, :, channel)));

    low_freq_img1(:, :, channel) = real(ifft2(ifftshift(F1 .* low_pass_filter)));
    high_freq_img2(:, :, channel) = real(ifft2(ifftshift(F2 .* high_pass_filter)));
end

low_freq_img1 = uint8(255 * mat2gray(low_freq_img1));
high_freq_img2 = uint8(255 * mat2gray(high_freq_img2));

high_freq_img2 = high_freq_img2 * 1.5;

subplot(1, 3, 1);
imshow(low_freq_img1);

subplot(1, 3, 2);
imshow(high_freq_img2);

hybrid_img = low_freq_img1 + high_freq_img2;
hybrid_img = uint8(255 * mat2gray(hybrid_img));

subplot(1, 3, 3);
imshow(hybrid_img);
