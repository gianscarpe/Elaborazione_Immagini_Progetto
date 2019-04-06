function m = znssd(w1, w2)
	if size(w1) > size(w2)
		w2 = imresize(w2, size(w1), 'bicubic');
	else
		w1 = imresize(w1, size(w2), 'bicubic');
	end
	m1 = mean2(w1);
	m2 = mean2(w2);
	f = (w1-m1) / sqrt(sum(sum((w1-m1).^2)));
	s = (w2-m2) / sqrt(sum(sum((w2-m2).^2)));
	m = sum(sum((f-s).^2));
end