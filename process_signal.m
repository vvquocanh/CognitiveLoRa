function amplitude_modulated_signal = process_signal(amplitude_modulated_signal, new_amplitude_modulated_signal, sampling_frequency, is_remove)
    if is_remove
        amplitude_modulated_signal = amplitude_modulated_signal - new_amplitude_modulated_signal;
        [pxx, frequencies] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
        draw_power_density_diagram(pxx, frequencies, "Power spectral density");
    else
        [pxx_old, frequencies_old] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
        [pxx_new, frequencies_new] = periodogram(new_amplitude_modulated_signal, [], [], sampling_frequency);
        draw_power_density_diagram([pxx_old, pxx_new], [frequencies_old, frequencies_new], "Seperate power spectral density");
        
        amplitude_modulated_signal = amplitude_modulated_signal + new_amplitude_modulated_signal;
        [pxx, frequencies] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
        draw_power_density_diagram(pxx, frequencies, "Combination power spectral density");
    end
end

