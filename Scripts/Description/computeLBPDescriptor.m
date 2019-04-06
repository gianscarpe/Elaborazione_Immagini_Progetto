function out=computeLBPDescriptor(image)
	out = extractLBPFeatures(image, 'NumNeighbors', 8, 'Radius', 1, 'Upright', true); 
end