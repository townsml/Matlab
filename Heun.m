function [t,y] = Heun(dydt,tspan,y0,h,es,maxit)
% The purpous of this function is to use the Heun formula to find the
% position of a certain point. There are 6 inputs to the function, 2 of
% which can be omitted.
%
% INPUTS
%   dydt; this is the differential equation, pleas make sure it is in the
%       form of @ (y,t)
%   tspan; this is a vector of the starting and ending points
%           tspan = [startingPoint endingPoint]
%   y0; this is the starting point of the y values
%   h; this is the step size
%   es; maximum error, defaults to .001
%   maxit; maximum iterations, defaults to 50
%
% OUTPUTS
%   t; a matrix of the t values
%   y; a matrix of the y values

%% If statements to ensure that the user inputed the data necessary
if nargin > 6 || nargin < 4
    % if the user inputs too many or too few inputs
    error('Too many or too few inputs, the program needs a minimum of 4 and has a maximum of 6 inputs');
    
elseif nargin == 5
    % if the user does not input maxit, it defaults to 50
    maxit = 50;
    warning('maxit has been defualted to 50')
    
elseif nargin == 4
    % if the user does not input maxit or es, they default to 50 and .001
    % respecevly
    
    maxit = 50;
    es = .001;    
    warning('maxit has been defualted to 50 and the es has defualted to .001')
    
end

%% setting up varables and getting things ready for the calculations

t = tspan(1):h:tspan(2);
% creating an array of t

y = [y0,2:length(t)];
% creating a varable that will hold the y values that are calculated

%% Loops and Calculations

for i = 1:(length(t)-1)
    
    y(i+1) = y(i) + (dydt(t(i),y(i)) * h);
    % Calculating the value of y
    
    Error = es*100;
    % ensuring that the original error peramiters are high for the while
    % loop on line  to work
    
    count = 1;
    % creating a variable that will be used in the while loop
    
    while es <= Error && count <= maxit
        % creating a while loop to calculate the needed y values that are
        % with in the error with in the wanted percentage or with the
        % maximum iterations
        
        slopePrediction = dydt(t(i+1),y(i+1));
        % Predicting the slope at the next point
        
        correction = (dydt(t(i),y(i)) + slopePrediction)/2;
        % Finding the correction needed to get a more accurate guess
        
        newy = y(i) + (correction * h);
        % Finding the more accurate estimate
        
        Error = abs((dydt(t(i+1),newy) - dydt(t(i+1),y(i+1)))/dydt(t(i+1),newy))*100;
        % calculating percent error
        
        y(i+1) = newy;
        % Replacing the old y value with the "more accurate" one
         
        count = count + 1;
        % adding to the count
    end
end

%% Plotting

plot(t,y,'-s');
