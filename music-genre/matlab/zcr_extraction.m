function [frames_ZCR,mean_ZCR] = zcr_extraction(x_frame)
    
    %% INPUT
    
    % x_framed - cell of all framed audio signals
    
    %% OUTPUT
    
    % features_ZCR - ZCR per frame per audio signal
    % mean_ZCR - average ZCR per audio signal
    
    %% IMPLEMENTATION
    
    [~,col] = size(x_frame); % Getting size of dataset with audio signals
    for i = 1:col 
        temp = x_frame{i}; % Storing framed audio signal into temporary variable
        [r,c] = size(temp); % Getting dimension of audio signal
        x_ZCR = temp*(2*r).^-1; % Multiplying by 1/2N window
        sgn1 = ones(r,c); % Setting matrix of 1's
        % Obtaining Zero Crossing Rate 
        sgn1(x_ZCR<0) = -1;
        sgn2 = zeros(r,c);
        sgn2(2:end,:) = sgn1(1:end-1,:);
        x_ZCR = sgn2-sgn1;
        x_ZCR = x_ZCR(2:end,:);
        x_ZCR = sum(abs(x_ZCR));
        frames_ZCR(:,i) = x_ZCR; % Storing ZCR per frame
        mean_ZCR(:,i) = mean(x_ZCR./max(x_ZCR)); % Getting the mean of normalized zero crossing rate per audio
    end
    
end