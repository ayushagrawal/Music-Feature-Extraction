function [coeffs] = final(filename)
% Length = 10s

% Fs = 22050
% Number of samples = 220500
% Frame size = 10ms + 10ms = 20ms
% Number of samples = 441
[file] = audioread(filename);
file = file(22050:44099);
num_frames = 100;
num_samples = 441;

sample_matrix = segmenter(file,num_frames,num_samples);

ham = hamming(441);
matrix = zeros(441,100);
for i=1:num_frames
    matrix(:,i) = sample_matrix(:,i).*ham;
end
matrix = fft(matrix);
matrix = abs(matrix);

filters = melFilt(40,441);
mfc = filters'*matrix;

mel_coeffs = mfc(1:16,:);

log_mel = log10(mel_coeffs);
coeffs = dct(log_mel);
delta = zeros(5,size(coeffs,2));
for i=1:15
   delta(i,:) = coeffs(i+1,:) - coeffs(i,:); 
end

coeffs = [coeffs(1:15,:);delta];
%coeffs = mean(coeffs,2);