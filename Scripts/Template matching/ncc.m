function m = ncc(w1, w2)
	if size(w1) > size(w2)
		w2 = imresize(w2, size(w1), 'bicubic');
	else
		w1 = imresize(w1, size(w2), 'bicubic');
	end
	num = sum(sum(w1.*w2));
	denom = sqrt(sum(sum(w1.^2)) * sum(sum(w2.^2)));
	m = num / denom;
end