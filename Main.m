%% Main

close all;
clear;

load(['Variables', filesep, 'Miscellaneous', filesep, 'groundtruth'])
load(['Variables', filesep, 'Classifiers', filesep, 'BIN_GHOG_SVM_800v'])
load(['Variables', filesep, 'Classifiers', filesep, 'GHOG_SVM_800v'])
load(['Variables', filesep, 'Classifiers', filesep, 'HOG_MEAN'])
load(['Variables', filesep, 'Classifiers', filesep, 'HOG_SD'])
path = "Images" + filesep + "Test" + filesep + "0";

nimmagine = 36;
input = im2double(rgb2gray(imread(char(path + nimmagine + ".jpg"))));

% Zero-mean Descriptor
computeDescriptor = @(im) computeGHOGDescriptor(im, mean_value, sd);

% Groundtruth
truth = groundTruth{nimmagine};

% figure
% imshow(input)

tic
board = extractBoard(input);
squares = extractSquares(board);


truth
% Classifier
tic
c_FEN = computeFEN_classify(squares, computeDescriptor, classifier)
toc

c_errors = countErrors(c_FEN, truth)
c_accuracy = (64 - c_errors) / 64 * 100
c_conf_matrix = confusionMatrix(truth, c_FEN);

% Template matching using zncc correlation
% tm_type = 0 -> use classifier to recognize empty squares, 1 -> use
% template matching only
% corr_type = choose one from: @ncc, @nssd, @zncc, @znssd
t_FEN = computeFEN_matching(squares, 0, @zncc, computeDescriptor, bin_classifier)
toc

t_errors = countErrors(t_FEN, truth)
t_accuracy = (64 - t_errors) / 64 * 100
t_conf_matrix = confusionMatrix(truth, t_FEN);

