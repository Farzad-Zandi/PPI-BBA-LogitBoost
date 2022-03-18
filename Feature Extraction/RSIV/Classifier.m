%% Farzad Zandi, 2021.
% Classifying protein dataset with KNN, SVM, Bayesian, D-Tree.
clc
clear 
close all
load RSIV
x = data_reduce;
x(1:5594,size(x,2)+1) = 1;
x(5595:end,size(x,2)) = -1;
methods = {'KNN', 'SVM' ,'Bayesian', 'DTree'}; % Methods.
nMethods = numel(methods);
datasetFileName = 'data';
Results = [];
X = x(:,2:size(x,2)-1);
y = x(:,size(x,2));

problem.X = X;
problem.y = y;
numC = numel(unique(y)); % Number of classes.
N = numel(y);
k = round(N/(N/10));
CVO = cvpartition(y,'k',k);
Errors = zeros(CVO.NumTestSets,1);
Precisions = zeros(CVO.NumTestSets,1);
Recalls = zeros(CVO.NumTestSets,1);
RunTimes = zeros(CVO.NumTestSets,1);
NSamples = zeros(CVO.NumTestSets,1);
iTr = 0;
for iCV = 1:CVO.NumTestSets
    % MAT % CV training set is also our training set.

    trainIdx  = CVO.training(iCV); 
    testIdx= CVO.test(iCV);
    numCTr = numel(unique(y(trainIdx))); % Number of classes in training set.
    if numC ~= numCTr
        disp('Partitions are discarded...')
        pause(0.1)
        continue
    end
    iTr = iTr+1;
    problem.testIdx = testIdx;
    problem.trainIdx = trainIdx;
    for methodNo = 1 : nMethods
        ravesh = methods{methodNo};
        fprintf(' Dataset : %s, Number of test samples : %d, Method : %s\n',datasetFileName,...
            numel(find(problem.testIdx==1)),ravesh)
        [pre, rec, err, runTime] = dasteband(problem,ravesh) ;
        Errors(iTr,methodNo) = err;
        Precisions(iTr,methodNo) = pre;
        Recalls(iTr,methodNo) = rec;
        RunTimes(iTr,methodNo) = runTime;
    end
    NSamples(iTr) = sum(trainIdx);
end
if iTr == 0
    error('There is not any training set containing all categories')
end
for methodNo = 1 : nMethods
    Results(methodNo).kCV = k;
    Results(methodNo).NRuns = iTr;
    Results(methodNo).NSamples = round(mean(NSamples));
    Results(methodNo).method(methodNo).rt = mean(RunTimes(:,methodNo));
    Results(methodNo).method(methodNo).er = mean(Errors(:,methodNo));
    Results(methodNo).method(methodNo).pre = mean(Precisions(:,methodNo));
    Results(methodNo).method(methodNo).rec = mean(Recalls(:,methodNo));
    Results(methodNo).method(methodNo).acc = 1-Results(methodNo).method(methodNo).er;
    Results(methodNo).method(methodNo).methodName = methods{methodNo};
end


% resFileName = sprintf('Results');
% writeLatexResults(Results,methods);