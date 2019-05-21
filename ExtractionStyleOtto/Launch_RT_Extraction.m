%This script will start a series of function which will start by extracting
%the data from the .log file up to removing outliers. The results are
%stored in the specified file. If you want more information on each
%process, open the relevant functions
%
%The user simply needs to fil in the input section. The later must contain:
%
%nParticipants      which stands for the number of participants.
%
%nBlocks            The number of blocks each participants underwent.
%                   If the number is not equal among participants, the
%                   script won't work.
%
%ParticipantsName   Well, not really the name, only the part that specifies
%                   the identity of the participants on the log's name. In
%                   this case, participants log files are writtent as
%                   follow: S01_1.log (participant 1, block 1). S01_2.log
%                   for participant 1 block 2. 
%
%BlocksName         ...
%
%PathName           The folder in which your store your log files. They should all be in the same folder
%
%SavePath           The folder in which to save your results
%
%SaveName           Name of the file in which your data will be saved
%
%Event2Num.Event    Name of all the events of interest.
%
%Event2Num.Num      Numerical codes which will be assigned to different
%                   conditions
%
%MinRT              Minimum reaction time which is deemed acceptable
%
%MaxRT              Maximum reaction time which is deemed acceptable
%
%NumSTD             Number of standard deviation defining outliers
%
%OutByParticipants  Way of removing outliers, it can be done by
%                   participants (all blocks together) or for every block.
%                   Note that conditions are never mixed
%
%Input example:
%
%nParticipants = 16;
%nBlocks = 6;
%ParticipantsName = {'S01' 'S02' 'S03' 'S04' 'S05' 'S06' 'S07' 'S08' 'S09' 'S10' 'S11' 'S12' 'S13' 'S14' 'S15' 'S16'};
%BlocksName = {'1' '2' '3' '4' '5' '6'};
%PathName = 'C:\Users\Maxime Pelland\Desktop\Maxime\Maxime\Log Files';
%SavePath = 'C:\Users\Maxime Pelland\Desktop\Maxime\Maxime\Results';
%SaveName = 'PreProcessed_Data';
%Event2Num.Event = {'T1' 'T2' 'T3' 'T4' 'V1' 'V2' 'V3' 'V4' 'T12' 'T34' 'T13' 'T24' 'V12' 'V34' 'V13' 'V24' 'V1T2' 'V3T4' 'V1T3' 'V2T4' 'V2T1' 'V4T3' 'V3T1' 'V4T2' 'CatchTrial'};    
%Event2Num.Num = [1:length(Event2Num.Event)];
%MinRT = 100;           %Min RT not considered an outlier
%MaxRT = 1000;          %Max RT not considered an outlier
%NumSTD = 3;            %Number of standard deviations where we consider that the data is an outlier. 
%OutByParticipants = 1; %Calculates Standard deviations and outliers based
%                       %on all trials from a condition
%
%
%IMPORTANT NOTES
%Note that the code for response is '2' and '3'; If this is not the case in your
%experiment, modify the function Modify2Matrices where the green arrow is.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%

nParticipants = 1;
nBlocks = 1;
%ParticipantsName = {'S01' 'S02' 'S03' 'S04' 'S05' 'S06' 'S07' 'S08' 'S09' 'S10' 'S11' 'S12' 'S13' 'S14' 'S15' 'S16'};
%ParticipantsName = {'S01' 'S02' 'S03' 'S04' 'S05'};
%ParticipantsName = {'A01' 'A02' 'A03' 'A04'};
ParticipantsName = {'S01'};
%BlocksName = {'1' '2' '3' '4' '5' '6'};
%BlocksName = {'1' '2' '3' '4' '5'};
BlocksName = {'1'};

PathName = 'C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\GenData';
SavePath = 'C:\Users\Maxime Pelland\Desktop\RTData\Maxime\Maxime\GenData\Results';
SaveName = 'PreProcessed_Data';

%Event2Num.Event = {'T1' 'T2' 'T3' 'T4' 'V1' 'V2' 'V3' 'V4' ...
%    'T12' 'T34' 'T13' 'T24' 'V12' 'V34' 'V13' 'V24' ...
%    'V1T2' 'V3T4' 'V1T3' 'V2T4' 'V2T1' 'V4T3' 'V3T1' 'V4T2' 'CatchTrial'}; 

Event2Num.Event = {'V1' 'V2' 'V3' 'V4' 'T1' 'T2' 'T3' 'T4' ...
    'V12' 'V34' 'V1primeV4prime' 'V2primeV3prime' 'T12' 'T34' 'T14' 'T23'...
    'V2T1' 'V1T2' 'V3T4' 'V4T3' 'V1primeT4' 'V4primeT1' 'V3primeT2' 'V2primeT3'...
    'CatchTrial'}; 
    
Event2Num.Num = [1:length(Event2Num.Event)];

MinRT = 100;%Min RT not considered an outlier
MaxRT = 1000; %Max RT not considered an outlier
NumSTD = 3; %Number of standard deviations where we consider that the data is an outlier. 

OutByParticipants = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Legend = Event2Num.Event;

%Launches first function to extract data from the Presentation Log
display('Step 1, extraction: Start')
Original = Extract_Presentation(nParticipants,nBlocks, ParticipantsName, BlocksName, PathName);
display('Step 1, extraction: Done')

%Launches the second function to modify the extracted data into matrices.
%The data is rearranged to simplify its analysis. 
display('Step2, modify to matrices: Start')
Modified = Modify2Matrices(nParticipants,nBlocks,Original,Event2Num,Legend);
display('Step2, modify to matrices: Done')

%Launches the third function which will separate the different conditions
%into different matrices
display('Step3, Separate Conditions: Start')
Separated = SeparateConditions(nParticipants,nBlocks,Modified,Event2Num);
display('Step3, Separate Conditions: Done')

%Launches the fourth function which will remove Reaction times that are
%anormal (too fast or too short)
display('Step3, Separate Conditions: Start')
NoOutliers = RemoveOutliers(nParticipants,nBlocks,Separated,Event2Num,MinRT,MaxRT,NumSTD,OutByParticipants);
display('Step3, Separate Conditions: Done')

%Saves the resulting structure
mkdir(SavePath);
save([SavePath,'\',SaveName],'NoOutliers');

%Launches a fourth function which will find how many trials lacked a
%response and how many 

display('Step4, Computing misses and removed outliers: Start')
MissAndOutliers = CalculateMissAndOutliers(nParticipants,nBlocks,NoOutliers,Separated);
display('Step4, Computing misses and removed outliers: Done')

save([SavePath,'\',SaveName,'Misses_and_Outliers'],'MissAndOutliers');