function NoOutliers = RemoveOutliers(nParticipants,nBlocks,Separated,Event2Num,MinRT,MaxRT,NumSTD,OutByParticipants),
%Note, this scripts carries the rejection in the 1/TR.

NoOutliers = Separated;

for kk = 1:length(Event2Num.Event),
    for ii = 1:length(Separated.Participants),
        
        if OutByParticipants, %calculates standard deviations based on participants
            Temp = 0;
            for jj = 1:nBlocks,
                RTs = Separated.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.ReactionTime;
                Zer = find(RTs > MinRT & RTs < MaxRT);
                Temp = [Temp RTs(Zer)];
            end
        
            StandDev = std(Temp);
            
        clear Temp;clear RTs;clear Zer;
        end
        
        for jj = 1:length(Separated.Participants{ii}.Blocks),

        
            Temp = Separated.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.ReactionTime;
            
            Zer = find(Temp < MinRT | Temp > MaxRT); %Find values under Min RT and Max RT
            
            if ~isempty(Zer), % Set values under MinRT and MaxRT to 0.
                Temp(Zer) = 0;
                clear Zer;
            end
            
            noZer = find(Temp > 0);     %Find the 1/RT of all RTs
            Temp(noZer) = 1./Temp(noZer);
            
            %Calculate Outliers
            if ~isempty(noZer),
                Average = mean(Temp(noZer)); 
            else
                Average = 0;
            end
            
            if OutByParticipants < 1,   %Calculate Standard deviation based on blocks
                StandDev = std(Temp(noZer));
            end
            
            Zer = find(Temp < (Average - (3*StandDev)) | Temp > (Average + (3*StandDev)) ); %Remove Outliers
            if ~isempty(Zer), % Set values under MinRT and MaxRT to 0.
                Temp(Zer) = 0;
                clear Zer;
            end
            
            NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.Name = NoOutliers.Legend{kk};
            NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.InverseReactionTime = Temp.*1000;
            NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk} = rmfield(NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk},'ReactionTime');
            clear Temp;clear Zer; clear noZer;clear Average;
        end
        clear StandDev;
    end
end
display('Time transformed to 1/seconds');
end