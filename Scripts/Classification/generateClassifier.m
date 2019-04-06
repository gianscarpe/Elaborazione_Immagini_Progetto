%% Script per generate il classificatore
clc
clear
close all
<<<<<<< HEAD
load('Variables\Miscellaneous\images')
load('Variables\Miscellaneous\bin_labels')
%load('Variables\Miscellaneous\labels')
load('Variables\Features\HOGFeatures')
=======
load(['Variables', filesep, 'Miscellaneous', filesep, 'images'])
%load('Variables\Miscellaneous\bin_labels')
load(['Variables', filesep, 'Miscellaneous', filesep, 'labels'])
load(['Variables', filesep, 'Features', filesep, 'HOGFeatures'])
>>>>>>> cc9adc5110e23bde339249d573aeaa8d16fc7d0f

[bin_classifier, out] = feedClassifier(features, bin_labels, 800);
%[classifier, out, idx] = feedClassifier(features, labels, 800);
accuracy = out(2).accuracy;

figure
bar(1, accuracy)     
xlabel('Descriptors')
ylabel('% of accuracy')
set(gca, 'XTick', 1, 'XTickLabel', 'Descriptor');

<<<<<<< HEAD
save('Variables\Classifiers\BIN_GHOG_SVM_800v.mat', 'bin_classifier');
%save('Variables\Classifiers\GHOG_SVM_800v.mat', 'classifier');
=======
%save('Variables\Classifiers\BIN_IAA_SVM_2000v.mat', 'bin_classifier');
save(['Variables', filesep, 'Classifiers', filesep, 'GHOG_SVM_1000v.mat'], 'classifier');
>>>>>>> cc9adc5110e23bde339249d573aeaa8d16fc7d0f

