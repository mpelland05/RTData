%LaunchAnalysis 

TrialsToBeAnalyzed = 1:24;%Enter a list of the codes for the trial types that will be analyzed. This is to avoid the analysis of catch trials. [1 2 3 ...]
nQuantiles = 42; %Insert the minimum obtained by CountQuantiles - nBlocks, that way, you make sure that each trials a preceded by another one

CountTheQuantiles = 0; %if you want the script to count the maximum number of quantiles for the analysis. This only needs to be done once. 
Blocks = 0; %Select whether each block will count as a participant (1) or not (0);
%PreviousPropor = 1; %Will calculate the proportion of a certain trialtype that was presented before the trials in a quantile.

TT.Modality{1}= [1 2 3 4 9 10 11 12 17 18 19 20 21 22 23 24];%List the trial types that include a certain modality
TT.Modality{2}= [5 6 7 8 13 14 15 16 17 18 19 20 21 22 23 24];%same as above
TT.Legend = {'Tactile' 'Vision'};%List the modalities in the same order TT.Modality

%Data to be loaded:
load('C:\Users\Maxime Pelland\Desktop\Maxime\Maxime\Results\PreProcessed_Data.mat');

SavePath = 'C:\Users\Maxime Pelland\Desktop\Maxime\Maxime\Results';
SaveNameQTCount = 'Simon_Data_with_QT_Count';
SaveNameQuantiledData = 'Simon_Data_Averaged_Quantiles';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zz = 1; %keep the count of the steps that are carried

%Launches The first step of the analysis, that is analyze the number of non
%zero answers in each trial type.
if CountTheQuantiles,
  
    display(['Step',num2str(zz),', Cound Number of possible quantiles: Start'])
    NoOutliers = CountQuantile(NoOutliers,TrialsToBeAnalyzed);
    display(['Step',num2str(zz),', Cound Number of possible quantiles: Done'])

    zz = zz + 1;

    mkdir(SavePath);
    save([SavePath,'\',SaveNameQTCount],'NoOutliers');
else

%Launches The second step of the analysis, that is, it separates the data
%into different quantiles and for each data points, it keeps track of the
%previous trial type. This is done for each trial type. 

display(['Step',num2str(zz),', Order the quantiles: Start'])
Quantiled_Data = Separate2Quantiles(NoOutliers,nQuantiles,Blocks,TrialsToBeAnalyzed);    
display(['Step',num2str(zz),', Order the quantile: Done'])
zz = zz + 1;


%Launches The second step of the analysis, that is, it separates the data
%into different quantiles and for each data points, it keeps track of the
%previous trial type. This is done for each trial type. 

display(['Step',num2str(zz),', Find proportion of previous trials + average of quantiles: Start'])
Averaged_Quantiles = AverageQT_pTrials(Quantiled_Data,TT);
display(['Step',num2str(zz),', Find proportion of previous trials + average of quantiles: Done'])
zz = zz + 1;

mkdir(SavePath);
save([SavePath,'\',SaveNameQuantiledData],'Averaged_Quantiles');

end
