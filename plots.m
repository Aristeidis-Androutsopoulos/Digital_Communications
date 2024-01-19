%% 2
figure;
plot(m, 'DisplayName', 'Input Signal 3');
hold on;
plot(e_all{6}, 'DisplayName', 'Prediction Error y');
hold on;


title('p=10, N=3');

% Add a legend
legend('show');

% Add grid
grid on;


%% 3a
hm = 1:6;
figure;
plot(mseall(1,:), 'DisplayName', 'N = 1');
hold on;
plot(mseall(2,:), 'DisplayName', 'N = 2');
hold on;
plot(mseall(3,:), 'DisplayName', 'N = 3');


% set(gca,"X",0:6)
xticks(1:6);

xticklabels({'5','6','7','8','9','10'})

xlabel('Size of Previous Values stored in Memory - p');
ylabel('MSE');
title('MSE for different values of N');

% Add a legend
legend('show');

% Add grid
grid on;

%% 3b

figure;
plot(mseall, 'DisplayName', 'N = 3');


% set(gca,"X",0:6)
xlabel('Number of bits - N');
ylabel('MSE');
title('MSE for different values of P');

% Add a legend
legend('p = 5', 'p = 6', 'p = 7','p = 8' ,'p = 9', 'p = 10');

% Add grid
grid on;




mse(2,10-4) = immse(m, m_cap)

%% 4

figure;
plot(m, 'DisplayName', 'x');
hold on;
plot(y_all{6}, 'DisplayName', 'y decoder');
hold on;

title('N=3, p=10 - Initial and Reconstructed Signal');

% Add a legend
legend('show');

% Add grid
grid on;
