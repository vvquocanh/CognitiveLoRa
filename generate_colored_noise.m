function [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = generate_colored_noise(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    center_frequency = input("Enter noise center frequency (kHz): ");
    center_frequency = center_frequency * 1000;
    bandwidth = input("Enter noise bandwidth (kHz): ");
    bandwidth = bandwidth * 1000;

    noise = randn(1, signal_length);
    noise_fft = fft(noise);
    N = length(noise_fft);

    frequency = linspace(0, sampling_frequency/2, N/2+1);
    mask = zeros(size(noise_fft));
    mask(frequency > center_frequency-bandwidth/2 & frequency < center_frequency+bandwidth/2) = 1;

    noise_filtered = real(ifft(mask.*noise_fft));
    amplitude_modulated_signal = amplitude_modulated_signal + noise_filtered;

    [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = secondary_users_move(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold);
end

