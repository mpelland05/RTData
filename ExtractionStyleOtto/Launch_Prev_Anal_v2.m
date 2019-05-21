%Data to be loaded:
load('C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\ResultsAgSB\PreProcessed_Data.mat');

PathName = 'C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\Log Files';
SavePath = 'C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\ResultsAgSB';
SaveName = 'PrevCond_Data';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CondAnal = [1 2 3 4 5 6 7 8 9 10 13 14 17 21 18 22];

PreCond{1} = [1 2 9; 5 6 13; 3 4 10; 7 8 14];
PreCond{2} = [1 2 9; 5 6 13; 3 4 10; 7 8 14];
PreCond{3} = [3 4 10; 7 8 14;1 2 9; 5 6 13];
PreCond{4} = [3 4 10; 7 8 14;1 2 9; 5 6 13];

PreCond{5} = [5 6 13; 1 2 9; 7 8 14; 3 4 10];
PreCond{6} = [5 6 13; 1 2 9; 7 8 14; 3 4 10];
PreCond{7} = [7 8 14; 3 4 10; 5 6 13; 1 2 9];
PreCond{8} = [7 8 14; 3 4 10; 5 6 13; 1 2 9];

PreCond{9} = [1 2 9; 5 6 13; 3 4 10; 7 8 14];
PreCond{10} = [3 4 10; 7 8 14;1 2 9; 5 6 13];

PreCond{13} = [5 6 13; 1 2 9; 7 8 14; 3 4 10];
PreCond{14} = [7 8 14; 3 4 10; 5 6 13; 1 2 9];

PreCond{17} = [5 6 13; 1 2 9; 7 8 14; 3 4 10];
PreCond{21} = [5 6 13; 1 2 9; 7 8 14; 3 4 10];

PreCond{18} = [7 8 14; 3 4 10; 5 6 13; 1 2 9];
PreCond{22} = [7 8 14; 3 4 10; 5 6 13; 1 2 9];

Labels = {'AS' 'AD' 'MS' 'MD'};

Averaged_PrevCond = Average_by_PrevCond(NoOutliers,CondAnal,PreCond,Labels);

save([SavePath,'\',SaveName],'Averaged_PrevCond');


%Results to excel file
write2xls(Averaged_PrevCond,[SavePath,'\',SaveName]);