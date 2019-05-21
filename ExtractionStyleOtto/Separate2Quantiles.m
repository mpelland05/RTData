function Quantiled_Data = Separate2Quantiles(NoOutliers,nQuantiles,Blocks,TrialsToBeAnalyzed),

if Blocks, %Analyze the data as if each block is a participant. 
    
else %put blocks together for each participants and analyses the results
    for ii = 1:length(NoOutliers.Participants),
        for kk = TrialsToBeAnalyzed,
            for jj = 1:length(NoOutliers.Participants{ii}.Blocks),

                Temp = NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.TrialNumber -1; %find the previous trial type
                if Temp(1) < 1, %if there is no previous trial, sets it to be the first one
                    Temp(1) = 1;
                end
                
                TempPTT = NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeOrder(Temp);%Prior trial type
                TempRT = NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.InverseReactionTime;%ReactionTime
                TempTN = NoOutliers.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.TrialNumber;%Number of the trial, used to removed the first trials of everyblocks;
                
                
                %Find non zero data and record previous trial and RT
                NoZer = find(TempRT > 0);
                RT{jj} = TempRT(NoZer);
                PTT{jj} = TempPTT(NoZer);
                TN{jj} = TempTN(NoZer);
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%add blocks together
            RT_Total = RT{1};
            PTT_Total = PTT{1};
            TN_Total = TN{1};
            
            if length(NoOutliers.Participants{ii}.Blocks) > 1, %concatenation of the RT and PTT
                for ll = 2:length(NoOutliers.Participants{ii}.Blocks),
                    RT_Total = [RT_Total RT{ll}];
                    PTT_Total = [PTT_Total PTT{ll}];
                    TN_Total = [TN_Total TN{ll}];
                end
            end
            

            
            %Order data based on trial number, this will allow to remove
            %the first trials of each blocks
            [O X] = sort(TN_Total);
            RT_Total = RT_Total(X);
            PTT_Total = PTT_Total(X);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Order the data and selects only the Quantiles that are
            %desired (last few trials)
            RT_Total = rot90(RT_Total,2);
            PTT_Total = rot90(PTT_Total,2);
            
            [RT_Ordered IX] = sort(RT_Total(1:nQuantiles));
            PTT_Ordered = PTT_Total(IX);
           
            %Put data into output structure
            Quantiled_Data.Participants{ii}.TrialType{kk}.Name = NoOutliers.Legend{kk};
            Quantiled_Data.Participants{ii}.TrialType{kk}.InverseReactionTime = RT_Ordered;
            Quantiled_Data.Participants{ii}.TrialType{kk}.PreviousTrialType = PTT_Ordered;
            
            clear PTT_Total;clear PTT;clear TempPTT;clear PTT_Ordered;
            clear RT_Total;clear RT;clear TempRT;clear RT_Ordered;
            clear TN_Total;clear TN;clear TempTN;
            clear NoZer;clear O;clear X;clear XI;
            
        end
    end
    
    save('Ordered_and_Quantiled_Data','Quantiled_Data');
end