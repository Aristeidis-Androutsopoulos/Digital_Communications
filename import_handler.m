%% Original Image

% Import the image
image = imread("parrot.png");

% whos image

% Display the image
% figure, imshow(image,[]);


%% Create the alphabet including the probabilities vector and the symbols vector

% Vectorize the image
image_vector = image(:);

% Get the Frequency Table (value, # of appearance, percentage)
photo_alphabet = tabulate(image_vector);

% Get the unique symbols vector
photo_symbols = photo_alphabet(:, 1);

% Get the Probabilities for each symbol
photo_prob = photo_alphabet(:, 3)/100;

% Plot the Probability Distribution
% figure, bar(photo_symbols, photo_prob);
% title('Pixel Value Probability Distribution');
% xlabel('Pixel Value');
% ylabel('Probability');

% Plot the Histogram of the Image
% figure, histogram(image)

%% 2nd Order Block Coding


% Extract bigrams from the image Horizontally and Vertically
bigramsVertical = im2col(image, [2, 1]);

bigramsHorizontal = im2col(image, [1, 2]);
% bigramsDiagonal = im2col(image, [2, 2]);

% Make digrams to strings to concatanate
bigramsVertical = num2str(bigramsVertical', '%d');
bigramsHorizontal = num2str(bigramsHorizontal', '%d');
bigrams = [bigramsVertical; bigramsHorizontal];



% Make digrams to cells to remove all whitespaces
bigrams_cells = cellstr(bigrams);
bigrams = cellfun(@(str) strrep(str, ' ', ''), bigrams_cells, 'UniformOutput', false);

% Get the Frequency Table (value, # of appearance, percentage)
bigrams_alphabet = tabulate(bigrams);

% Get the unique symbols vector
bigrams_symbols = bigrams_alphabet(:, 1);

% Get the Probabilities for each symbol
bigrams_prob = zeros(size(bigrams_alphabet(:,3)));

for n = 1:size(bigrams_alphabet(:,3))
    bigrams_prob(n) = bigrams_alphabet{n, 3}/100;
end


%% If full bigram alphabet is needed

% Get all the Combinations plus their reverse: 16 values so 16^2=256 values
n = 2;
ix = fullfact(ones(1,n)*numel(photo_symbols));
bigrams_symbols_full = photo_symbols(ix(all(sort(ix,2),2),:));

% get the concatenated values of ALL the symbol combinations from the
% original alphabet
bigrams_symbols_full = num2str(bigrams_symbols_full, '%d');
bigrams_symbols_full = cellstr(bigrams_symbols_full);
bigrams_symbols_full = cellfun(@(str) strrep(str, ' ', ''), bigrams_symbols_full, 'UniformOutput', false);

figure, bar(bigrams_symbols, bigrams_prob);
title('Pixel Value Probability Distribution');
xlabel('Pixel Value');
ylabel('Probability');


