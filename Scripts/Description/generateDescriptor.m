function features = generateDescriptor(images, computeDescriptor) 
    features = [];
    nimages = size(images, 1);
	for n=1:nimages
		im = im2double(imread(images(n, :)));
		features = [features; computeDescriptor(im)];
	end  
end