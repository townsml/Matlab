function [I] = Simpson(x,y)
% This function integrates data using Simpson's 1/3 rule. It checks if
% there is an odd number of intervals and will use the trapezoidal rule for
% either the first or last interval, which ever is likely to produce the
% least amount of error.
% Inputs
%   x = the x values of the data that will be integrated
%   y = the y values of the data that will be integrated
% Outputs
%   I = the value of the intregral

%% Making sure that the intervals are equally spaced and that there is the same length on x y
[rowsX,lengthOfX] = size(x);
rowsY = size(y);
% Creating a varable to hold the length of x
diffX = diff(x); spaceingX = diffX(1,1);
% finding the spacing of x

if lengthOfX ~= length(y)
    error('The inputs are not the same length')
    %ensuring that the user input to vectors of the same length
    
elseif lengthOfX == 1 ||lengthOfX == 0
    error('Not enough inputs in the x to preform calculation')
    %making sure that there are enough points to preform a calculation
    
elseif rowsX ~=1 || rowsY ~=1
    error('Must use vectors, the program will not run with matrices')
    %making sure that the user imputed vectors
    
elseif lengthOfX == 2
    I = .5*(spaceingX)*(y(1)+y(2));
    disp(I)
    error('Not enough points to use Simmons method, defaulted to trapazoidal rule')
    %making sure that there are at least 3 points to use
    
elseif spaceingX ~= diffX(1,2:length(diffX))
    error('The x that was inputed was not evenly spaced, cannot compute')
    %ensuring that x is evenly spaced
    
elseif floor(lengthOfX/2)*2 == lengthOfX
    %tring to figure out if x has a even number of values, the logic is
    %that there is no way to get an odd number by multipling a counting
    %number by 2, so if there is a point 5, it will get rounded down and
    %then when multiplied by 2, it will not equal itself due to the
    %rounding
    
    endCheck = abs(y(lengthOfX)-y(lengthOfX));
    frontCheck = abs(y(1)-y(2));
    %these values will be used to guess the better area to use the
    %trapazoidal rule
    
    if endCheck > frontCheck
        % this means that there is more likely to be weird stuff near the
        % end of the data set
        warning('will use the trapazoidal rule on the first intercal')
        trapazoidExtra = .5*(spaceingX)*(y(1)+y(2));
        
        I = trapazoidExtra;
        factor = (x(lengthOfX)-x(1))/3;
        %intializing I and factor, the common factor that will have to be used on
        %every loop iteration
        
        for i = 3:(lengthOfX-1)
            I = I+(factor*(y(i-1)+4*y(i)+y(i+1)));
        end
        
    else
        warning('will use the trapazoidal rule on the last interval')
        % defaulting to the last interval incase the segments equal each
        % other or what not
        trapazoidExtra = .5*(spaceingX)*(y(lengthOfX)+y(lengthOfX-1));
        
        I = trapazoidExtra;
        factor = (x(lengthOfX)-x(1))/3;
        %intializing I and factor, the common factor that will have to be used on
        %every loop iteration
        
        for i = 2:(lengthOfX-2)
            I = I+(factor*(y(i-1)+4*y(i)+y(i+1)));
        end
    end
else
    I = 0;
    factor = (x(lengthOfX)-x(1))/3;
    for i = 2:(lengthOfX-1)
        I = I+(factor*(y(i-1)+4*y(i)+y(i+1)));
    end

end   