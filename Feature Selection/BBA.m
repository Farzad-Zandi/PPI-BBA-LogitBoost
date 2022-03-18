%% Farzad Zandi, 2021.
% Feature selection based on binary bat algorithm.
%% Load data.
clc
clear
load dataH
y = ones(length(dataH),1);
y(1422:end,1) = -1;
CVO = cvpartition(y,'k',10);
trainIdx  = CVO.training(1); 
testIdx= CVO.test(1);
xTrain = dataH(trainIdx,:);
xTest = dataH(testIdx,:);
yTrain = y(trainIdx);
yTest = y(testIdx,:); 
[k, n] = size(dataH); % Data size.
%% Bat algorithm.
m = 10; % Numbers of bats.
X = round(rand(m,n)); % Random binary data.
v = zeros(m,n); % Initial velocities.
A = 1 + rand(m,1); % Initial loudness.
r = rand(m,1); % Initial pulse rate.
Fit(1:m) = -inf; % Local fitness.
globalFit = -inf; % Global fitness.
maxF = -inf;
max_iter = 2000; % Maximum iteration.
alpha = 0.9; % ad-hoc constant.
gamma = 0.9; % ad-hoc constant.
r0 = 0.9; % Initial pulse rate.
fmin = 0; % Minimum frequency.
fmax = 1; % Maximum frequency.
tic
for t = 1 : max_iter
    for i = 1 : m
        idx = find(X(i,:)~=0);
        xTrainP = xTrain(:,idx); % Distinguishing train data.
        xTestP = xTest(:,idx); % Distinguishing test data.
%         xTrainPgpu = gpuArray(xTrainP);  
        Mdl = fitcknn(xTrainP,yTrain,'NumNeighbors',7);     
%         clear xTrainPgpu
%         xTestPgpu = gpuArray(xTestP);        
        yPredict = predict(Mdl,xTestP);        
%         clear xTestPgpu
        err = sum(yPredict~=yTest)/numel(yPredict);        
        acc = 1 - err;        
        if rand<A(i) && acc>Fit(i)
            Fit(i) = acc;
            A(i) = alpha*A(i); % Equation 5.
            r(i) = r0*(1-exp(-gamma*t)); % Equation 6.
        end
    end
    [maxFit, MaxIdx] = max(Fit);
    maxF(t) = maxFit; 
    if maxFit>globalFit
        globalFit = maxFit;
        Xhat = X(MaxIdx,:);
    end
    for i =  1 : m
        beta = rand;
        epsilon = (2*rand)-1; % Random walk parameter.
        if rand>r(i)
            for j =  1 : n
                X(i,j) = X(i,j) + epsilon*mean(A); 
                if rand < 1/(1+exp(-X(i,j))) % Equation 7& 8.
                    X(i,j) = 1;
                else
                    X(i,j) = 0;
                end
            end
        end      
        if rand<A(i) && Fit(i)<globalFit
            for j = 1 : n
                f = fmin + (fmax-fmin)*beta;
                v(i,j) = v(i,j) + (Xhat(j) - X(i,j))*f;
                X(i,j) = X(i,j) + v(i,j);
                if rand < 1/(1+exp(-X(i,j)))
                    X(i,j) = 1;
                else
                    X(i,j) = 0;
                end
            end
        end
    end
%     gpu=gpuDevice();
%     reset(gpu);
%     wait(gpu);
    
end
F = Xhat;
toc
runTime = toc;
iii = find(F==1);
data1 = dataH(:,iii);
