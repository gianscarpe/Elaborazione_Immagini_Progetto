% tm_type = 0 -> use binary classifier for recognizing empty squares
% tm_type = 1 -> use only template matching
function fen = computeFEN_matching(squares, tm_type, corr_type, computeDescriptor, classifier)
	fen = '';
	tempsLabel = load(['Variables', filesep, 'Miscellaneous', filesep, 'tempsLabel.mat']);
	tempsLabel = tempsLabel.templatesLabels;
	if (tm_type == 0)
		for i=1:8
			spaces = 0;
			for j=1:8
				if (predict(classifier, computeDescriptor(squares{i, j})) == 'v')
					spaces = spaces + 1;
				else
					l = matcher(squares{i, j}, tm_type, corr_type);
					if (l >= 13 && l <= 24)
						l = l - 12;
					end
					if (spaces > 0)
						fen = strcat(fen, num2str(spaces), tempsLabel(l));
					else
						fen = strcat(fen, tempsLabel(l));
					end
					spaces = 0;
				end
			end
			if (spaces > 0)
				fen = strcat(fen, num2str(spaces), '/');
			else
				fen = strcat(fen, '/');
			end
		end
		fen = strcat(fen(1:end-1), ' - 0 1');
	else
		for i=1:8
			spaces = 0;
			for j=1:8
				l = matcher(squares{i, j}, tm_type, corr_type);
				if (l >= 25)
					spaces = spaces + 1;
				else	
					if (l >= 13)
						l = l - 12;
					end
					if (spaces > 0)
						fen = strcat(fen, num2str(spaces), tempsLabel(l));
					else
						fen = strcat(fen, tempsLabel(l));
					end
					spaces = 0;
				end
			end
			if (spaces > 0)
				fen = strcat(fen, num2str(spaces), '/');
			else
				fen = strcat(fen, '/');
			end
		end
		fen = strcat(fen(1:end-1), ' - 0 1');
	end
end