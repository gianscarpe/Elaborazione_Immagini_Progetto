function conf = confusionMatrix(o_FEN, g_FEN)
	%Input
	%o_FEN: precalculated original FEN
	%g_FEN: FEN generated by computeFen function
	%Output
	%conf: confusion matrix
	%	   col values -> predicted
	%	   row values -> reals
	%	   Q K B R N P q k b r n p Empty sum
	%	Q
	%	K
	%	B
	%	R
	%	N
	%	P
	%	q
	%	k
	%	b
	%	r
	%	n
	%	p
	%	Empty
	%	sum
	
	conf = zeros(14, 14);
	labels = ['Q', 'K', 'B', 'R', 'N', 'P', 'q', 'k', 'b', 'r', 'n', 'p', 'x'];
	names = {'Q', 'K', 'B', 'R', 'N', 'P', 'q', 'k', 'b', 'r', 'n', 'p', 'Empty', 'Sum'};
	o_FEN = expandString(o_FEN);
	g_FEN = expandString(g_FEN);
	o_FEN = o_FEN(1:end-6);
	g_FEN = g_FEN(1:end-5);
	for i=1:numel(o_FEN)
		if (not(o_FEN(i) == '/'))
			s = find(o_FEN(i) == labels);
			if (o_FEN(i) == g_FEN(i))
				conf(s, s) = conf(s, s) + 1;
			else	
				t = find(g_FEN(i) == labels);
				conf(s, t) = conf(s, t) + 1;
			end
		end
	end
	for i=1:14
		conf(i, 14) = sum(conf(i, 1:13));
	end
	for i=1:14
		conf(14, i) = sum(conf(1:13, i));
	end
	conf = array2table(conf, 'RowNames', names, 'VariableNames', names);
end