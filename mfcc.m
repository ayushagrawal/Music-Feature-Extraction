function [coeffs] = mfcc(filename)
[file,Fs] = audioread(filename);
% Length = 30s
% Total Number of samples = 30*22050
% 40ms main frame + (20ms from each side)*2 = 80ms total
% Total number of frames = 30/(40*1e-3)
file = file(1:661500);
num_frames = (size(file,1)/Fs)*100;
num_samples = Fs*20*1e-3;

sample_matrix = segmenter(file,num_frames,num_samples);

ham = hamming(size(sample_matrix,1));
plot(ham);
hammed_matrix = zeros(size(sample_matrix));
for i=1:num_frames
    hammed_matrix(:,i) = sample_matrix(:,i).*ham;
end
fft_matrix = fft(hammed_matrix);
mag_matrix = abs(fft_matrix);

filters = melFilt(40,size(fft_matrix,1));
mfc = filters'*mag_matrix;

mel_coeffs = mfc(1:16,:);

log_mel = log10(mel_coeffs);
coeffs = dct(log_mel);
delta = zeros(5,size(coeffs,2));
for i=1:15
   delta(i,:) = coeffs(i+1,:) - coeffs(i,:); 
end

coeffs = [coeffs(1:15,:);delta];