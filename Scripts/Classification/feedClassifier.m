%% Feed classificatore SVM
function [classifier, out] = feedClassifier(features, labels, nvuotalabel)
    
	[features, labels] = prepareData(features, labels, nvuotalabel); 
    cv = cvpartition(labels, 'Holdout', 0.2);	
    [classifier, out] = feedSVM(features, labels, cv);  

end

function [features, labels] = prepareData(features, labels, nvuotalabels)

    vuotalabelsindexes = find(labels == 'vuota');
    nimages = size(vuotalabelsindexes, 1);
    
    randomIndex = vuotalabelsindexes(randperm(nimages));
    vuotafeatures = features(randomIndex(1 : nvuotalabels), :);
    
    features(vuotalabelsindexes, :) = [];
    labels(vuotalabelsindexes) = [];

    vuotalabels = string([]);
    vuotalabels(1:nvuotalabels, 1) = "vuota";

    features = [features; vuotafeatures];
    labels = char([labels; vuotalabels]);

end


function [classifier, out] = feedSVM(descriptor, labels, cv)
  % Testa un classificatore dati descrittori, etichette e partizionamento.
  % Parametri: 
  %   descriptor : descrittore/i da usare per la classificazione
  %   labels : etichette delle immagini
  %   cv : output di cvpartition con le partizioni train set / test set
  
  mean_value = mean(descriptor);
  sd = std2(descriptor);
<<<<<<< HEAD
  
  save('Variables\Classifiers\HOG_MEAN.mat', 'mean_value');
  save('Variables\Classifiers\HOG_SD.mat', 'sd');
=======
%   
    save('HOG_MEAN', 'mean_value');
    save( 'HOG_SD', 'sd');
>>>>>>> cc9adc5110e23bde339249d573aeaa8d16fc7d0f
  
  descriptor = (descriptor - mean_value) ./ sd;
  
  train_values = descriptor(cv.training,:);
  train_labels = labels(cv.training);
 
  test_values  = descriptor(cv.test,:);
  test_labels  = labels(cv.test);

  template = templateSVM(...
        'KernelFunction', 'polynomial', ...
        'PolynomialOrder', 3, ...
        'KernelScale', 'auto', ...
        'BoxConstraint', 1, ...
        'Standardize', true);
    
  classifier = fitcecoc(...
        train_values, ...
        train_labels, ...
        'Learners', template, ...
        'Coding', 'onevsone');

  train_predicted = predict(classifier, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(classifier, test_values);
  test_perf = confmat(test_labels, test_predicted);
  
  out = [train_perf, test_perf];

end
