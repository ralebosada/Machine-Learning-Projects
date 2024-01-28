function data_extraction(audio_length,folder_name,fs)

    %% INPUT
    
    % Audio length - length of audio in seconds
    % Folder name - name of folder containing the data (Note: Folder must contain
    % only datas)
    % Fs - Sampling Frequency in Hz
    
    %% Output
    
    % .MAT file of all the audio files
    
    %% Implementation
    
    project = pwd; % Getting the present working directory
    data = fullfile(project,folder_name); % Getting the directory of audio signals
    path = dir(data); % Getting the files and folders of Audio Signals
    files = {path.name}; % Getting the file names of Audio Signals
    counter = 1; % Setting up counter
    for i = 3:length(files) % Assume GTZAN dataset with no other files in the data
        temporary = fullfile(data,files{i}); % Directory of audio signals
        temp_path = dir(temporary);
        cd (temporary);
        temp_files = {temp_path.name};
        for j = 3:length(temp_files)
            [x,~] = audioread(temp_files{j}); % Reading audio files
            t_final = audio_length*fs; 
            if t_final < length(x)
                x = x(1:t_final); % Getting only audio files with desired length
            else
                disp("Error: Invalid audio length");
            end
            audio_data(:,counter) = x;
            counter = counter+1;
        end
    end
    cd (project); % Returning to present working directory
    save('audio_data','-v7.3','audio_data');

end