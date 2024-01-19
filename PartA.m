%% Call the Huffman code file
Huffman;

%% A-4: Get the Compression Ratio with the binary representation

% Get the Binary Representation
bI = reshape((dec2bin(typecast(image(:),'uint8'),4)-'0').',1,[]);

% Get the Ratio
J = numel(encoded_image_vector)/numel(bI);

%% A-5: Binary Symmetric Channel

% Send data through the channel
received_data = binary_symmetric_channel(encoded_image_vector);

% Count the number of bit errors that occured
num_errors = sum(encoded_image_vector ~= received_data);

% Get the Crossover Probability for error with precision of 2
crossover_prob_error = num_errors/numel(encoded_image_vector);
% crossover_prob_error = fix(crossover_prob_error * 10^2)/10^2;

% Get the Crossover Probability for success with precision of 2
crossover_prob_success = 1 - crossover_prob_error;

% Get the Channel Capacity
channel_capacity = 1 + crossover_prob_error * log2(crossover_prob_error) + (crossover_prob_success) * log2(crossover_prob_success);

% Get the apriori probabilities for the input Vector
x_prob_0 = sum(encoded_image_vector == 0) / numel(encoded_image_vector);
x_prob_1 = 1 - x_prob_0;

% Get the probabilities of the output Vector
y_prob_0 = sum(received_data == 0) / numel(received_data);
y_prob_1 = 1 - y_prob_0;

%% Simplified Addition for Mutual Information

% Get the two parts of the simplified addition (Check report for proof)
part_1 = crossover_prob_error * (x_prob_0 * (log2(crossover_prob_error)-log2(y_prob_1)) + x_prob_1 * (log2(crossover_prob_error)-log2(y_prob_0)));
part_2 = crossover_prob_success * (x_prob_0 * (log2(crossover_prob_success)-log2(y_prob_0)) + x_prob_1 * (log2(crossover_prob_success)-log2(y_prob_1)));

% Get the Mutual Information of the Channel
channel_mutual_info = part_1 + part_2;



%% Another way based on Wikipedia Page
p = x_prob_0;

% Define the crossover probability of the BSC
p_c = crossover_prob_error;

% 
Hb = p*log2(1/p)+(1-p)*log2(1/(1-p));

% Calculate the entropy of the output
H_Y = -p_c * log2(p_c) - (1 - p_c) * log2(1 - p_c);

% Calculate the mutual information
I_XY = -(H_Y - Hb);


