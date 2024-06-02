function user_information = construct_user_information(id, message, bandwidth, spreading_factor, power, center_frequency, signal)
    user_information.id = id;
    user_information.center_frequency = center_frequency;
    user_information.message = message;
    user_information.bandwidth = bandwidth;
    user_information.spreading_factor = spreading_factor;
    user_information.power = power;
    user_information.signal = signal;
    user_information.is_present = true;
end

