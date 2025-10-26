%This script plots all the MTS data onto one plot
function [a_ps,b_ps,c_ps,d_ps,a_p,b_p,c_p,d_p]=plotDataPS()

rBandnum = 2:2:12;


for ii = 1:length(rBandnum)
    myNum = num2str(rBandnum(ii));
    myNum = convertStringsToChars(myNum);
    ext_ps = 'P2S.txt';
    filename = strcat(myNum,ext_ps);
    [force_ps, elongation_ps]=getData(filename);
    elongation_ps= elongation_ps/1000;

    coefficients_ps = polyfit(elongation_ps,force_ps,3);
    
    %get coefficients of polynomial fit for parallel series configuration
    a_ps(ii) = coefficients_ps(1);
    b_ps(ii) = coefficients_ps(2);
    c_ps(ii) = coefficients_ps(3);
    d_ps(ii) = coefficients_ps(4);

    xFit_ps = linspace(min(elongation_ps),max(elongation_ps),1000);
    yFit_ps = polyval(coefficients_ps,xFit_ps);





    [R,P] = corrcoef(elongation_ps,force_ps);

   R_squared = string((R(2,1))^2)



    equation_ps(ii) = append("F = ",string(a_ps(ii)),"x^3 + ",string(b_ps(ii)),"x^2 + ",string(c_ps(ii)),"x + ",string(d_ps(ii)));

   %Do the same for parallel only configuration
     ext_p = 'P.txt';
    filename_p = strcat(myNum,ext_p);
    [force_p, elongation_p]=getData(filename_p);
    elongation_p= elongation_p/1000;

    coefficients_p = polyfit(elongation_p,force_p,3);

    a_p(ii) = coefficients_p(1);
    b_p(ii) = coefficients_p(2);
    c_p(ii) = coefficients_p(3);
    d_p(ii) = coefficients_p(4);

    xFit_p = linspace(min(elongation_p),max(elongation_p),1000);
    yFit_p = polyval(coefficients_p,xFit_p);

    equation_p(ii) = append("F = ",string(a_p(ii)),"x^3 + ",string(b_p(ii)),"x^2 + ",string(c_p(ii)),"x + ",string(d_p(ii)));

    [R1,P] = corrcoef(elongation_p,force_p);

   R_squared1 = string((R1(2,1))^2)


end
end








