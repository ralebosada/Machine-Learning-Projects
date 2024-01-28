function [x_frame, x_windowed, x_stft, NFFT] = audio_framing_windowing_fft(audio_data,audio_length,fs,frame_duration,step_duration)


    %% INPUT 
    % Audio_Data - Cell of all audio signals with desired length
    % Audio Length - Length of audio signal
    % fs - Sampling Frequency of audio signals
    % Frame Duration - Length of frame in seconds
    % Step Duration - Length of step in seconds
    
    %% Output
    % x_framed - cell containing framed audio signals
    % x_windowed - cell containing framed and windowed audio signals
    % x_stfted - cell containing magnitude of frequency spectrum
    % NFFT - number of points in Fast Fourier Transform
    
    %% Implementation
    
    [~,col] = size(audio_data); % Getting the size of dataset of all audio signals
    frame_length = fs*frame_duration; % Getting length of frame in samples
    step_length = fs*step_duration; % Getting length of step in samples
    p = nextpow2(frame_length); % Getting nearest power of 2 equivalent to length of frames
    NFFT = 2^(p-1); % Getting the number of points for Fast Fourier Transform
    N2 = NFFT/2+1; % Getting length of magnitude of frequency spectrum (Positive side)
    N = audio_length*fs; % Getting total length of audio signals in samples
    K = floor((N-frame_length)/step_length)+1; % Getting number of frames per audio signal
    win = hamming(frame_length); % Getting Hamming window with equivalent length of frames
    
    for k = 1:col
        for i = 1:K
            n = (i-1)*step_length+(1:frame_length); % Getting index of audio signals per frame
            frame(:,i) = audio_data(n,k); % Storing values of audio signal into frame
            window(:,i) = frame(:,i).*win; % Applying window to frames
            x_temp = fft(window(:,i),NFFT); % Applying Fast Fourier Transform
            x_fft(:,i) = x_temp(1:N2).*conj(x_temp(1:N2)); % Getting NFFT/2+1 length of magnitude of frequency spectrum
        end
        x_frame{k} = frame; % Storing into cells
        x_windowed{k} = window; % Storing into cells
        x_stft{k} = x_fft; % Storing into cells
    end
    
end