load(['Variables', filesep, 'Classifiers', filesep, 'BIN_GHOG_SVM_800v'])
load(['Variables', filesep, 'Classifiers', filesep, 'GHOG_SVM_800v'])
load(['Variables', filesep, 'Classifiers', filesep, 'HOG_MEAN'])
load(['Variables', filesep, 'Classifiers', filesep, 'HOG_SD'])
load(['Variables', filesep, 'Miscellaneous', filesep, 'groundtruth'])

computeDescriptor = @(im) computeGHOGDescriptor(im, mean_value, sd);
gbl_c_cm = zeros(14, 14);
gbl_t_cm = zeros(14, 14);
names = {'Q', 'K', 'B', 'R', 'N', 'P', 'q', 'k', 'b', 'r', 'n', 'p', 'Empty', 'Sum'};
for i=36:81
	if (not((i >= 49 && i <= 58) || i == 64))
		path = ['Images', filesep, 'Test' ,filesep, '0', num2str(i), '.jpg'];
		if (exist(path, 'file'))
			input = im2double(rgb2gray(imread(path)));
			board = extractBoard(input);
			squares = extractSquares(board);
			truth = groundTruth{i};
			% classifier FEN
			%c_FEN = computeFEN_classify(squares, computeDescriptor, classifier);
			% template matching FEN
			t_FEN = computeFEN_matching(squares, 0, @znssd, computeDescriptor, bin_classifier);
			% classifier confusion matrix
			%c_cm = confusionMatrix(truth, c_FEN);
			% template matching confusion matrix
			t_cm = confusionMatrix(truth, t_FEN);
			% global classifier confusion matrix
			%gbl_c_cm = gbl_c_cm + table2array(c_cm);
			% global template matching confusion matrix
			gbl_t_cm = gbl_t_cm + table2array(t_cm);
		end
	end
end
% Producer accuracy for all classes
% for all classes, Producer accuracy = (# predicted correctly) / (# Sum)
%gbl_c_cm(:, 15) = diag(gbl_c_cm) ./ gbl_c_cm(:, 14);
gbl_t_cm(:, 15) = diag(gbl_t_cm) ./ gbl_t_cm(:, 14);

%gbl_c_cm = array2table(gbl_c_cm, 'RowNames', names);
gbl_t_cm = array2table(gbl_t_cm, 'RowNames', names);
names{end+1} = 'Accuracy';
%gbl_c_cm.Properties.VariableNames = names;
gbl_t_cm.Properties.VariableNames = names;
