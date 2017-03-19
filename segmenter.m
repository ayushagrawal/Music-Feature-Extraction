function [ matrix ] = segmenter( file,num_frames,num_samples )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
matrix = zeros(num_samples,num_frames);

a = file(1:0.75*num_samples);
matrix(num_samples*0.25 + 1:end,1) = a;

for i=2:num_frames -1
   matrix(:,i) =  file((2*i - 3)*num_samples/4:(2*i + 1)*num_samples/4 -1);
end
    matrix(1:(3*num_samples/4),num_frames) = file((2*num_frames - 3)*num_samples/4 : end-1);
end

