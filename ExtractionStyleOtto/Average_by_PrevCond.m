function Averaged_PrevCond = Average_by_PrevCond(NoOutliers),

%Conds to analyze : CondAnal = [1 2 3 4 5 6 7 8 9 10 13 14 ];
%Preceeding conditions: PreCond{ii} = [1 2 9];
%Preceeding conditions names: PreCond.Labels = {'AS' 'AD' 'MS' 'MD'};

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

