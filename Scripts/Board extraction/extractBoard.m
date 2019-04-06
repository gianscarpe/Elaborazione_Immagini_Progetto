function board = extractBoard(im)	
	close all;

	% Script riconoscimento
	% figure, imshow(im);

	% Gammacorrection high -> Sauvola Dimension low
	gammacorrection = 6 ;
	im = padimage(im, 50);
	im = im .^ gammacorrection;

	% Extract Mask
	% Dimension: [50 50]
	bw = sauvola(im , [50 50]);

	figure, imshow(bw)

	% Lato del quadrato: 3 (valutato come il max valore che non 
	% interrompa lo schema)
	square_length = 3; 
	stro = strel('square', square_length);
	bw = imerode(bw, stro);
	wb = logical(1 - bw);
	% figure, imshow(wb);

	% Extract mask
	twoMaxAreas = bwareafilt(wb, 2);
	MaxArea = bwareafilt(wb, 1);
	mask = twoMaxAreas - MaxArea;
	mask = imfill(mask, 'holes');
	figure, imshow(mask)

	% Correct Perspective
	board = real(correctPerspective(im, mask) .^ (1 / gammacorrection)) ;
	figure, imshow(board);
    
end
