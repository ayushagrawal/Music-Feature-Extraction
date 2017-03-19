file1 = 'blues.00000.au';
coeff1 = final(file1);
file2 = 'C:\Users\dell\Desktop\genres\metal\metal.00000.au';

figure;
plot(mean(coeff1,2));
coeff2 = final(file2);
hold on;
plot(mean(coeff2,2));

title('Features of a Song');
xlabel('Feature #');
ylabel('Value');
