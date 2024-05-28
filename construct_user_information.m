function user_information = construct_user_information(id, bandwidth, power, center_frequency, signal)
    user_information.id = id;
    user_information.bandwidth = bandwidth;
    user_information.center_frequency = center_frequency;
    user_information.power = power;
    user_information.signal = signal;
    user_information.is_present = true;
end

