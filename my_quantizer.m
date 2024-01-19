function [level, centers] = my_quantizer(e_n, N, min_value, max_value, centers)
%my_quantizer: A uniform quantizer that takes in a single value e_n to quantize
%within (min_value, max_value) with 2^N Levels of Quantization.
%!!!Important!!! the centers vector remains the same in each function call
%for the entire encoding process of the input signal. For this reason we
%can avoid recalculating the vector by outputing it only once and then
%giving it as an argument to this function

% The chosen rounding method
% rounding = @floor;

% Limit input value to (min, max) limit
e_n = max(min_value, min(e_n, max_value));

% Range of input values
R = max_value - min_value;

% Number of Quantization Levels
L = 2^N;

% Quantization Step Size Δ
delta = R/L;

%% Centers (if not provided)
if nargin < 5
    % Calculate the centers
    centers = max_value - delta/2 - (0:(L-1)) * delta;
end


%% Get the level for the input: rounding((max_value - e_n)/delta) + ((sign(e_n) + 1) / 2) * 1;
if sign(e_n) == 1
    level = floor((max_value - e_n)/delta) + sign(e_n)/2 + 1/2;
elseif sign(e_n) == -1
    level = ceil((max_value - e_n)/delta) + sign(e_n)/2 + 1/2;
end



end