% Load the image and convert to double
im_p = double(imread('C:/Users/nvuji/Downloads/dog.jpg'));

% Get the dimensions of the color image
[nvp, nkp, ~] = size(im_p);

% Define the cutoff frequency for the high-pass filter
cutoff = 30;  % Adjust based on desired frequency threshold

% Create a frequency distance matrix
[X, Y] = meshgrid(1:nkp, 1:nvp);
D = sqrt((X - nkp/2).^2 + (Y - nvp/2).^2);

% Define H as a high-pass filter
H = double(D > cutoff);  % Creates a mask with 1s outside the cutoff radius

% Initialize an empty array for the filtered color image
imf = zeros(nvp, nkp, 3);  % Full-sized output for each channel

% Process each color channel separately
for channel = 1:3
    % Extract the channel
    im_channel = im_p(:, :, channel);

    % Apply the frequency filter to the channel
    imf(:, :, channel) = f_filtriranjeFrekv(im_channel, H);
end

% Display the final filtered color image
figure, imshow(uint8(imf))
title('Filtered Color Image')

