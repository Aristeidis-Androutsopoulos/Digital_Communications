function [a, R_cap_matrix, r_cap_vector] = autocorrelation(x, p)
    %% Approximations of Autocorrelation Matrix R and Autocorrelation Vector r
    
    % Calculate input size once in the beginning
    input_size = numel(x);
    
    % Initializations
    r_cap_vector = zeros(1, p);
    R_cap_matrix = zeros(p);
    
    %% Approximation of Autocorrelation Vector r
    
    % Without Vectorized Operations: Clearer Code
    % for i = 1:p
    %     sigma = 0;
    %     for n = p+1:input_size
    %         sigma = sigma + x(n)*x(n-i);
    %     end
    %     r_cap_vector(i) = 1/(input_size - p) * sigma;
    % end
    
    % With Vectorized Operations: More Efficient
    for i = 1:p
        r_cap_vector(i) = mean(x(p+1:end) .* x(p+1-i:end-i));
    end
    r_cap_vector = r_cap_vector';
    
    %% Approximation of Autocorrelation Matrix R
    
    % Without Vectorized Operations: Clearer Code
    % for i = 1:p
    %     for j=1:p
    %         sigma = 0;
    %         for n = p+1:input_size
    %             sigma = sigma + m(n-j)*m(n-i);
    %         end
    %         R_cap_matrix(i,j) = 1/(input_size - p) * sigma;
    %     end
    % end
    
    % With Vectorized Operations: More Efficient
    for i = 1:p
        for j = 1:p
            R_cap_matrix(i, j) = mean(x(p+1-j:end-j) .* x(p+1-i:end-i))';
        end
    end
    
    %% Coefficients a(i)
    % Yule-Walker equations to find AR coefficients
    
    % Without Build-in Optimizations on the invert: Clearer Code
    % a = inv(R_cap_matrix) * R_cap_vector;
    
    % With Build-in Optimizations on the multiplication inlcuding the invert: Most Efficient
    a = R_cap_matrix\r_cap_vector;
end