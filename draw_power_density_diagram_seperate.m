function draw_power_density_diagram_seperate(primary_users, secondary_users, sampling_frequency, figure_title)
    legend_list = {};
    pxx_list = [];
    frequencies_list = [];
    
    max_length = max(find_max_length(primary_users), find_max_length(secondary_users));
    
    [pxx_list, frequencies_list, legend_list] = get_pxx_frequencies(pxx_list, frequencies_list, legend_list, sampling_frequency, max_length, primary_users, "Primary {users(index).id}");
    [pxx_list, frequencies_list, legend_list] = get_pxx_frequencies(pxx_list, frequencies_list, legend_list, sampling_frequency, max_length, secondary_users, "Secondary {users(index).id}");

    figure;
    plot(frequencies_list, 10*log10(pxx_list));
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    title(figure_title);
    legend(legend_list);
    grid on;
end

function max_length = find_max_length(users)
    max_length = 0;
    for index = 1 : length(users)
        signal_length = length(users(index).signal);
        if signal_length > max_length
            max_length = signal_length;
        end
    end
end

function [pxx_list, frequencies_list, legend_list] = get_pxx_frequencies(pxx_list, frequencies_list, legend_list, sampling_frequency, max_length, users, users_title)
     for index = 1 : length(users)
        if users(index).is_present == false
            continue;
        end
        signal = [users(index).signal; zeros(max_length - length(users(index).signal), 1)];
        [pxx, frequencies] = periodogram(signal, [], [], sampling_frequency);
        pxx_list = [pxx_list, pxx];
        frequencies_list = [frequencies_list, frequencies];
        legend_list{end + 1} = interpolate_string(users_title);
    end
end
