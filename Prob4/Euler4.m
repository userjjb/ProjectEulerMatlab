tic
start = uint64(9999);
batch = uint64(1000);
operands = repmat(start-(batch-1):start,batch,1);
prods = operands .* operands';

b = flipud(sscanf(fliplr(sprintf('%u ',prods)),'%u '));
toc