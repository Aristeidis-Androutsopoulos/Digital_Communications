% !!! All variable names are based on the Digital Telecommunications Book
% by Karayiannidis and Papph

%% Load the input signal
load source.mat;
 plot(t);

 mse = zeros(3,6);

 signal_1 = t(1:5000);
 signal_2 = t(5001:10000);
 signal_3 = t(10001:15000);
 signal_4 = t(15001:20000);

 e_all = {};
 y_all = {};
%% Initialize Variables
all_a = {};
for p = 6:4:10
    for N=1:3
        % m - input signal vector
        m=signal_3;
        % # of Input Signal samples
        input_size = numel(m);
        % Output of recostructed samples - Output Signal
        y = zeros(input_size,1);
        
        % Order of Predictor
        % p = 10;
        % % Quantization Bits
        % N = 3;
        % Dynamic Range
        min_value =-3.5;
        max_value = 3.5;
        
        % Memory for the Predictor Input: Keeps last p values
        y_memory = zeros(p,1);
        y_memory_dec = zeros(p,1);
        % Approximation of m for Transmitter and Receiver
        m_cap = zeros(input_size,1);
        m_cap_dec = zeros(input_size,1);
        % Error of input-approximation of input
        e = zeros(input_size, 1);
        % Quantization Levels of input samples
        e_q_level = zeros(input_size, 1);
        % Quantized Error Vector
        e_q = zeros(input_size, 1);
        
        %% Autocorellation and Coefficients
        [a, R_cap_matrix, r_cap_vector] = autocorrelation(m, p);
        a_centers = zeros(2^8,1);
        
        % Quantization of the Coefficients to be used and send to receiver
        for i = 1:numel(a)
            if i==1
                [a(i), a_centers] = my_quantizer(a(i), 8, -2, 2);
            else
                a(i) = my_quantizer(a(i), 8, -2, 2, a_centers);
            end
        end
        
        a(:) = a_centers(a(:));
        
        %% Testing Autocorellation Matrix with built-in Matlab function
        
        % Calculate the sample autocorrelation function
        
        % Rx_sample = xcorr(m, m, p,'unbiased');
        % 
        % for i = 1:p
        %     for j = 1:p
        %         R_cap_test(i,j) = Rx_sample(i+6-j);
        %     end
        % end
        % 
        % immse(R_cap_test, R_cap_matrix)
        
        %% Encoding Process
        for i = 1:input_size
        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % sample = t(iter);
            % m = [m, sample];
            
            % Linear Predictor Filter in -1 timestep
            m_cap(i) = sum(a.*flip(y_memory));
        
            % Find the current timestep error
            e(i) = m(i) - m_cap(i);
        
            % Get it's quantization level
            % To avoid findind the centers again in each iteration
            if i==1
                [e_q_level(i), centers] = my_quantizer(e(i), N, min_value, max_value);
                centers = centers';
            else
                e_q_level(i) = my_quantizer(e(i), N, min_value, max_value, centers);
            end
            
            % Get the current timestep quantized error
            e_q(i) = centers(e_q_level(i));
        
            % Find the error + approximation value and put it into Predictor's
            % Memory
            y_cap = e_q(i) + m_cap(i);
            y_memory = [y_memory(2:end)', y_cap]';
        end
        
        %% Decoding Process
        for i = 1:input_size
            
            % Linear Predictor Filter in -1 timestep
            m_cap_dec(i) = sum(a.*flip(y_memory_dec));
            
            % Get the output value of the receiver
            y(i) = e_q(i) + m_cap_dec(i);
            
            % Keep a memory of the last p values of the output to use in the
            % Predictor
            y_memory_dec = [y_memory_dec(2:end)',y(i)]';
        end
    
        e_all = [e_all, {e}];
        y_all = [y_all, {y}];
        mseall(N,p-4) = immse(m, m_cap);
        
    end
    all_a = [all_a, {a}];
end




