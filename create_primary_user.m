function [user_information, amplitude_modulated_signal] = create_primary_user(signal_length, sampling_frequency)
    [id, bandwidth, power] = get_user_input();

    center_frequency = input("Enter signal center frequency (kHZ): ");
    center_frequency = center_frequency * 1000;
    
    lora_signal = create_lora_signal(signal_length, bandwidth, power, sampling_frequency);
    
    if isempty(lora_signal)
        amplitude_modulated_signal = [];
    else
        amplitude_modulated_signal = ammod(real(lora_signal), center_frequency, sampling_frequency);
    end

    user_information = construct_user_information(id, bandwidth, power, center_frequency, amplitude_modulated_signal);
end

