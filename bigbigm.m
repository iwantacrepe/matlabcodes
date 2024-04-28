clc;
clear all;

% Big M Constants
MA = 1e5; % A large number representing a very high cost for artificial variables

% Input Data
A = [1 3 -1 0 1 0;  % Constraint coefficients
     1 1  0 -1 0 1];
b = [3; 2];         % Right-hand side of constraints
C = [-3 -5 0 0 -MA -MA];  % Objective function coefficients with high costs for artificial variables

% Identifying Initial Basic Variables
Bi = [5 6];  % Indexes of the basic variables (artificial variables)
B = A(:, Bi);  % The matrix of basic columns
Cb = C(Bi);   % The cost coefficients for basic variables

% Finding Initial Solution
alpha = B \ A;  % Body matrix (tableau)
sol = B \ b;    % Solution vector
Z = (Cb * alpha) - C;  % Zj - Cj values for the non-basic variables
[val, ent] = min(Z);  % Find the entering variable (min Zj - Cj)

% Find the leaving variable (minimum ratio test)
m = size(A, 1);  % Number of constraints
l = zeros(1, m);

for i = 1:m
    if alpha(i, ent) > 0
        l(i) = sol(i) / alpha(i, ent);  % Calculate ratios for the pivot test
    end
end

[v, lve] = min(l);  % Determine the leaving variable
Bi(lve) = ent;      % Update basic variables with the entering variable

% Simplex Iteration
while val < 0
    int_col = alpha(:, ent);  % Get the entering variable column
    [m, n] = size(int_col);
    
    ratio = inf(1, m);  % Initialize the ratio array with infinity
    for i = 1:m
        if int_col(i, 1) > 0
            ratio(i) = sol(i, 1) / int_col(i, 1);  % Calculate ratios for pivoting
        end
    end
    
    [l_ele, l_ind] = min(ratio);  % Find the minimum ratio
    Bi(l_ind) = ent;              % Update basic variables
    B = A(:, Bi);                 % Update the basic matrix
    Cb = C(Bi);                   % Update basic variable costs
    alpha = B \ A;                % Recalculate the tableau
    sol = B \ b;                  % Recalculate the solution vector
    Z = (Cb * alpha) - C;         % Recalculate Zj - Cj
    
    [val, ent] = min(Z);  % Find the new entering variable
end

% Final Solution and Optimal Value
opt_value = -Cb * sol;  % Calculate the optimal value of the objective function
disp('Optimal Solution:');
disp(opt_value);       % Display optimal value
disp('Basic Variables:');
disp(Bi);              % Display indices of basic variables
disp('Final Table:');
disp(alpha);           % Display final Simplex tableau
