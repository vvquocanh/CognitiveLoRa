function draw_power_density_diagram_seperate(primary_users, secondary_users, sampling_frequency, figure_title)
    legend_list = {};
    pxx_list = [];
    frequencies_list = [];
    
    for index = 1 : length(primary_users)
        if primary_users(index).is_present == false
            continue;
        end
        [pxx, frequencies] = periodogram(primary_users(index).lora_signal, [], [], sampling_frequency);
        pxx_list = [pxx_list, pxx];
        frequencies_list = [frequencies_list, frequencies];
        legend_list{end + 1} = interpolate_string("Primary {primary_users(index).id}");
    end
    
    for index = 1 : length(secondary_users)
        if secondary_users(index).is_present == false
            continue;
        end
        [pxx, frequencies] = periodogram(secondary_users(index).lora_signal, [], [], sampling_frequency);
        pxx_list = [pxx_list, pxx];
        frequencies_list = [frequencies_list, frequencies];
        legend_list{end + 1} = interpolate_string("Secondary {secondary_users(index).id}");
    end

    figure;
    plot(frequencies_list, 10*log10(pxx_list));
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    title(figure_title);
    legend(legend_list);
    grid on;
end

