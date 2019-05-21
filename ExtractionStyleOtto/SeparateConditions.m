function Separated = SeparateConditions(nParticipants,nBlocks,Modified,Event2Num),
%This script will separate the different conditions into different
%matrices.
           
Separated.Legend = Modified.Legend;

for ii = 1:length(Modified.Participants),
    for jj = 1:length(Modified.Participants{ii}.Blocks),
        
       %keep original events and reaction times in the structure. 
       Separated.Participants{ii}.Blocks{jj}.TrialTypeOrder = Modified.Participants{ii}.Blocks{jj}.TrialType; 
       Separated.Participants{ii}.Blocks{jj}.OriginalReactionTime = Modified.Participants{ii}.Blocks{jj}.ReactionTime; 
               
       for kk = 1:length(Event2Num.Event),

           Temp = find(Modified.Participants{ii}.Blocks{jj}.TrialType == kk);
           Separated.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.TrialNumber = Temp;
           Separated.Participants{ii}.Blocks{jj}.TrialTypeResults{kk}.ReactionTime = Modified.Participants{ii}.Blocks{jj}.ReactionTime(Temp);
            
           clear Temp;
       end       
    end
end
end