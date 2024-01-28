function [frames_RMS,mean_RMS] = rms_extraction(x_frame)

    [~,col] = size(x_frame);
    for i = 1:col
        temp = x_frame{i};
        [r,~] = size(temp);
        x_RMS = temp;
        x_RMS = sqrt((1/r)*sum(x_RMS.^2)); % Getting RMS per frame
        frames_RMS(:,i) = x_RMS;
        mean_RMS(:,i) = mean(x_RMS./max(x_RMS)); % Normalization
    end

end