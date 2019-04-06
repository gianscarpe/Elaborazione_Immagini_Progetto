load(['Variables', filesep, 'Miscellaneous', filesep, 'groundtruth.mat']);
labels = [];
for i=1:78
	if (i <= 9)
		path = '00';
	else
		path = '0';
	end
	if (exist(['Images', filesep, 'Training', filesep, path, num2str(i), '.jpg'], 'file'))
		FEN = expandString(groundTruth{i});
		FEN = FEN(1:end-6);
		for j=1:numel(FEN)
			if (FEN(j) == 'x')
				labels = [labels; "vuota"];
			elseif (not(FEN(j) == '/'))
				labels = [labels; string(FEN(j))];
			end
		end
	end
end