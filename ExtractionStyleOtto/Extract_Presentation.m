function Original = Extract_Presentation(nParticipants,nBlocks, ParticipantsName, BlocksName, PathName),

%This script will extract data from presentation, the data will be put into
%a structure named Original. Only the trial type (code) and reaction time are kept
%in this script. 
%
%Note: when using this script, the pathname must be specified also,
%TempPath must be modified in order to fit the name of the files that you
%are using. In this case, name of the participants is S01_1.log for
%participant 1 block 1. It would be S01_2.log for block 2. If you are using
%this format, no need to change the line defining TempPath. 
%Also, the list of participants must be entered as a string such that:
%ParticipantsName = {'S01' 'S02' 'S03' ...'};
%Also, note that in presentation, time are given in tenth of milliseconds,
%this scripts puts them back into milliseconds. 

%Form of inputs:
%nParticipants = 3;
%nBlocks = 3;
%ParticipantsName = {'S01' 'S02' 'S03'}; %This is a structure
%BlocksName = {'1' '2' '3'}; %This is a structure
%PathName = 'C:\Users\Maxime Pelland\Desktop\Maxime\Maxime\Log Files';

for ii = 1:nParticipants,
    for jj = 1:nBlocks,
    
    TempPath = strcat(PathName,'\',ParticipantsName{ii},'_',BlocksName(jj),'.log'); %<------ Might need to modifiy this line (see above);
        
    %Open .log file
    [Trials EventType Code Time TTime Uncertainty Duration Uncertainty2 ReqTime ReqDur] = ...
    textread(cell2mat(TempPath),'%s %s %s %s %s %s %s %s %s %s','whitespace','\t');
    
    %Change the type of EventType and TTime to facilitate reading
    s1 = cell2struct(Code,'s1', length(Code));
    s2 = cell2struct(TTime,'s2', length(TTime));
    
    %Transforms EventType into a structure and TTime into a matrix
    TTimeTemp = zeros(1,length(TTime));
    for kk = 4:length(Trials),
        
        EventTypeTemp{kk} = s1(kk).s1;
        
        if ~isempty(s2(kk).s2),
            TTimeTemp(kk) = str2num(s2(kk).s2);
        else
            TTimeTemp(kk) = 0;
        end
    end
    
    %saves the results into a single structure
    Original.Participants{ii}.Blocks{jj}.TrialType = EventTypeTemp(3:length(EventTypeTemp));
    Original.Participants{ii}.Blocks{jj}.ReactionTime = TTimeTemp(3:length(TTimeTemp))./10;
    
    clear s1;clear s2;clear Trials;clear EventType;clear Code; clear Time; 
    clear TTime; clear Uncertainty; clear Duration; clear Uncertainty2; 
    clear ReqTime; clear ReqDur; clear TTimeTemp; clear EventTypeTemp;
    end
end
end