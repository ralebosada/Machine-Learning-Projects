function [frames_POWER,mean_POWER] = powerspectrum_extraction(x_stfted,fs)

    [~,col] = size(x_stfted);

    for i = 1:col
        temp = x_stfted{i};
        [r,~] = size(temp);
        x_power = temp;
        x_power = x_power/(fs*r);
        x_power(2:end-1) = 2*x_power(2:end-1);
        x_power = sum(x_power);
        frames_POWER(:,i) = x_power;
        mean_POWER(:,i) = mean(x_power./max(x_power));

%         % Mel Filterbanks

%         f2m = @(f) 1125*log(1+f/700);
%         m2f = @(m) 700*(exp(m/1125)-1);
%         mel1 = f2m(f1);
%         mel2 = f2m(f2);
%         mel = linspace(mel1,mel2,M+2); % Creating 26 Filterbanks
%         f = m2f(mel);
%         fft_bin = floor(((NFFT+1)/fs).*f);
%         mel_filters = zeros(r,M);
% 
%         for j = 2:M+1
%             x1 = fft_bin(j-1);
%             x2 = fft_bin(j);
%             x3 = fft_bin(j+1);
%             y1 = 0;
%             y2 = 1;
%             y3 = 0;
%             y_1 = y1:(y2-y1)/(x2-x1):y2;
%             y_2 = y2:(y3-y2)/(x3-x2):y3;
%             mel_filters(x1:x2,j-1) = y_1;
%             mel_filters(x2:x3,j-1) = y_2;
%         end
% 
%     x_mel = mel_filters'*log(x_MFCC);
%     x_mel = dct(x_mel,coef);
%     x_mel = mean(x_mel,2);
%     features_MFCC(:,i) = x_mel;

    end
end