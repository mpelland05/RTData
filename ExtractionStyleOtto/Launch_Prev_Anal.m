%Data to be loaded:
load('C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\ResultsAgSB\PreProcessed_Data.mat');

PathName = 'C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\Log Files';
SavePath = 'C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\ResultsAgSB';
SaveName = 'PrevCond_Data';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Averaged_PrevCond = Average_by_PrevCond(NoOutliers);

save([SavePath,'\',SaveName],'Averaged_PrevCond');


%Results to excel file
write2xls(Averaged_PrevCond,[SavePath,'\',SaveName]);