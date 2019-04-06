function squares = extractSquares(grid)
	
 	figure, imshow(grid);
	
	s = size(grid);
	pad_size = round(0.02*s);
	
	grid_corr = grid .^ 6;
	sauvola_grid = sauvola(grid_corr, round(s / 8));	
% 	figure, imshow(sauvola_grid);
	sauvola_grid = padarray(sauvola_grid, pad_size, 0, 'both');
	opened_grid = imopen(sauvola_grid, strel('line', pad_size(1), -45));
	grid_edges = edge(opened_grid, 'Canny');
	grid = padarray(grid, pad_size, 0, 'both');
	
% 	figure, imshow(grid_corr);
% 	figure, imshow(sauvola_grid);
%  	figure, imshow(opened_grid);
 	figure, imshow(grid_edges);

	%% Hough for vertical and orizontal lines detection

 	[H, theta, rho] = hough(grid_edges, 'Theta', [-90, 0, 89]) ;
 	figure, imshow(H, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
 	axis on , axis normal;
 	xlabel('\theta') , ylabel('\rho');

 	peaks = houghpeaks(H, 18, 'Threshold', 0.05*max(H(:)));
  	hold on
  	plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'w');

	lines = houghlines(grid_edges, theta, rho, peaks, 'FillGap', 0.99 * max(size(grid)));
	lines = struct2array(lines);
	lines = reshape(lines, 6, []);
	lines = lines';
	lines = sortrows(lines, 6); 

	min_coord = min(min(lines(:, 1:4)));
	max_coord = max(max(lines(:, 1:4)));	
	
	lines(1:9, 1) = min_coord;
	lines(1:9, 3) = max_coord;
	lines(10:18, 2) = min_coord;
	lines(10:18, 4) = max_coord;
	lines(1, 2:4) = max_coord;
	lines(9, 1:2) = min_coord;
	lines(9, 4) = min_coord;
	lines(10, 1:3) = min_coord;
	lines(18, 1) = max_coord;
	lines(18, 3:4) = max_coord;
	
 	figure, imshow(grid), hold on;
 	for k=1:length(lines)
 		xy = [lines(k, 1:2); lines(k, 3:4)];
      	plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'g');
 	end

	squares = cell(8, 8);
	for k=9:-1:2
		for j=10:17
			squares{10-k, j-9} = imcrop(grid, [lines(j, 1), lines(k, 2), lines(j+1, 1)-lines(j, 1), lines(k-1, 2)-lines(k, 2)]);
		end
	end
end

