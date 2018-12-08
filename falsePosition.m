function[root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
% This function will calculate the roots of a function using the false position
% method. The user must imput the function, the lower bound, upper bound,
% the desired error (defaulted to .0001%) and the max number of iterations,
% (defaults to 200 iterations).
%
%Inputs
%   func - the function being evaluated
%   xl - the lower guess
%   xu - the upper bound
%   es - the desired relative error (.0001% default)
%   maxiter - the number of desired iterations (200 default)
%Outputs
%   root - the estimated root location
%   fx - the function evaluated at the root location
%   ea - the approximate relative error (%)
%   iter -  the number of iterations

if nargin < 3 || nargin > 5
    error ('invalid amount of inputs, must be 3-5 inputs')
elseif nargin == 3
    es = .0001;
    maxiter = 200;
elseif nargin == 4
    maxiter = 200;
end
% this if statement finds how many inputs are given to the function and
% finds out if there are too few or many, and sets the defaults

%% ------------------------------------------------------------------------
% prep before the while loop
if func(xl)*func(xu) > 0
    error ('xl and xu are unacceptable, program cannot run, try again')
elseif func(xl)*func(xu) == 0
    error ('xl or xu are roots')
end
% this if statement ensures that the imputed for values for xl and xu
% bracket the root

iter = 0;
% Starting the iteration count
calculatedError = es*2;
% creating variable for current error
oldGuess = 0; newGuess = 0;
% creating a variables to help with the error calculation

%% ------------------------------------------------------------------------

% creating while loop

while iter < maxiter
    iter = iter +1; % counting iterations
    newGuess = xu-((func(xu)*(xl-xu))/(func(xl)-func(xu)));
    % this is the equation for finding the answer that was given in the
    % book, the answer is put into newGuess
    if func(newGuess)*func(xl)>0
        xl = newGuess;
    elseif func(newGuess)*func(xu)>0
        xu = newGuess;
    else
        break
    end
    
    if iter > 1
        calculatedError = (newGuess-oldGuess)/newGuess *100;
    end      
    oldGuess = newGuess;
        
    if es >= calculatedError
        break
    end
end
root = newGuess;
fx = func(root);
ea = calculatedError;
