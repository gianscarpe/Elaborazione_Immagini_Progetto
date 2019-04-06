function m = nssd(w1, w2)
	if size(w1) > size(w2)
		w2 = imresize(w2, size(w1), 'bicubic');
	else
		w1 = imresize(w1, size(w2), 'bicubic');
	end
	f = w1 / sqrt(sum(sum(w1.^2)));
	s = w2 / sqrt(sum(sum(w2.^2)));
	m = sum(sum((f-s).^2));
    
end