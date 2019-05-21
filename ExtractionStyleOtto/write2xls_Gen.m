function xx = write2xls_Gen(Averaged_PrevCond,SavePath),

%Same conditions as the file Average_by_PrevCond


CondAnal = 1:24;

Labels = {'Prev'};


nParticipants = length(Averaged_PrevCond.Participants);


%write to excel

for ll = 1:length(Labels),
    
    %name of excel file for each previous conditions
    t = Labels{ll};
    Path_n_Name = [SavePath,'_',t];
    
    
    for kk = 1:length(CondAnal),
         
        %Write Condition name
        nn = Averaged_PrevCond.Average.TrialType{CondAnal(kk)}.Name;
        xlswrite(Path_n_Name,nn,nn,'A2');
        
        %Writeheader
        xlswrite(Path_n_Name,'Condition',nn,'A1');
        xlswrite(Path_n_Name,'Individual_Averages',nn,'A5');
                        
        Temp = Averaged_PrevCond.Average.TrialType{CondAnal(kk)}.PrevCond{ll}.ReactionTimes;
        xlswrite(Path_n_Name,Temp,nn,'A3');
    
    
        for ii = 1:nParticipants,
            %write participants name
            PName = ['P',num2str(ii)];
            PPlace = ['A',num2str(ii+7)];
            xlswrite(Path_n_Name,PName,nn,PPlace);
            
            %writes participants results
            NPlace = ['C',num2str(ii+7)];
            Temp = Averaged_PrevCond.Participants{ii}.TrialType{CondAnal(kk)}.PrevCond{ll}.ReactionTimes;
            if isempty(Temp),
                Temp = 0;
            end
            xlswrite(Path_n_Name,Temp,nn,NPlace);
        end
        
    end
        

end