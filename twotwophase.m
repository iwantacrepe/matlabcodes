clc;
clear all;

% Constants for Big M Method
M = 10000;

% Initialize Matrix A, b and Cost C
A = [1 3 -1 0 1 0;
     1 1  0 -1 0 1];  % Coefficients including slack and artificial variables
b = [3; 2];          % RHS of constraints
C = [-3 -5 0 0 -M -M];  % Objective function coefficients with penalties on artificial variables

% Basic variable indices (artificial variables initially)
Bi = [5 6];
Bi2 = Bi;  % Keep original basic indices for comparison in phase 2

% Compute initial BFS using the artificial variables
B = A(:, Bi);
Cb = C(Bi);
alpha = B \ A;
sol = B \ b;
z = Cb * alpha - C;

% Phase 1: Minimize the artificial variables
[ev, ei] = min(z);
while min(z) < 0
    column = alpha(:, ei);
    m = size(column, 1);
    ratio = inf(1, m);  % Initialize ratio array with infinity
    for i = 1:m
        if column(i) > 0
            ratio(i) = sol(i) / column(i);
        end
    end
    [lv, li] = min(ratio);
    Bi(li) = ei;
    B = A(:, Bi);
    Cb = C(Bi);
    alpha = B \ A;
    sol = B \ b;
    z = Cb * alpha - C;
    [ev, ei] = min(z);
end

% Check if artificial variables are still in the basis
flag = 0;
for i = 1:2
    for j = 1:2
        if Bi2(i) == Bi(j)
            flag = 1;  % Artificial variables found in the basis
            break;
        end
    end
    if flag == 1
        break;
    end
end

% Phase 2: Optimize original objective if no artificial variables in basis
if flag == 0
    alpha = alpha(:, 1:4);  % Remove columns related to artificial variables
    A = [1 3 1 0; 1 1 0 1];  % Original constraint matrix without artificial variables
    C = [-3 -5 0 0];         % Original cost without artificial variables
    
    % Re-run Simplex with original constraints and objective
    B = A(:, Bi);
    Cb = C(Bi);
    z = Cb * alpha - C;
    [ev, ei] = min(z);
    while min(z) < 0
        column = alpha(:, ei);
        m = size(column, 1);
        ratio = inf(1, m);
        for i = 1:m
            if column(i) > 0
                ratio(i) = sol(i) / column(i);
            end
        end
        [lv, li] = min(ratio);
        Bi(li) = ei;
        B = A(:, Bi);
        Cb = C(Bi);
        alpha = B \ A;
        sol = B \ b;
        z = Cb * alpha - C;
        [ev, ei] = min(z);
    end
    fprintf('Optimal Solution: %f\n', -Cb * sol);  % Display optimal value
end
