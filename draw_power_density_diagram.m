function draw_power_density_diagram(pxx, frequencies, figure_title)
    figure;
    plot(frequencies, 10*log10(pxx));
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    title(figure_title);
    grid on;
end
