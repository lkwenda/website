

a = 322.7883;
b = -153.8337;
c = 38.8496;
d = 0.2610;

x = (0:600)/2000;
set(gcf,'Color','White')
colors = ["r-","g-","m-","c-","y-","b-"];
colors1 = ["r.","g.","m.","c.","y.","b."];
pp=1;
for np = 2:2:12

    Fnorm = 0.65*np*(a*x.^3 + b*x.^2 + c*x + d);
    myNum =  num2str(np);
    ext_p = "P2S.txt";
    filename_p = strcat(myNum,ext_p);
    [force_p, elongation_p]=getData(filename_p);
    elongation_p= elongation_p/1000;
    plot(elongation_p,force_p,convertStringsToChars(colors1(pp)),'DisplayName',strcat(string(np),"2P2S MTS Data"))
    hold on
    plot(x,Fnorm,convertStringsToChars(colors(pp)),"LineWidth",2,'DisplayName',strcat(string(np),"2P2S Fit"))
    hold on
    pp = pp+1;
end
lgd = legend;
lgd.NumColumns =2;
lgd.Location = 'northwest';
xlim([0 0.3])
ylim([0 50])
title('Parallel and Series F-d Curves')
xlabel('Displacement (m)')
ylabel('Force (N)')


