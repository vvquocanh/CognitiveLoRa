function sensing_data = construct_sensing_data(id, lora_signal, beginning_index, last_index)
    sensing_data.id = id;
    sensing_data.lora_signal = lora_signal;
    sensing_data.beginning_index = beginning_index;
    sensing_data.last_index = last_index;
end

