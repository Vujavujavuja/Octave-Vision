## Copyright (C) 2024 Dragana
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} f_filtriranjeFrekv (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Dragana <Dragana@DESKTOP-3E5DJK6>
## Created: 2024-02-16

% im_p - slika dopunjena nulama

function im_f_crop = f_filtriranjeFrekv (im_p, H)

    %im_p = im2double(im_p);
    [nvp  nkp] = size(im_p);
    nv = nvp/2;
    nk = nkp/2;

    % DFT prosirene slike
    im_fft = fft2(im_p);

    % centriranje FT za prikaz
    im_fft_c = fftshift(im_fft);
    % spektar slike:
    spektar_im_fft_c = abs(im_fft_c);

    spektar_im_fft_c_log = log(1+spektar_im_fft_c);
    figure, imshow(spektar_im_fft_c_log, [])
    title('centrirani spektar slike')

    korak = 1;
    figure, mesh(H(1:korak:end, 1:korak:end))
    axis off
    figure, imshow(H, [])
    title('transfer fja filtra')

    % decentrirani spektar filtra
    Gdc = ifftshift(H);

    % filtriranje u frekvenc domenu
    % mnozenje decentriranih DFT slike i DFT filtra
    im_f_fft = im_fft.*Gdc;

    % centriranje za prikaz nakon filtriranja
    im_f_fft_c = fftshift(im_f_fft);
    % spektar filtrirane slike:
    spektar_im_f_fft_c = abs(im_f_fft_c);

    spektar_im_f_fft_c_log = log(1+spektar_im_f_fft_c);
    figure, imshow(spektar_im_f_fft_c_log, [])
    title('centrirani spektar filtrirane slike')

    % inverzna Fur. tr.
    im_f = ifft2(im_f_fft);

    % filtrirana slika
    im_f_r = real(im_f);
    figure, imshow(im_f_r, [])
    title('slika nakon IDFT')

    im_f_crop = im_f_r(1:nv, 1:nk);
    figure, imshow(im_f_crop, [])
    title('filtrirana slika')

endfunction
