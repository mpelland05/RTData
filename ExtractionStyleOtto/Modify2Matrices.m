function Modified = Modify2Matrices(nParticipants,nBlocks,Original,Event2Num,Legend),
%This function will transform the data that has been extracted into
%matrices for which the column number will be the trial number. Also, all
%events are coded into numbers. This step is done to simplify later
%analyses.

%Form of inputs:
%nParticipants = 3;
%nBlocks = 3;
%Original is the structure that was produced by the script Extract_Presentation.m
%Event2Num.Event = {'T1' 'T2' 'T3' 'T4'};    
%Event2Num.Num = [1:length(Event2Num.Event)];
%Legend = {'Tactile1' 'Tactile2' 'Tactile3' 'Tactile4'};  

Answer = {'2' '3'};% <---------------------------------------- Answer codes

for ii = 1:length(Original.Participants),
    for jj = 1:length(Original.Participants{ii}.Blocks),
        
        kk = 1;%Keep track of where in TrialType the script is. 
        mm = 1;%Keep track of the number of events transfered to modified
        
        while kk <= length(Original.Participants{ii}.Blocks{jj}.TrialType),
                        
            TempType = Original.Participants{ii}.Blocks{jj}.TrialType{kk};
                        
            if sum(strcmp(TempType,Answer))>0, 
                
                kk = kk + 1; %If there is an answer not preceeded by any other type of stimuli, the script skips it.
                
            elseif sum(strcmp(TempType,Event2Num.Event)) == 0,
                
                kk = kk + 1; %skips empty cells
                
            else
                %Goes through the list of possible trial and compared it with the trial
                %that is being inspected then assigns the number linked to this trial to a matrice in Modified
                TempNum = strcmp(TempType,Event2Num.Event);
                Modified.Participants{ii}.Blocks{jj}.TrialType(mm) = Event2Num.Num(find(TempNum == 1));
                clear TempNum;clear TempType;
                
                kk = kk + 1;
                
                if kk <= length(Original.Participants{ii}.Blocks{jj}.TrialType), %if there is no answer to the last trial, break the loop
                               
                    %Finds the presense of an answer for the trial, if none,
                    %the answer time is set to 0, otherwise, there is a time
                    %set to it. 
                    TempType = Original.Participants{ii}.Blocks{jj}.TrialType{kk};
                
                    if sum(strcmp(TempType, Answer))>0,
                        Modified.Participants{ii}.Blocks{jj}.ReactionTime(mm) = Original.Participants{ii}.Blocks{jj}.ReactionTime(kk);
 
                         mm = mm + 1; kk = kk + 1;
                    else
                        Modified.Participants{ii}.Blocks{jj}.ReactionTime(mm) = 0;
                        mm = mm + 1; 
                    end
                    clear TempType;
                else
                    Modified.Participants{ii}.Blocks{jj}.ReactionTime(mm) = 0;
                end
            end
        end
    end
end

Modified.Legend = Legend;

end