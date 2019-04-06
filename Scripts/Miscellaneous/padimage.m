function paddedimage = padimage(input, padding)
    [r, c] = size(input);
    paddedimage = double(zeros(r+ 2 * padding ,c + 2 * padding));
    paddedimage(padding + 1 : r + padding, padding + 1: c + padding) = input;
    
end