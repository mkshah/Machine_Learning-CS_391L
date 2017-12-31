function [acc] = find_accuracy(trainSet, testSet, trainLabels, testLabels, no_train_construct, no_train_project)

fprintf('Entering Configuration (%d,%d)...\n', no_train_construct, no_train_project);

% Constructing Eigenvectors
fprintf('Constructing EigenVectors...\n');
[V, m] = hw1FindEigendigits(trainSet(:,1:no_train_construct));
V2 = reshape(V,28,28,no_train_construct);

% Defining matrixs to store projections
Xset = zeros(no_train_project,no_train_construct);
Yset = zeros(10000,no_train_construct);

% Project training set
fprintf('Projecting training set...\n');
for i=1:no_train_project
    a = trainSet(:,i) - uint8(m);
    b = double(V')*double(a);
    Xset(i,:) = b';
end

% Project testing set
fprintf('Projecting testing set...\n');
for i=1:10000
    a = (testSet(:,i) - uint8(m));
    b = double(V')*double(a);
    Yset(i,:) = b';
end

% Accuracy array for 5 different k values in KNN
acc = zeros(1,5);

% Fit the KNN model - 1
fprintf('Calculating accuracy for k=1...\n');
model =  ClassificationKNN.fit(Xset,trainLabels(1:no_train_project)','NumNeighbors',1);
% Calculate Accuracy
accuracy = 0;
for i=1:10000
    true_label = testLabels(i);
    pred_label = predict(model,Yset(i,:));
    if(true_label==pred_label) 
        accuracy= accuracy+1;
    end
end
acc(1) = accuracy / 10000;

% Fit the KNN model - 2
fprintf('Calculating accuracy for k=2...\n');
model =  ClassificationKNN.fit(Xset,trainLabels(1:no_train_project)','NumNeighbors',2);
% Calculate Accuracy
accuracy = 0;
for i=1:10000
    true_label = testLabels(i);
    pred_label = predict(model,Yset(i,:));
    if(true_label==pred_label) 
        accuracy= accuracy+1;
    end
end
acc(2) = accuracy / 10000;

% Fit the KNN model - 4
fprintf('Calculating accuracy for k=4...\n');
model =  ClassificationKNN.fit(Xset,trainLabels(1:no_train_project)','NumNeighbors',4);
% Calculate Accuracy
accuracy = 0;
for i=1:10000
    true_label = testLabels(i);
    pred_label = predict(model,Yset(i,:));
    if(true_label==pred_label) 
        accuracy= accuracy+1;
    end
end
acc(3) = accuracy / 10000;

% Fit the KNN model - 8
fprintf('Calculating accuracy for k=8...\n');
model =  ClassificationKNN.fit(Xset,trainLabels(1:no_train_project)','NumNeighbors',8);
% Calculate Accuracy
accuracy = 0;
for i=1:10000
    true_label = testLabels(i);
    pred_label = predict(model,Yset(i,:));
    if(true_label==pred_label) 
        accuracy= accuracy+1;
    end
end
acc(4) = accuracy / 10000;

% Fit the KNN model - 16
fprintf('Calculating accuracy for k=16...\n');
model =  ClassificationKNN.fit(Xset,trainLabels(1:no_train_project)','NumNeighbors',16);
% Calculate Accuracy
accuracy = 0;
for i=1:10000
    true_label = testLabels(i);
    pred_label = predict(model,Yset(i,:));
    if(true_label==pred_label) 
        accuracy= accuracy+1;
    end
end
acc(5) = accuracy / 10000;

fprintf('Accuracies: %.2f %.2f %.2f %.2f %.2f \n',acc(1),acc(2),acc(3),acc(4),acc(5));
fprintf('Exiting Configuration (%d,%d)...\n', no_train_construct, no_train_project);

end
