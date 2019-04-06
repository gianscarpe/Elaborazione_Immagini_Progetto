function hog = computeZHOGDescriptor(im, mean)
    hog = computeHOGDescriptor(im);
    hog = hog - mean;
end