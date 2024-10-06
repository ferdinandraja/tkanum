function flops = estimate_block_flops(n, blockSize)
    numBlocks = ceil(n / blockSize);
    flops = 0;
    for i = 1:numBlocks
        currentBlockSize = min(blockSize, n - (i-1) * blockSize);
        flops = flops + (2/3) * currentBlockSize^3;
    end
end