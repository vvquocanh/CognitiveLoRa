function pxx = get_pxx(amplitude_modulated_signal, new_amplitude_modulated_signal, sampling_frequency, is_remove)
    if is_remove
        pxx = periodogram(amplitude_modulated_signal - new_amplitude_modulated_signal);
        draw_amplitude_modulated_signal_diagram(pxx, sampling_frequency, "Power spectral density");
    else
        pxx_old = periodogram(amplitude_modulated_signal);
        pxx_new = periodogram(new_amplitude_modulated_signal);
        draw_amplitude_modulated_signal_diagram([pxx_old, pxx_new], sampling_frequency, "Seperate power spectral density");

        pxx = periodogram(amplitude_modulated_signal + new_amplitude_modulated_signal);
        draw_amplitude_modulated_signal_diagram(pxx, sampling_frequency, "Combination power spectral density");
    end
end

