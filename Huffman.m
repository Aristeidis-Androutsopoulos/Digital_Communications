%% Call the Import Handler for all data preprocessing
import_handler;

%% A-1: Original Photo 
%Make the Huffman dictionary
[dict, avglength] = huffmandict(photo_symbols, photo_prob);

%% Encode the vectorized image
encoded_image_vector = huffmanenco(image_vector, dict);

%% Decode the vectorized image
decoded_image_vector = huffmandeco(encoded_image_vector, dict);

% Reshape the vector to a matrix
decoded_image = reshape(decoded_image_vector, size(image));

figure, imshow(decoded_image,[]);

%% Metrics for Huffman

[entropy, efficiency] = entropy_efficiency(photo_prob, avglength);

% Entropy
disp("Entropy");
disp(entropy);

% Average Length
disp("Average Length");
disp(avglength);

% Efficiency
disp("Efficiency");
disp(efficiency);



%% A-2: Block Coding in paired symbols 
% Make the Huffman dictionary
[dict, avglength] = huffmandict(bigrams_symbols, bigrams_prob);

%% Encode the vectorized image
encoded_image_vector = huffmanenco(bigrams, dict);

%% Decode the vectorized image
decoded_image_vector = huffmandeco(encoded_image_vector, dict);

% % Reshape the vector to a matrix
% decoded_image = reshape(decoded_image_vector, size(image));
% 
% figure, imshow(decoded_image,[]);

%% Metrics for Huffman

[entropy, efficiency] = entropy_efficiency(bigrams_prob, avglength);

% Entropy
disp("Entropy");
disp(entropy);

% Average Length
disp("Average Length");
disp(avglength);

% Efficiency
disp("Efficiency");
disp(efficiency);
