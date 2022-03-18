function [pre,rec,err,runTime] = dasteband(problem,ravesh)
% Mahmood Amintoosi, HSU 2018
% Modified by : Farzad Zandi

tic
X = problem.X;
y = problem.y;
trainIdx = problem.trainIdx;
testIdx = problem.testIdx;
xTrain = X(trainIdx,:);
xTest = X(testIdx,:);
yTrain = y(trainIdx);
yTest = y(testIdx,:);

switch ravesh
    case 'SVM'
        Mdl = fitcecoc(xTrain,yTrain);
        yPredict = predict(Mdl,xTest);
        runTime = toc;
        pre = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==1))-numel(intersect(find(yPredict==1),find(yTest==1)))));
        rec = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==-1))-numel(intersect(find(yPredict==-1),find(yTest==-1)))));
        tp = numel(intersect(find(yPredict==1),find(yTest==1)));
        fp = (numel(find(yTest==1))-numel(intersect(find(yPredict==1),find(yTest==1))));
        err = sum(yPredict~=yTest)/numel(yPredict);
    case 'KNN'
        Mdl = fitcknn(xTrain,yTrain,'NumNeighbors',7);
        yPredict = predict(Mdl,xTest);
        runTime = toc;
        pre = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==1))-numel(intersect(find(yPredict==1),find(yTest==1)))));
        rec = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==-1))-numel(intersect(find(yPredict==-1),find(yTest==-1)))));
        err = sum(yPredict~=yTest)/numel(yPredict);     
    case 'Bayesian'
        Mdl = fitcnb(xTrain,yTrain);
        Mdl.Prior;
        yPredict = predict(Mdl,xTest);
        runTime = toc;
        pre = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==1))-numel(intersect(find(yPredict==1),find(yTest==1)))));
        rec = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==-1))-numel(intersect(find(yPredict==-1),find(yTest==-1)))));
        err = sum(yPredict~=yTest)/numel(yPredict);
    case 'DTree'
        Mdl = fitctree(xTrain,yTrain);
        yPredict = predict(Mdl,xTest);
        runTime = toc;
        pre = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==1))-numel(intersect(find(yPredict==1),find(yTest==1)))));
        rec = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==-1))-numel(intersect(find(yPredict==-1),find(yTest==-1)))));
        err = sum(yPredict~=yTest)/numel(yPredict);
    case 'AdaBoost'
        [~, Mdl] = adaboost('train',xTrain,yTrain,1);
        yPredict = adaboost('apply',xTest,Mdl);
        runTime = toc;
        pre = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==1))-numel(intersect(find(yPredict==1),find(yTest==1)))));
        rec = numel(intersect(find(yPredict==1),find(yTest==1))) / (numel(intersect(find(yPredict==1),find(yTest==1))) + (numel(find(yTest==-1))-numel(intersect(find(yPredict==-1),find(yTest==-1)))));
        err = sum(yPredict~=yTest)/numel(yPredict);
    case 'MLP'
        err = MLP(xTrain,yTrain,xTest,yTest);
        runTime = toc;
end

end
