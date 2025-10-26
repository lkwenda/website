%This function reads data from txt file and outputs extension vs force
function [force, elongation]=getData(filename)
MTS_data = readtable(filename);  

%get force array
force = table2array(MTS_data(:,1));

%get extention array
elongation = table2array(MTS_data(:,3));

end