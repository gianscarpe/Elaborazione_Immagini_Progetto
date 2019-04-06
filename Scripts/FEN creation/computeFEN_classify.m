function FEN = computeFEN_classify(squares, computeDescriptor, classifier)
	FEN = "";
	for i=1:8
		nvuota = 0;
		for j = 1:8
			im = squares{i, j};
			descriptor = computeDescriptor(im);
			label = predict(classifier,  descriptor);           
			if label == 'v'
				nvuota = nvuota + 1;
			else
			if nvuota > 0
				FEN = FEN + nvuota;
				nvuota = 0;
			end
			FEN = FEN + label;
			end
		end
		if nvuota > 0
			FEN = FEN + nvuota;
			nvuota = 0;
		end
		if (i < 8)
			FEN = FEN + "/";
		end
	end
	FEN = FEN + " - 0 1";
	FEN = char(FEN);
end
