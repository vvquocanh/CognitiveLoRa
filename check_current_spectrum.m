function is_available = check_current_spectrum(amplitude_modulated_signal, beginning_index, last_index, threshold, sampling_frequency)
    amplitude_modulated_signal = amplitude_modulated_signal_process(amplitude_modulated_signal);
    [pxx, ~] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
    is_available = true;
    for index = beginning_index : last_index
        if 10*log10(pxx(index)) >= threshold
            is_available = false;
            return
        end
    end
end

