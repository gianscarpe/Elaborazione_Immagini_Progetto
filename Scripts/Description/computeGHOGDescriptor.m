function hog = computeGHOGDescriptor(im, mean, sd)
    hog = computeHOGDescriptor(im);
    hog = (hog - mean) ./ sd;
end