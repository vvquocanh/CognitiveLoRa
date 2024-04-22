function amplitude_modulated_signal = amplitude_modulated_signal_process(amplitude_modulated_signal)
    if ~all(amplitude_modulated_signal == 0)
        idx = find(amplitude_modulated_signal ~= 0, 1, 'last');
        amplitude_modulated_signal = amplitude_modulated_signal(1:idx);

    end
end
