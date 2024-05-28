function [environment_signal, user_information, secondary_users] = create_primary_user(environment_signal, sampling_frequency, secondary_users, threshold)
    [id, bandwidth, power] = get_basic_signal_input();

    center_frequency = input("Enter signal center frequency (kHZ): ");
    center_frequency = center_frequency * 1000;
    
    message = "Hello World!";
    spreading_factor = 7;

    lora_signal = LoRa_Tx(message, bandwidth, spreading_factor, power, sampling_frequency, center_frequency);
    
    [environment_signal, secondary_users] = primary_user_enter(environment_signal, lora_signal, sampling_frequency, secondary_users, threshold);
    
    power = 10*log10(rms(lora_signal).^2);
    user_information = construct_user_information(id, message, bandwidth, spreading_factor, power, center_frequency, lora_signal);
end


