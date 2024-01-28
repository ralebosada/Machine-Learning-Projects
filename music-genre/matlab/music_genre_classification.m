%% EE 286 FINAL PROJECT: MUSIC GENRE CLASSIFICATOR

% NAME: RAVTOR A. LEBOSADA
% STUDENT NUMBER: 2013-09397

%% INTRODUCTION

% GTZAN dataset was used, consists of 1000 audio tracks, 100 for each 
% genre with 30 seconds long each track.
% Jazz genre was removed since audio files in this genre are corrupted
% Mainly divided into Data Extraction, Feature Extraction, and
% Classification
% Data Extraction - extracts audio signals from wav file to matlab
% Feature Extraction - obtains audio features and use as variables/inputs
% to classifier
% Classification - classifies music genre from audio features
% For classifier, Multilayer Perceptron Neural Networks are used. 
% Not fully optimized but tried to make its performance close to the
% references

%% RESETTING

clear;
close all;
clc;

%% DATA EXTRACTION

%% VARIABLES INITIALIZATION FOR DATA EXTRACTION

total_audio = 25; % total length of audio to be extracted
audio_length = 5; % 5 seconds to be observed
folder_name = "Data"; % Folder name of all the audio signals
fs = 22000; % Sampling Frequency in Hz

%% DATA EXTRACTION AND STORING TO .MAT FILE

% data_extraction(total_audio,folder_name,fs);

%% LOADING .MAT FILE

load audio_data.mat;
audio_data = reshape(audio_data,audio_length*fs,[]); % Clipping to 5 seconds per audio
[~,N] = size(audio_data);

%% PLOTTING AUDIO FILES

t = 0:1/fs:audio_length-1/fs;

figure(1)
plot(t,audio_data(:,1));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Blues)');

figure(2)
plot(t,audio_data(:,101));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Classical)');

figure(3)
plot(t,audio_data(:,201));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Country)');

figure(4)
plot(t,audio_data(:,301));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Disco)');

figure(5)
plot(t,audio_data(:,401));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Hip Hop)');

figure(6)
plot(t,audio_data(:,501));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Metal)');

figure(7)
plot(t,audio_data(:,601));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Pop)');

figure(8)
plot(t,audio_data(:,701));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Reggae)');

figure(9)
plot(t,audio_data(:,801));
xlabel('Time (s)');
ylabel('Amplitude');
title('Plot of Audio Signal (Rock)');

%% LABELING AUDIO DATA

% 1 - Blues
% 2 - Classical
% 3 - Country
% 4 - Disco
% 5 - Hiphop
% 6 - Metal
% 7 - Pop
% 8 - Reggae
% 9 - Rock

label_audio = [ones(1,N/9),2*ones(1,N/9),3*ones(1,N/9),4*ones(1,N/9),5*ones(1,N/9),6*ones(1,N/9),7*ones(1,N/9),8*ones(1,N/9),9*ones(1,N/9)];

%% FEATURE EXTRACTION


%% VARIABLES INITIALIZATION FOR FEATURE EXTRACTION

frame_duration = 30e-3; % 30 milliseconds frame
step_duration = 15e-3; % 15 milliseconds frame
fs = 22000; % Sampling Frequency in Hz

%% FRAMING, WINDOWING, AND FAST FOURIER TRANSFORM OF AUDIO SIGNAL

[x_frame,x_window,x_stft,NFFT] = audio_framing_windowing_fft(audio_data,audio_length,fs,frame_duration,step_duration);

% HAMMING
% x_stft - magnitude response

%% GETTING ZERO CROSSING RATE OF AUDIO SIGNAL

[frames_zcr,mean_zcr] = zcr_extraction(x_frame);

%% PLOTTING OF ZERO CROSSING RATE OF DIFFERENT GENRE OF AUDIO SIGNAL

x_temp = frames_zcr;
[row,~] = size(x_temp);
t = 0:frame_duration/row:frame_duration;
t = t(1:row)';

figure(1)
plot(t,x_temp(:,1));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Blues)');

figure(2)
plot(t,x_temp(:,101));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Classical)');

figure(3)
plot(t,x_temp(:,201));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Country)');

figure(4)
plot(t,x_temp(:,301));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Disco)');

figure(5)
plot(t,x_temp(:,401));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Hip Hop)');

figure(6)
plot(t,x_temp(:,501));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Metal)');

figure(7)
plot(t,x_temp(:,601));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Pop)');

figure(8)
plot(t,x_temp(:,701));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Reggae)');

figure(9)
plot(t,x_temp(:,801));
xlabel('Time (s)');
ylabel('ZCR');
title('Plot of Zero Crossing Rate of Framed Audio Signal (Rock)');

%% GETTING SHORT TIME ENERGY OF AUDIO SIGNAL

[frames_ste,mean_ste] = ste_extraction(x_window);

%% PLOTTING OF SHORT TIME ENERGY OF DIFFERENT GENRE OF AUDIO SIGNAL

x_temp = frames_ste;
[row,~] = size(x_temp);
t = 0:frame_duration/row:frame_duration;
t = t(1:row)';

figure(1)
plot(t,x_temp(:,1));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Blues)');

figure(2)
plot(t,x_temp(:,101));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Classical)');

figure(3)
plot(t,x_temp(:,201));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Country)');

figure(4)
plot(t,x_temp(:,301));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Disco)');

figure(5)
plot(t,x_temp(:,401));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Hip Hop)');

figure(6)
plot(t,x_temp(:,501));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Metal)');

figure(7)
plot(t,x_temp(:,601));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Pop)');

figure(8)
plot(t,x_temp(:,701));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Reggae)');

figure(9)
plot(t,x_temp(:,801));
xlabel('Time (s)');
ylabel('STE');
title('Plot of Short Time Energy of Framed Audio Signal (Rock)');

%% GETTING VOLUME OF AUDIO SIGNAL

[frames_rms,mean_rms] = rms_extraction(x_frame);

%% PLOTTING VOLUME OF DIFFERENT GENRE OF AUDIO SIGNAL

x_temp = frames_rms;
[row,~] = size(x_temp);
t = 0:frame_duration/row:frame_duration;
t = t(1:row)';

figure(1)
plot(t,x_temp(:,1));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Blues)');

figure(2)
plot(t,x_temp(:,101));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Classical)');

figure(3)
plot(t,x_temp(:,201));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Country)');

figure(4)
plot(t,x_temp(:,301));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Disco)');

figure(5)
plot(t,x_temp(:,401));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Hip Hop)');

figure(6)
plot(t,x_temp(:,501));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Metal)');

figure(7)
plot(t,x_temp(:,601));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Pop)');

figure(8)
plot(t,x_temp(:,701));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Reggae)');

figure(9)
plot(t,x_temp(:,801));
xlabel('Time (s)');
ylabel('RMS');
title('Plot of RMS of Framed Audio Signal (Rock)');

%% GETTING POWER SPECTRUM OF AUDIO SIGNAL

[frames_power,mean_power] = powerspectrum_extraction(x_stft,fs);

%% PLOTTING POWER SPECTRUM OF DIFFERENT GENRE OFO AUDIO SIGNAL

x_temp = frames_power;
[row,~] = size(x_temp);
t = 0:frame_duration/row:frame_duration;
t = t(1:row)';

figure(1)
plot(t,x_temp(:,1));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Blues)');

figure(2)
plot(t,x_temp(:,101));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Classical)');

figure(3)
plot(t,x_temp(:,201));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Country)');

figure(4)
plot(t,x_temp(:,301));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Disco)');

figure(5)
plot(t,x_temp(:,401));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Hip Hop)');

figure(6)
plot(t,x_temp(:,501));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Metal)');

figure(7)
plot(t,x_temp(:,601));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Pop)');

figure(8)
plot(t,x_temp(:,701));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Reggae)');

figure(9)
plot(t,x_temp(:,801));
xlabel('Time (s)');
ylabel('Power');
title('Plot of Power of Framed Audio Signal (Rock)');

%% OTHER FEATURES THAT CAN BE OBTAINED IN AUDIO SIGNAL (MATLAB MACHINE LEARNING AND DEEP LEARNING FOR AUDIO)

for i = 1:N

    [coeffs,delta,deltaDelta] = mfcc(audio_data(:,i),fs);
    matlab_coeffs(:,i) = mean(coeffs)';
    matlab_delta(:,i) = mean(delta)';
    matlab_deltaDelta(:,i) = mean(deltaDelta)';
    matlab_harmonic_ratio(:,i) = mean(harmonicRatio(audio_data(:,i),fs));
    matlab_spectral_entropy(:,i) = mean(spectralEntropy(audio_data(:,i),fs));
    
end
 
% NOTE: If, you do not have MACHINE LEARNING AND DEEP LEARNING FOR AUDIO
% TOOLBOX, utilize the extractedd features of GTZAN dataset

%% CLASSIFICATION


%% PARTITIONING DATA INTO TRAINING AND TESTING (70%-30%)

    idx = randperm(N); % Random generation of integers from 1-900
    training_idx = idx(1:N*.7); % Getting indices for training dataset
    testing_idx = idx(N*.7+1:end); % Getting indices for testing dataset
    audio_data = audio_data(:,idx); % Shuffling data
    training_audio = audio_data(:,training_idx); % Setting training dataset
    training_label = label_audio(training_idx); % Getting the training labels
    testing_audio = audio_data(:,testing_idx); % Setting testing dataset
    testing_label = label_audio(testing_idx); % Getting the testing labels

    input = [mean_zcr;mean_ste;mean_rms;mean_power;matlab_coeffs;matlab_delta;matlab_deltaDelta;matlab_harmonic_ratio;matlab_spectral_entropy];
    training_input = input(:,training_idx); % Getting the training input features
    testing_input = input(:,testing_idx); % Getting the testing input features
    output = zeros(9,N); % Setting up for the matrix
    for i = 1:N
        output(label_audio(i),i) = 1;
    end
    training_output = output(:,training_idx);
    testing_output = output(:,testing_idx);

    hidden = [150,150,150,150];
    LR = 1e-1;
    epoch = 5000;
    [weights,bias] = parameter_initialization(input,hidden,output);
    [weights,bias,loss_train,prediction_train,loss_test,prediction_test,accuracy_training,accuracy_testing] = trainNN(training_input,training_output,testing_input,testing_output,LR,epoch,weights,bias,training_label,testing_label);

% plot(accuracy_training);
% hold on;
% plot(accuracy_testing);

    final_training = max(accuracy_training);
    final_testing = max(accuracy_testing);



% final_testing = final_testing';
% final_training = final_training';

%% RECOMMENDATIONS

% 1.) More data
% Solution: Augment
% 2.) Extract more features