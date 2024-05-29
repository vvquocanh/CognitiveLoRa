function [environment_signal, secondary_users] = generate_colored_noise(environment_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    center_frequency = input("Enter noise center frequency (kHz): ");
    center_frequency = center_frequency * 1000;
    bandwidth = input("Enter noise bandwidth (kHz): ");
    bandwidth = bandwidth * 1000;

    noise = randn(1, length(environment_signal));
    noise_fft = fft(noise);
    N = length(noise_fft);

    frequency = linspace(0, sampling_frequency/2, N/2+1);
    mask = zeros(size(noise_fft));
    mask(frequency > center_frequency-bandwidth/2 & frequency < center_frequency+bandwidth/2) = 1;

    noise_filtered = real(ifft(mask.*noise_fft));
    environment_signal = sum_signal(environment_signal, noise_filtered');

    [environment_signal, secondary_users] = secondary_users_move(environment_signal, sampling_frequency, secondary_users, threshold);
end

