function descriptor = computeHOGDescriptor(im)
        im = imresize(im, [120 120]);
        bw = imbinarize(im);    
        descriptor = extractHOGFeatures(bw, 'CellSize', [8 8], 'BlockSize', [6 6], ... 
            'BlockOverlap', [2 2], 'NumBins', 18);
end