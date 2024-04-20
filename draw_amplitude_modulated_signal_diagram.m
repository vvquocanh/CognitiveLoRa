function draw_amplitude_modulated_signal_diagram(pxx, sampling_frequency, figure_title)
    figure;
    HPSD = dspdata.psd(pxx,'Fs',sampling_frequency);
    plot(HPSD);
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    title(figure_title);
    grid on;
end
