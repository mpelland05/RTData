function MissAndOutliers = CalculateMissAndOutliers(nParticipants,nBlocks,NoOutliers,Separated),

for ii = 1:nParticipants,
    for kk = 1:length(NoOutliers.Participants{ii}.Blocks{1}.TrialTypeResults),
            
        NumTrials = 0;
        NumMiss = 0;
        NumOutliers = 0;
        
        for jj = 1:nBlocks,
            
            TempNumTrials = length(Separated.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.ReactionTime);
            TempNumMiss = sum(Separated.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.ReactionTime == 0);
            TempNumOutliers = sum(NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.InverseReactionTime == 0);
            
            NumTrials = NumTrials + TempNumTrials;
            NumMiss = NumMiss + TempNumMiss;
            NumOutliers = NumOutliers + TempNumOutliers;
        end
        
        MissAndOutliers.Participants{ii}.TrialType{kk}.Name = NoOutliers.Legend{kk};
        MissAndOutliers.Participants{ii}.TrialType{kk}.Number_of_Trials = NumTrials;
        MissAndOutliers.Participants{ii}.TrialType{kk}.Number_of_Misses = NumMiss;
        MissAndOutliers.Participants{ii}.TrialType{kk}.Number_of_Outliers = NumOutliers - NumMiss;
    end
end

end