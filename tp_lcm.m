clc
clear all
Cost=[11 13 17 14; 16 18 14 10; 21 24 13 10]
A=[250 300 400];
B=[200 225 275 250];
if sum(A) == sum(B)
    fprintf('Given transportation problem is balanced')
else
    fprintf('Given transportation problem is unbalanced')
    if sum(A) < sum(B)
        Cost(end+1, :) = zeros(1, size(B,2));
        A(end+1) = sum(B) - sum(A);
    elseif sum(B) < sum(A)
        Cost(:, end+1) = zeros(1, size(A, 2));
        B(end+1) = sum(A) - sum(B);
    end
end

Icost = Cost;
X = zeros(size(Cost));
[m, n] = size(Cost);
BFS = m + n - 1;

for i=1:m
    for j=1:n
        cs = min(Cost(:));
        [RowIndex, ColIndex] = find(cs == Cost);
        x11 = min(A(RowIndex), B(ColIndex));
        [value, Index] = max(x11);
        ii = RowIndex(Index);
        jj = ColIndex(Index);
        y11 = min(A(ii), B(jj));
        X(ii, jj) = y11;
        A(ii) = A(ii) - y11;
        B(jj) = B(jj) - y11;
        Cost(ii, jj) = Inf;
    end
end

fprintf('Initial BFS\n');
IBFS = array2table(X);
disp(IBFS);
TotalBFS = length(nonzeros(X));
if TotalBFS == BFS
    fprintf('Initial BFS is non degenerate\n')
else
    fprintf('Initial BFS is degenerate\n')
end

InitialCost = sum(sum(Icost .* X)) 
