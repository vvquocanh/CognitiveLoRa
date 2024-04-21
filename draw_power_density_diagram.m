function draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title)
    [pxx, frequencies] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
    
    figure;
    plot(frequencies, 10*log10(pxx));
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    title(figure_title);
    grid on;
end
