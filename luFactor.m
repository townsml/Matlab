function [L,U,P,InvA] = luFactor(H)
%This fuction determines the LU Factorization of a square matrix, athough
%it will work with over constrained maticies.
%
% INPUTS
%   A - The coefficient matrix
%   B - The driving matrix, optional
%
% OUTPUTS
%   L - The lower triangular matrix
%   U - The upper triangular matrix
%   P - The pivot matrix
%   InvA - The inverse matrix of A, oprional

%-------------------------------------------------------------------------
%Starting by ensuring that A is a square matrix or making it so if possible

[CheckRow, CheckCol] = size(H);% old code CheckRow = length(CheckRowVec);
%this is to hold the # of rows A has
%CheckColVec = A(1,:); CheckCol = length(CheckColVec);
%this is to hold the # of columns A has

%CheckRow is # of Rows, CheckCol is # of Columns

if CheckRow > CheckCol
    disp('Matrix is over constrained, dropping last equation(s)')
    H = H(1:(CheckRow-(CheckRow-CheckCol)),:);
elseif CheckRow < CheckCol
    error ('Matrix is unacceptable; too many columns')
end

%Creating an identity matrix of the coefficient matrix so that
%creating the pivot matrix will be much easier

[CheckRow,~] = size(H);

P = eye(CheckRow);

%Creating an identity matrix that will be the baisis of the L matrix
L = eye(CheckRow);

U = H;
%creating a U matrix

%Pivoting
% writing a for loop to find the pivot matrix

% note to Programmer, max(A(2:m,2:n)) is how to remove colums and rows

for i = 1:(CheckRow-1)
    % to find max of each colum depending on i
    [~,rowNum] = max(abs(U(i:CheckRow,i)));
    %each the maxValue will hold the max value for the column of i and the
    %rowNum will tell which row the number is rowNum
    pivotVector = U(i,:);
    U(i,:) = U((rowNum+i-1),:); U((rowNum+i-1),:) = pivotVector;
    %poviting row one and the row with max value
    pivotVector = P(i,:);
    P(i,:) = P((rowNum+i-1),:); P((rowNum+i-1),:) = pivotVector;
    %creating the pivot metrix
    if i>1
        %pivoting the L matrix
        pivotVector = L(i,1:(i-1));
        L(i,1:(i-1)) = L((rowNum+i-1),1:(i-1)); L((rowNum+i-1),1:(i-1)) = pivotVector;
    end
    
    for int = (i+1) : CheckRow
        % to find the Guassian elimination the matrix A and parts of U
        L(int,i) = U(int,i)/U(i,i);
        %finding the neccisary ratio and storing the value
        U(int,:) = U(int,:)-(L(int,i)*U(i,:));
    end
end
% if (P*A)~= (L*U)
%     error('you screwed up dude')
%     %this error message if for the programmer only

%finding inverse function of the pivoted matrix

    
InvA = zeros(CheckRow);

for numb = 1 :(CheckRow)
    b = zeros(CheckRow);
    b(numb,1) = 1;
    d = b(:,1);
    b = d;
    for num = 1:(CheckRow)
        if num == 1            
            d(num,1) = b(num,1)/L(num,num);
        else
            d(num,1) = b(num)-(L(num,1:(num-1))*d(1:num-1,1));
        end
    end
    for iterat = 1:CheckRow
        H=CheckRow-iterat;
        %if interat == 1
            InvA((H+1),numb) = (d((H+1),1)-(U(H+1,H+2:CheckRow)*...
                InvA(H+2:CheckRow,numb)))/...
                U(H+1,H+1);
        %else
%             InvA((CheckRow+1-iterat),numb) = d((CheckRow+1-iterat),1)/...
%                 U(CheckRow+1-interat,CheckRow+1-interat);
    end
end
end
