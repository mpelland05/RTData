function Averaged_Quantiles = AverageQT_pTrials(Quantiled_Data,TT),


for kk = 1:length(Quantiled_Data.Participants{1}.TrialType),
    
    %Get name of trialtype
    Averaged_Quantiles.TrialType{kk}.Name = Quantiled_Data.Participants{1}.TrialType{kk}.Name;
    
    
    TempRT = 0;
    for mm = 1:length(TT.Modality),
        Modality.Num{mm} = 0;
    end
    
    %%%%%%%%%%%%%%%%%%%Participants loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %add and find the average of each 
    for ii = 1:length(Quantiled_Data.Participants),
        
        %Add RT for each participants
        TempRT = TempRT + Quantiled_Data.Participants{ii}.TrialType{kk}.InverseReactionTime;
        TempPTT = Quantiled_Data.Participants{ii}.TrialType{kk}.PreviousTrialType;
        
        for ll = 1:length(TT.Modality),%sum the presence of a modality
            Modality.Num{ll} = Modality.Num{ll} + ismember(TempPTT,TT.Modality{ll});
        end
        
    end
    
    %Find average of RT at each Quantiles
    TempRT = TempRT./length(Quantiled_Data.Participants);
    
    %Find total number of modalities presented in the trials
    Modality.Tot = 0;
    for ll = 1:length(TT.Modality),
        Modality.Tot = Modality.Tot + Modality.Num{ll};   %<-----------------------------------------------------Modify this, its the count of total modality that were presented before each trial. The best would be to set a type of limit
                                                                                                                 %Solution will be to make another TT which will be used to calculate the total previous trials. 
    end

    for ll = 1:length(TT.Modality), %get proportion for each modality
        Modality.Prop{ll}.Data = Modality.Num{ll}./Modality.Tot;
        Modality.Prop{ll}.Name = TT.Legend{ll};
    end
    
    Averaged_Quantiles.TrialType{kk}.InverseReactionTime = TempRT;
    Averaged_Quantiles.TrialType{kk}.Proportions = Modality.Prop;
    
end
end