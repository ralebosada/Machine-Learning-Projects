function [frames_STE,mean_STE] = ste_extraction(x_window)
    
    [~,col] = size(x_window);
    for i = 1:col
        temp = x_window{i};
        x_STE = temp;
        x_STE = sum(x_STE.^2); % Getting Short Time Energy per frame
        frames_STE(:,i) = x_STE;
        mean_STE(:,i) = mean(x_STE./max(x_STE)); % Getting mean of normalized STE per audio
    end
    
end