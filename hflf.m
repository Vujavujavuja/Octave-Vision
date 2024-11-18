function hflf
  img1 = imread('C:/Users/nvuji/Downloads/cat.jpg');
  img2 = imread('C:/Users/nvuji/Downloads/dog.jpg');
  img1 = double(img1);
  img2 = double(img2);

  subplot(3,2,1);
  imshow(uint8(img1));

  subplot(3,2,2);
  imshow(uint8(img2));

  img1_r = img1(:,:,1);
  img1_g = img1(:,:,2);
  img1_b = img1(:,:,3);

  img2_r = img2(:,:,1);
  img2_g = img2(:,:,2);
  img2_b = img2(:,:,3);

  D0 = 15;

  [r1, c1] = size(img1_r);
  [r2, c2] = size(img2_r);

  H1 = passL(r1, c1, D0);
  freq1_r = lpf(img1_r, H1);
  freq1_g = lpf(img1_g, H1);
  freq1_b = lpf(img1_b, H1);

  H2 = passH(r2, c2, D0);
  freq2_r = lpf(img2_r, H2);
  freq2_g = lpf(img2_g, H2);
  freq2_b = lpf(img2_b, H2);

  F_img2 = cat(3, freq2_r, freq2_g, freq2_b);


  F_img1 = cat(3, freq1_r, freq1_g, freq1_b);

  subplot(3,2,3);
  imshow(mat2gray(F_img1));

  subplot(3,2,4);
  imshow(mat2gray(F_img2));

  combined_img = F_img1 + F_img2;

  subplot(3,2,5);
  imshow(mat2gray(combined_img));

endfunction

function lfc = lpf(channel, H)
  F_channel = fft2(channel);
  F_channel = fftshift(F_channel) .* H;
  F_channel = ifftshift(F_channel);
  lfc = real(ifft2(F_channel));
endfunction

function H = passL(rows, cols, D0)
  H = zeros(rows, cols);
  xc = (cols + 1) / 2;
  yc = (rows + 1) / 2;

  for i = 1:rows
    for j = 1:cols
      x = j - xc;
      y = i - yc;
      D = sqrt(x^2 + y^2);
      if D <= D0
        H(i, j) = 1;
      else
        H(i, j) = 0;
      endif
    endfor
  endfor
endfunction

function H = passH(rows, cols, D0)
  H = zeros(rows, cols);
  xc = (cols + 1) / 2;
  yc = (rows + 1) / 2;

  for i = 1:rows
    for j = 1:cols
      x = j - xc;
      y = i - yc;
      D = sqrt(x^2 + y^2);
      if D <= D0
        H(i, j) = 0;
      else
        H(i, j) = 1;
      endif
    endfor
  endfor
endfunction

