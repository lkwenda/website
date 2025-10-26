function [max_disp, a_error] = integrals_rubber_bandPS(forceEq,h,accel,m)
sf = 1;
g = 9.81;
E = m*g*h*sf; % Just an example value

fun = @(x) forceEq(4) + forceEq(3)*x +  forceEq(2)*x.^2 + forceEq(1)*x.^3;
sval = fzero(@(s)integral(fun,0,s)-E,1);
max_disp = (sval);

%Calculate force at this displacement
X = max_disp;
solveForce = forceEq(4) + forceEq(3)*X + forceEq(2)*X^2 + forceEq(1)*X^3;

%recalculate the integral.
intForce = integral(fun,0,max_disp);

%Check the error in the two forces
CheckForce = intForce-solveForce;

%Calculate force caused by gravity
accel_force = (accel*g*m + m*g);

fun2 = @(x) forceEq(4) + forceEq(3)*x + x.^2 *forceEq(2) + x.^3*forceEq(1) - accel_force;
%a_error2 = solveForce - accel_force;
accel_disp = fzero(fun2,0); %BREAKPOINT HERE TO SEE FORCES

if max_disp < 0
    max_disp = 0;
end
a_error = max_disp - abs(accel_disp);

%if a_error is negative, then we are good we are within max acceleration
 
end


