%script force equation, drop height h, number of Gs and mass in kg

x = inputdlg({'Height (m):','Number of Gs:','Mass (kg)'},'Parameters',[1 50; 1 50; 1 50]); 
vars = str2double(x);
H = vars(1);
G = vars(2);
m = vars(3);

[a_ps,b_ps,c_ps,d_ps,a_p,b_p,c_p,d_p] = plotDataPS();

%Normalize the equations to 1 rubber band, 4by6 matrices
parallelMat = [a_p;b_p;c_p;d_p];
parallelSeriesMat = [a_ps;b_ps;c_ps;d_ps];

%Create vector
parallelNormalized = zeros(size(parallelMat));
parallelSeriesNormalized = zeros(size(parallelSeriesMat));

%Preallocate averaged values
aveMatP = zeros(1,size(parallelNormalized,1));
aveMatPS = zeros(1,size(parallelSeriesNormalized,1));

%parallel configuration
for ii=1:size(parallelMat,1)
    for jj=1:size(parallelMat,2)
        parallelNormalized(ii,jj) = parallelMat(ii,jj)/(2*jj); 
    end
    aveMatP(1,ii) = mean(parallelNormalized(ii,:));
    
end

coefficients_fNorm = aveMatP;

for i = 1:20 %series
    for j = 1:20 %parallel
        forceEqPS = 0.65* j * [coefficients_fNorm(1)*(1/(i^3)), coefficients_fNorm(2)*(1/(i^2)), coefficients_fNorm(3)*(1/(i)), coefficients_fNorm(4)];
        [max_disp(i,j), a_error(i,j)] = integrals_rubber_bandPS(forceEqPS, H, G, m);
        
        h = H;
        l0 = 0.055 * i;
        if a_error > 0 
            max_disp(i,j) = 0;
        end
        
        aboveGround = h - l0;
        if (aboveGround < 0)
            max_disp(i,j) = 0;   
        end
        
        notSplat = h - l0 - max_disp(i,j);
        if notSplat < 0
            max_disp(i,j) = 0;
        end

        finalDisp(i,j) = h - l0 - max_disp(i,j);
    end

end

%get the minimum values
minValue = min(finalDisp(:));
[series,parallel] = find(finalDisp == minValue);

            





