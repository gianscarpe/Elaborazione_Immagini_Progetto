function m = zncc(w1, w2)
	if size(w1) > size(w2)
		w2 = imresize(w2, size(w1), 'bicubic');
	else
		w1 = imresize(w1, size(w2), 'bicubic');
	end
	m1 = mean2(w1);
	m2 = mean2(w2);
	num = sum(sum((w1-m1).*(w2-m2)));
	denom = sqrt( sum(sum((w1-m1).^2))*sum(sum((w2-m2).^2)) );
	m = num / denom;
end