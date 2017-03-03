%% Problem 1.1

% b)
clc, clear
data = load('hw5_p1a.mat');
X = data.X';
k = 2;
initClass = randi(1:k, 1, size(X,2));

% profile on
tic
kmc = KMeansCluster(k, 'linear_kernel', X, initClass, 'UpdatePlot', false, 'RetrieveData', 2);
toc
gscatter(X(1,:), X(2,:), kmc{2,1})

% profile viewer

%% d)
clc, clear
data = load('hw5_p1b.mat');
X = data.X';
k = 2;
initClass = randi(1:k, 1, size(X,2));

% profile on
tic
kmc = KMeansCluster(k, 'rbf_kernel', X, initClass, 'UpdatePlot', false);
toc
gscatter(X(1,:), X(2,:), kmc{2,1})

% profile viewer


%% Problem 1.2 a)
clc, clear
k = 10;
data = load('medium_100_10k.mat');
vocab = data.vocab;
wordemb = data.wordembeddings;

[~, D, ~] = kmeansWrapper(wordemb, k, 1);

clc
[~, I] = sort(D);
closestWords = vocab(I(1:10,:));
disp(closestWords)

%% b) 
clc, clear D, clear closestWords, clear I

repetitions = 10;
f = 0;

for i=1:repetitions
    % First run
    [idx, ~, ~] = kmeansWrapper(wordemb, k, 1);

    % Find the indices of members of the 'cavalry'-cluster 
    % and calculate N_0
    cav_index = find(strcmp(vocab, 'cavalry'));
    cavCluster = idx(cav_index);
    sizeCavCluster = nnz(idx == cavCluster);
    N_0 = sizeCavCluster*(sizeCavCluster-1)/2;
    elem_inds = find(idx == cavCluster); 
    
    % Second run
    [idx, ~, ~] = kmeansWrapper(wordemb, k, 1);
    
    k = 10;
    clusterFreq = zeros(1, k);

    for j = elem_inds'
        clusterFreq(idx(j)) = 1 + clusterFreq(idx(j));
    end

    N_1 = sum(clusterFreq.*(clusterFreq - 1)/2);
    f = f + N_1/N_0;
    fprintf('Finished run %.f \n', i)
end

f_avg = f/repetitions;

fprintf('F = %.3f \n',f_avg)

%% c)
% Load data
clc
data = load('medium_100_10k.mat');
wordemb = data.wordembeddings;
k = 10;
sliceOfWordemb = wordemb(randperm(10000, 1000), :);

[idx,D,depth] = kmeansWrapper(sliceOfWordemb, k, 1);


% Set parameters
no_dims = 2;
initial_dims = 100;
perplexity = 30;
% Run t−SNE
mappedX = tsne(sliceOfWordemb, [], no_dims, initial_dims, perplexity);

% Plot results
gscatter(mappedX(:,1), mappedX(:,2), idx);