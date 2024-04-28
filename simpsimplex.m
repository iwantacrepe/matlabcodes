clc;
clear all;

% Define matrix A, vector b, and cost vector C
A = [1 4 8 6 1 0 0; 
     4 1 2 1 0 1 0;
     2 3 1 2 0 0 1];
b = [11; 7; 2];
C = [4 6 3 1 0 0 0];

% Initialize basic variable indices
Bi = [5 6 7];
Cb = C(Bi);
B = A(:, Bi);

% Calculate the initial solution
alpha = B\A;
Sol = B\b;
Z = Cb*alpha - C;

% Find the entering variable
[e_val, e_ind] = min(Z);

% Initialization for leaving variable calculation
m = size(A,1);
l = inf(1, m);  % Use inf to handle cases with no valid pivot

% Calculate the ratio for the minimum ratio test (pivot operation)
for i = 1:m 
    if alpha(i, e_ind) > 0
        l(i) = Sol(i) / alpha(i, e_ind);
    end
end

% Determine the leaving variable
[l_val, l_ind] = min(l);
Bi(l_ind) = e_ind;

% Simplex loop to find the optimal solution
while e_val < 0
    col = alpha(:, e_ind);
    [m, n] = size(col);
    ratio = inf(1, m);  % Initialize ratios with infinity

    % Compute ratios for the leaving variable
    for i = 1:m 
        if col(i, 1) > 0
            ratio(i) = Sol(i, 1) / col(i, 1);
        end
    end

    [l_val, l_ind] = min(ratio);
    Bi(l_ind) = e_ind;
    Cb = C(Bi);
    B = A(:, Bi);
    alpha = B\A;
    Sol = B\b;
    Z = Cb*alpha - C;
    
    % Check for optimality
    [e_val, e_ind] = min(Z);
end

% Printing optimal solution and other details
solution = Cb * Sol;
disp('Optimal Solution:');
disp(solution);
disp('Final Basic Variables Indices:');
disp(Bi);
disp('Final Tableau:');
disp(alpha);
