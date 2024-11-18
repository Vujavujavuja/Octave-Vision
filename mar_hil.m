function mar_hil
  img = domaci1v3(15,5);

  new_img = laplacian_o_gaus(img, 61, 5);

  org = imread('C:/Users/nvuji/Downloads/headCT.tif');
  org = double(img);

  zcd_img = zcd(new_img);

  subplot(2, 2, 1);
  imshow(uint8(org));
  title('Original');

  subplot(2, 2, 2);
  imshow(uint8(img));
  title('Gaus');

  subplot(2, 2, 3);
  imshow(uint8(new_img));
  title('LoG');

  subplot(2,2,4);
  imshow(uint8(zcd_img));
  title('ZCD');

endfunction

function edge = zcd(img)
  [r, c] = size(img);

  edge = zeros(r,c);

  for i = 2:r-1
    for j = 2:c-1
      if img(i, j) > 0.07
        if any(img(i-1:i+1, j-1:j+1)(:) < 0.07)
          edge(i, j) = 255;
        end
      elseif img(i, j) < 0.07
        if any(img(i-1:i+1, j-1:j+1)(:) > 0.07)
          edge(i, j) = 255;
        end
      end
    endfor
  endfor

endfunction

function new_img=laplacian_o_gaus (img, n, s)
  lg = zeros(n, n)
  xc = (n + 1) / 2
  yc = xc

  for i = 1:n
    for j = 1:n
      x = j - xc;
      y = i - yc;
      lg(i, j) = ((x^2 + y^2 - 2 * s^2) / s^4) * exp(-(x^2 + y^2) / (2 * s^2));
    endfor
  endfor

  new_img = conv2(img, lg, 'same');

endfunction

function new_img=domaci1v3(n, s)
  img = imread('C:/Users/nvuji/Downloads/headCT.tif');
  img = double(img);

  gf = f_linFilt(n, s);

  new_img = conv2(img, gf, 'same');
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

