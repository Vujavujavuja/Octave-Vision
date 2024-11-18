function domaci1v3(s)
  img = imread('C:/Users/nvuji/Downloads/testpattern1024.tif');
  img = double(img);

  n = 61;

  gf = f_linFilt(n, s);

  new_img = conv2(img, gf, 'same');

  subplot(1, 2, 1);
  imshow(uint8(img));
  title('Original Image');

  subplot(1, 2, 2);
  imshow(uint8(new_img));
  title('Blurred Image');
endfunction

function gf = f_linFilt(n, s)
  gf = zeros(n, n);
  xc = (n + 1) / 2;
  yc = xc;

  for i = 1:n
    for j = 1:n
      x = j - xc;
      y = i - yc;
      gf(i, j) = gaus(x, y, s);
    endfor
  endfor

  gf = gf / sum(gf(:));
endfunction

function val = gaus(x, y, s)
  K = 1 / (2 * pi * s ^ 2);
  val = K * exp(-(x^2 + y^2) / (2 * s^2));
endfunction

