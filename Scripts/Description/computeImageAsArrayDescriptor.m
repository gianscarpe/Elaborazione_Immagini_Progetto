function descriptor = computeImageAsArrayDescriptor(image)
    descriptor = reshape(imresize(image, [64 64]), [1 64*64]);
end