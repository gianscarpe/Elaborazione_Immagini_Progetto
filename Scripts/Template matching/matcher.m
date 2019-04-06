% tm_type = 0 -> use binary classifier for recognizing empty squares, so
% the upper limit must not include template 25 and 26 (empty squares)
% tm_type = 1 -> use only template matching, so it must include template 25
% and 26 (empty squares)
function m = matcher(piece, tm_type, corr_type)
	limit = 26;
	if (tm_type == 0)
		limit = 24;
	end 
	if (isequal(corr_type, @znssd) || isequal(corr_type, @nssd))
		tmp = intmax;
		for k=1:limit
			if not(k == 7 || k == 19)
				template = im2double(rgb2gray(imread(['Images', filesep, 'Templates', filesep, num2str(k), '.png'])));
				t = corr_type(piece, template);
				if (t < tmp)
					tmp = t;
					m = k;
				end
			end
		end
	else
		tmp = 0;
		for k=1:limit
			if not(k == 7 || k == 19)
				template = im2double(rgb2gray(imread(['Images', filesep, 'Templates', filesep, num2str(k), '.png'])));
				t = corr_type(piece, template);
				if (t > tmp)
					tmp = t;
					m = k;
				end
			end
		end
	end
end



