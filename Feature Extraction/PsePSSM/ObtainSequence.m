%% Farzad Zandi, 2021.
% Obtain sequence.
% make sequence for P_proteinA
clc
clear
load P_proteinA
data = P_proteinA;
for i = 1 : length(data)
    seq = data{i,1};
    title = ['d:\temp\seqP_proteinA\' num2str(i) '.txt'];
    newFile = fopen(title,'w')
    fwrite(newFile, seq)
    fclose(newFile)    
end
% make sequence for P_proteinB
clc
clear
load P_proteinB
data = P_proteinB;
for i = 1 : length(data)
    seq = data{i,1};
    title = ['d:\temp\seqP_proteinB\' num2str(i) '.txt'];
    newFile = fopen(title,'w')
    fwrite(newFile, seq)
    fclose(newFile)    
end
%% make sequence for N_proteinA
clc
clear
load N_proteinA
data = proteinA;
for i = 1 : length(data)
    seq = data{i,1};
    title = ['d:\temp\seqN_proteinA\' num2str(i) '.txt'];
    newFile = fopen(title,'w')
    fwrite(newFile, seq)
    fclose(newFile)    
end
%% make sequence for N_proteinB
clc
clear
load N_proteinB
data = proteinB;
for i = 1 : length(data)
    seq = data{i,1};
    title = ['d:\temp\seqN_proteinB\' num2str(i) '.txt'];
    newFile = fopen(title,'w')
    fwrite(newFile, seq)
    fclose(newFile)    
end
