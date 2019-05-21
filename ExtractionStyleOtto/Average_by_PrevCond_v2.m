function Averaged_PrevCond = Average_by_PrevCond(NoOutliers,CondAnal,PreCond,Labels),
%

nParticipants = length(NoOutliers.Participants);
nBlocks = length(NoOutliers.Participants{1}.Blocks);

Averaged_PrevCond.Info = 'Times are in ms. Section Average contains the average of each participant and are ordered according to participants. Zeros means that this condition did not occur with that participant';

%Creation of per participant data
for ii = 1:nParticipants,
    for kk = 1:length(CondAnal),
        
        Averaged_PrevCond.Participants{ii}.TrialType{CondAnal(kk)}.Name = NoOutliers.Legend{CondAnal(kk)};
        
        for ll = 1:length(Labels),
            
            Averaged_PrevCond.Participants{ii}.TrialType{CondAnal(kk)}.PrevCond{ll}.Name = Labels{ll};
            
            Time = 0;
            for jj = 1:nBlocks,
                  
                Temp1 = find(NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{CondAnal(kk)}.InverseReactionTime > 0); %Find of the trials of the conditons the ones that are not outliers.
                Temp2 = find(NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{CondAnal(kk)}.TrialNumber > 1); %Finds trials that a preceeded by another one.
                Temp3 = find(ismember(Temp1,Temp2)); %Find trials that are not the first one and of the condition we are interested in.
                
                TrialNum = NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{CondAnal(kk)}.TrialNumber(Temp1(Temp3));%Same as above but gives trial number in the grand order
                TrialMin1 = TrialNum -1;
                
                Temp4 = find(ismember(NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeOrder(TrialMin1),PreCond{CondAnal(kk)}(ll,:))); %Find trials which have the right previous trials;
                Trials = TrialMin1(Temp4) + 1;
                
                Temp = NoOutliers.Participants{ii}.Blocks{jj}.OriginalReactionTime(Trials);
           
                Time = [Time,Temp];
            end
            Averaged_PrevCond.Participants{ii}.TrialType{CondAnal(kk)}.PrevCond{ll}.ReactionTimes = Time(find(Time > 0));
            
            clear Time;
        end
    end
end

%Creation of per group data
for kk = 1:length(CondAnal),
        
    Averaged_PrevCond.Average.TrialType{CondAnal(kk)}.Name = NoOutliers.Legend{CondAnal(kk)};
        
    for ll = 1:length(Labels),
            
        Averaged_PrevCond.Average.TrialType{CondAnal(kk)}.PrevCond{ll}.Name = Labels{ll};
            
           
            for ii = 1:nParticipants,
                
                if ~isempty(Averaged_PrevCond.Participants{ii}.TrialType{CondAnal(kk)}.PrevCond{ll}.ReactionTimes),
                    Temp = mean(Averaged_PrevCond.Participants{ii}.TrialType{CondAnal(kk)}.PrevCond{ll}.ReactionTimes);
                else
                    Temp = 0;
                end
          
                Averaged_PrevCond.Average.TrialType{CondAnal(kk)}.PrevCond{ll}.ReactionTimes(ii) = Temp;
                
            end
        end
    end
end

