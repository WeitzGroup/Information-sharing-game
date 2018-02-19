function X = dec_2_bin(num,bits)
% converts decimal number "num" to binary, represented as a vector of bits,
% length specified by input "bits"
X = zeros(bits,1);
for i = bits : -1 : 1
    if num >= 2^(i-1)
        X(i) = 1;
        num = num - 2^(i-1);
    end 
end
    
    