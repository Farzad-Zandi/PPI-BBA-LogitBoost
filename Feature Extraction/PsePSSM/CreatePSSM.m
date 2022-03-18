%% Farazad Zandi, 2021.
% create PSSM by PsiBlast.
% Make PSSM for P_proteinA.
clc
clear
cd 'd:\temp'
for i = 1 : 5594
    seq = ['d:\temp\seqP_proteinB\' num2str(i) '.txt'];
    pssm = ['d:\temp\PBpssm\' num2str(i) '.pssm'];    
    comm = ['psiblast -query ' seq ' -db yeast -evalue 0.001 -num_iterations 3 -num_threads 4 -out_ascii_pssm ' pssm]
    system(comm);
end
%  %% Make PSSM for P_proteinB.
% clc
% clear
% cd 'd:\temp'
% for i = 1 : 5594
%     seq = ['d:\temp\seqP_proteinB\' num2str(i) '.txt'];
%     pssm = ['d:\temp\PBpssm\' num2str(i) '.pssm'];    
%     comm = ['psiblast -query ' seq ' -db yeast -evalue 0.001 -num_iterations 3 -num_threads 4 -out_ascii_pssm ' pssm]
%     system(comm);
%  end
%% Make PSSM for N_proteinA.
% clc
% clear
% cd 'D:\temp';
% for i = 1 : 5594
%     seq = ['d:\temp\seqN_proteinA\' num2str(i) '.txt'];
%     pssm = ['d:\temp\NApssm\' num2str(i) '.pssm'];    
%     comm = ['psiblast -query ' seq ' -db yeast -evalue 0.001 -num_iterations 3 -num_threads 4 -out_ascii_pssm ' pssm]
%     system(comm);
% end
 %% Make PSSM for N_proteinB.
% clc
% clear
% cd 'D:\temp';
% for i = 1 : 5594
%     seq = ['d:\temp\seqN_proteinB\' num2str(i) '.txt'];
%     pssm = ['d:\temp\NBpssm\' num2str(i) '.pssm'];    
%     comm = ['psiblast -query ' seq ' -db yeast -evalue 0.001 -num_iterations 3 -num_threads 4 -out_ascii_pssm ' pssm]
%     system(comm);
%  end

