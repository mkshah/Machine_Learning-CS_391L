function [acc_mat] = main()

% Store accuracy values in Grid Search
acc_mat = zeros(5,5,5);

% Loading the dataset and reshaping it
load('digits.mat');
fprintf('Reshaping Train and Test Sets...\n\n');
trainSet = reshape(trainImages,784,60000);
testSet = reshape(testImages,784,10000);

% Count variable to check how many config.s have already completed
cnt=0;

% Variables to keep track of indices
i1=0;
j1=0;

% Grid Search
for i=1:1:5
    i1=i1+1;
    for j=2:1:6
        j1=j1+1;
        acc_mat(i,j,:) = find_accuracy(trainSet, testSet, trainLabels, testLabels, i, j);
        cnt=cnt+5;
        fprintf('\n %d/125 completed...\n\n',cnt);   
    end
    j1=0;
end

end
