%% BILATERAL FILTERING

% A method from the paper Bilateral Filtering for Gray and Color Images
% by C.Tomasi et al.

%%
% Combined domain and range filtering is denoted as bilateral filtering
% INPUT: image - the original color image
%        width - width of the sliding window
%        sigma_r
%        sigma_d
% OUTPUT:an image after bilateral filtering
%%

function [output] = bilateral_filtering(image, width, sigma_r, sigma_d) 

    [xi, x] = meshgrid(-width:width, -width:width);

    closeness = exp(-(xi.^2 + x.^2) / (2 * sigma_d^2));

    output = zeros(size(image));

    for channel = 1:3

        cur_channel = image(:, :, channel);
        [r, c] = size(cur_channel);
        for i = 1:r
            for j = 1:c
                %create a widow
                i_min = max(i-width, 1);
                i_max = min(i+width, r);
                j_min = max(j-width, 1);
                j_max = min(j+width, c);
                nearby = cur_channel(i_min:i_max, j_min:j_max);

                similarity = exp(-(nearby-cur_channel(i, j)).^2 / (2 * sigma_r^2)); 

                combine_filter = closeness((i_min:i_max)-i+width+1, (j_min:j_max)-j+width+1) .* similarity;

                normalize = sum(sum(combine_filter(:)));

                output(i, j, channel) = sum(sum(nearby .* combine_filter)) / normalize;
            end
        end
    end

end
