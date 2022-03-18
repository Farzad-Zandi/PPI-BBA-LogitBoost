clc
clear
tic
lambmdashu = 11;
load N_proteinA
pro = proteinA;
for i = 1 :  length(pro)
    prot(i) = length(pro{i,1});
end
cd 'D:\My Educations\Philosophy Doctor in Computer Science\My Projects\My Wroks\Prediction of protein-protein interaction\GTB-PPI-master\Feature_extraction\PsePSSM\createPSSM\NApssm'
for i = 1 : length(pro)
    name = [num2str(i) '.pssm'];
    pssm{1} = importdata(name);
    data = pssm{1}.data;
    M = prot(i);
    shuju = data;
    d = [];
    for k = 1 : M
       for j = 1 : 20
           d(k,j) = 1/(1+exp(-shuju(k,j)));
       end
    end
    c = d(:,:);
    % generate PSSM-AAC
    [MM,NN] = size(c);
     for  j = 1 : 20
         x(j) = sum(c(:,j))/MM;
     end
    % generate the 20*lamda of PsePSSM
    xx = [];
    sheta = [];
    shetaxin = [];    
    for lamda = 1 : lambmdashu
      [MM,NN] = size(c);
      clear xx
       for  j = 1 : 20
          for k = 1 : MM-lamda
              xx(k,j) = (c(k,j)-c(k+lamda,j))^2;
          end
          sheta(j) = sum(xx(1:MM-lamda,j))/(MM-lamda);
       end
       shetaxin = [shetaxin,sheta];
    end
    psepssm(i,:) = [x,shetaxin];
end
toc
save psePSSMna1 psepssm
