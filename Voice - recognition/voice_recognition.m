% Aim Male/ Female recognition through voice


close all
clear all


%step 1 to obtain the audio from the speaker
dur=3;
fs=44100;
recodedvoice=audiorecorder(fs,16,1);
disp('Sir/Mam can you please speak');
recordblocking(recodedvoice,dur);
disp('Sir/Mam your voice have been recorded');


% step 2 taking the audio data
data_recordedvoice = getaudiodata(recodedvoice);


% step 3 doing the fourier transform
N = length(data_recordedvoice);
Y = fft(data_recordedvoice);
f = (0:N-1)*(fs/N);


% step4 dividing the male and female frequnacy ranges
male_range = [85, 180];
female_range = [165, 255];


% step 5 Calculating the power spectrum density
PSD = abs(Y).^2 / N;


% step 6 Find the frequencies within the male and female ranges
within_malerange = find(f >= male_range(1) & f <= male_range(2));
within_femalerange = find(f >= female_range(1) & f <= female_range(2));


% step 7 Calculating the total amount of power within the male and female
% frequnacy ranges
male_totalpower = sum(PSD(within_malerange));
female_totalpower = sum(PSD(within_femalerange));


% step 8 assigning the gender using the total power calculated
if male_totalpower > female_totalpower
gender = 'The speaker is Male';
else
gender = 'The speaker is Female';
end


% step 9 Ploting the frequency spectrum which we found in step 3
subplot(2,1,1);
plot(f, abs(Y));
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;


% step 10 Ploting the power spectrum density which we found in step 5
subplot(2,1,2);
plot(f, PSD);
title('Power Spectrum Density');
xlabel('Frequency (Hz)');
ylabel('Power');
grid on;


% step 11 ploting male and female frequency ranges with diffrent colour
hold on;
plot(f(within_malerange), PSD(within_malerange), 'r', 'LineWidth', 2);
plot(f(within_femalerange), PSD(within_femalerange), 'g', 'LineWidth', 2);
legend('PSD', 'Male Voice Range', 'Female Voice Range');
hold off;


% Display the detected gender
disp(['recognised gender of the speaker is: ' gender]);