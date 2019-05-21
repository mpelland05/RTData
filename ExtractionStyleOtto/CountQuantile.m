function NoOutliers = CountQuantile(NoOutliers,TrialsToBeAnalyzed),

CountQuantiles.Blocks.Mat = zeros(length(NoOutliers.Participants),length(NoOutliers.Participants{1}.Blocks),length(TrialsToBeAnalyzed));

for ii = 1:length(NoOutliers.Participants),
    for jj = 1:length(NoOutliers.Participants{ii}.Blocks),
        for kk = TrialsToBeAnalyzed,
            
            CountQuantiles.Blocks.Mat(ii,jj,kk) = (sum(NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.InverseReactionTime > 0));
        end
    end
end

CountQuantiles.Participants.Mat = sum(CountQuantiles.Blocks.Mat,2);

CountQuantiles.Blocks.Min = min(min(min(CountQuantiles.Blocks.Mat)));
CountQuantiles.Participants.Min = min(min(CountQuantiles.Participants.Mat));

NoOutliers.Count_Quantiles_Info = CountQuantiles; 

end