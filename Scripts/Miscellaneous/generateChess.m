for i=1:78
	if (i <= 9)
		path = '00';
	else
		path = '0';
	end
	if (exist(['Images', filesep, 'Training', filesep, path, num2str(i), '.jpg'], 'file'))
		squares = extractSquares(extractBoard(im2double(rgb2gray(imread(['Images', filesep, 'Training', filesep, path, num2str(i), '.jpg'])))));
		for j=1:8
			for k=1:8
				imwrite(squares{j, k}, ['Images', filesep, 'Squares', filesep, path, num2str(i), '_', num2str(j), 'x', num2str(k), '.jpg']);
			end
		end
	end
end