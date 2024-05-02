function amplitude_modulated_signal = generate_colored_noise(amplitude_modulated_signal, signal_length, sampling_frequency)
    center_frequency = input("Enter noise center frequency (kHz): ");
    center_frequency = center_frequency * 1000;
    bandwidth = input("Enter noise bandwidth (kHz): ");
    bandwidth = bandwidth * 1000;
    
    noise = randn(1, signal_length);
    noise_fft = fft(noise);
    N = length(noise_fft);

    % Create frequency mask (attenuate outside bandwidth)
    f = linspace(0, sampling_frequency/2, N/2+1);
    mask = zeros(size(noise_fft));
    mask(f > center_frequency-bandwidth/2 & f < center_frequency+bandwidth/2) = 1;
    
    % Apply mask and perform inverse FFT
    noise_filtered = real(ifft(mask.*noise_fft));
    %disp(noise);
    amplitude_modulated_signal = amplitude_modulated_signal + noise_filtered;
end

