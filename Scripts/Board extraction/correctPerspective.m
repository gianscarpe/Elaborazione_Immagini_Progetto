function result = correctPerspective(im, BoardMask)

    movingpoints = Get4Corner(BoardMask); 
	
	l = max(min([pdist2(movingpoints(1, :), movingpoints(2, :)), ...
				 pdist2(movingpoints(2, :), movingpoints(3, :)), ...
				 pdist2(movingpoints(3, :), movingpoints(4, :)), ...
				 pdist2(movingpoints(4, :), movingpoints(1, :))
				]), 300);
%	l = 400;
    fixedpoints = round([0 0; l 0; l l; 0 l;]);

%      figure
%      imshow(BoardMask);
%      hold on;
%      plot(movingpoints(:, 1), movingpoints(:, 2),'rx','LineWidth',2);

    % projective:
    % Use this transformation when the scene appears tilted. 
    % Straight lines remain straight, but parallel lines converge toward 
    % a vanishing point
    
    T = fitgeotrans(movingpoints, fixedpoints, 'projective');
    boardT = imwarp(im, T, 'bicubic', 'OutputView', imref2d(size(im)));
  
    result = imcrop(boardT, [0 0, l, l]);
    
end

function corners = Get4Corner(BoardMask)
    % detect possible corners
    points = detectHarrisFeatures(BoardMask);
    C = (points.Location);
    C = round(C);
    % compute par-wise distances between all points
    D = pdist2(C, C);
    p = zeros(1, 4);
    
    % (idx1, idx2) indexes in harrisPoints of 2 extrema points (points wich
    % distance is max)
	[idx1, idx2] = find(D == max(D(:)), 1);
    p(1:2) = [idx1, idx2];
    
    % add first pair distance to distance matrix so the next pair will be
    % distant from this pair as well, and compute max distance again

    A = bsxfun(@plus, D, sum(D([idx1 idx2], :), 1));
    % (1) Get the rows idx1 AND idx2, sum them per columns = get a row
    % (2) sum to each row of D the row obtain from (1)
    % Meaning: sum the distances of each point from idx1 and idx1 in a row
    % -> the 2 points which distances from idx1 and idx2 are max will be
    % the other 2 corners
    
	[idx3, idx4] = find(A == max(A(:)), 1);
    p(3:4) = [idx3, idx4];
	
    corners = [ceil(C(p, 1)), ceil(C(p, 2))];
    corners = sortCorners(corners);
	
end

function sortedCorners = sortCorners(corners)

	x = corners(:, 1);
	y = corners(:, 2);
	cx = mean(x);
	cy = mean(y);
	a = atan2(y - cy, x - cx);
	[~, order] = sort(a);
	sortedCorners(:, 1) = x(order);
	sortedCorners(:, 2) = y(order);
    
    
end