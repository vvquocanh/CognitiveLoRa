clear;
clc;
close all;

disp("LoRa - Cognitive Radio simulation.");

% FREQUENCY SPECTRUM
frequency_spectrum_range = input("\nEnter the frequency spectrum range (kHz): ");
sampling_frequency = frequency_spectrum_range * 1000;

% USERS
primary_users = [];
secondary_users = [];

% ENVIRONMENT SIGNAL
environment_signal = [0; 0];

% COGNITIVE RADIO
power_threshold = -60;

%COMMAND HANDLER
while true
    command = input("\nEnter command: ", "s");
    switch command
        case "exit"
            break;
        case "help"
            disp("'create_primary': create a primary user.");
            disp("'remove_primary': remove a primary user.");
            disp("'primary_enter': the primary user appears.");
            disp("'primary_leave': the primary user disappears.");
            disp("'get_primary': print the information of all of the primary users.");
            disp("'create_secondary': create a secondary user.");
            disp("'remove_secondary': remove a secondary user.");
            disp("'secondary_enter': the secondary user appears.");
            disp("'secondary_leave': the secondary user disappears.");
            disp("'draw_power_diagram_total': draw the total power spectral density diagram.");
            disp("'draw_power_diagram_seperately': draw the seperate power spectral density diagram.");
            disp("'get_power_threshold': get the current power threshold for cognitive radio sensing.");
            disp("'modify_power_threshold': modify the power threshold for cognitive radio sensing.");
            disp("'add_noise': add the white Gaussian noise.")
            disp("'exit': exit the program.");
        case "create_primary"
            [environment_signal, user_information, secondary_users] = create_primary_user(environment_signal, sampling_frequency, secondary_users, power_threshold);
            
            primary_users = [primary_users; user_information];
            figure_title = interpolate_string("Create primary user {user_information.id}");
            draw_power_density_diagram(environment_signal, sampling_frequency, figure_title);
        case "remove_primary"
            index = get_index(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                if primary_users(index).is_present == true
                    environment_signal = sum_signal(environment_signal, primary_users(index).signal, true);
                end
                figure_title = interpolate_string("Remove primary user {primary_users(index).id}");
                draw_power_density_diagram(environment_signal, sampling_frequency, figure_title);
                primary_users(index) = [];
            end
        case "primary_enter"
            index = get_index(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                if primary_users(index).is_present == false
                    [environment_signal, secondary_users] = primary_user_enter(environment_signal, primary_users(index).signal, sampling_frequency, secondary_users, power_threshold);
                    primary_users(index).is_present = true;
                    figure_title = interpolate_string("Primary user {primary_users(index).id} enter");
                    draw_power_density_diagram(environment_signal, sampling_frequency, figure_title);
                else
                    disp("Primary user is already present.");
                end
            end
        case "primary_leave"
            index = get_index(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                if primary_users(index).is_present == true
                    environment_signal = sum_signal(environment_signal, primary_users(index).signal, true);
                    primary_users(index).is_present = false;
                    figure_title = interpolate_string("Primary user {primary_users(index).id} leave");
                    draw_power_density_diagram(environment_signal, sampling_frequency, figure_title);
                else
                    disp("Primary user is already not present.");
                end
            end
        case "get_primary"
            for i = 1 : length(primary_users)
                disp(primary_users(i));
            end
        case "create_secondary"
            [environment_signal, user_information] = create_secondary_user(environment_signal, sampling_frequency, power_threshold);
            secondary_users = [secondary_users; user_information];
            figure_title = interpolate_string("Create secondary user {user_information.id}");
            draw_power_density_diagram(environment_signal, sampling_frequency, figure_title);
        % case "remove_secondary"
        %     user_index = get_index_by_input(secondary_users);
        %     if user_index == -1
        %         disp("There is no secondary user with such id.");
        %     else
        %         sensing_data_index = get_proper_index(secondary_users(index).id, secondary_users_sensing_data);
        %         if secondary_users(user_index).is_present == true
        %             amplitude_modulated_signal = amplitude_modulated_signal - secondary_users(user_index).amplitude_modulated_signal;
        %         end
        %         figure_title = interpolate_string("Remove primary user {primary_users(user_index).id}");
        %         draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
        %         secondary_users(user_index) = [];
        %         secondary_users_sensing_data(sensing_data_index) = [];
        %     end
        % case "secondary_enter"
        %     user_index = get_index_by_input(secondary_users);
        %     if user_index == -1
        %         disp("There is no secondary user with such id.");
        %     else
        %         sensing_data_index = get_proper_index(secondary_users(user_index).id, secondary_users_sensing_data);
        %         if secondary_users(user_index).is_present == false
        %             [amplitude_modulated_signal, new_amplitude_modulated_signal, center_frequency, beginning_index, last_index] = secondary_user_enter(amplitude_modulated_signal, signal_length, secondary_users_sensing_data(sensing_data_index).lora_signal, secondary_users(user_index).bandwidth, sampling_frequency, power_threshold); 
        %             secondary_users_sensing_data(sensing_data_index).beginning_index = beginning_index;
        %             secondary_users_sensing_data(sensing_data_index).last_index = last_index;
        %             secondary_users(user_index).center_frequency = center_frequency;
        %             secondary_users(user_index).amplitude_modulated_signal = new_amplitude_modulated_signal;
        %             secondary_users(user_index).is_present = true;
        %             figure_title = interpolate_string("Secondary user {secondary_users(user_index).id} enter.");
        %             draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
        %         else
        %             disp("Secondary user is already present.");
        %         end
        %     end
        % case "secondary_leave"
        %     user_index = get_index_by_input(secondary_users);
        %     if user_index == -1
        %         disp("There is no secondary user with such id.");
        %     else
        %         if secondary_users(user_index).is_present == true
        %             amplitude_modulated_signal = amplitude_modulated_signal - secondary_users(user_index).amplitude_modulated_signal;
        %             secondary_users(user_index).is_present = false;
        %             figure_title = interpolate_string("Secondary user {secondary_users(user_index).id} leave.");
        %             draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
        %         else
        %             disp("Secondary user is already not present.");
        %         end
        %     end
        % case "get_secondary"
        %     for i = 1 : length(secondary_users)
        %         disp(secondary_users(i));
        %     end
        case "draw_power_diagram_total"   
            figure_title = interpolate_string("Total power spectral density");
            draw_power_density_diagram(environment_signal, sampling_frequency, figure_title);
        case "draw_power_diagram_seperately"
            figure_title = interpolate_string("Seperate power spectral density");
            draw_power_density_diagram_seperate(primary_users, secondary_users, sampling_frequency, figure_title);
        case "get_power_threshold"
            disp(interpolate_string("Threshold: {power_threshold} (dBm)"));
        case "modify_power_threshold"
            power_threshold = input("Input new power threshold (dBm): ");
        % case "add_noise"
        %     [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = generate_colored_noise(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, power_threshold);
        %     figure_title = interpolate_string("Total power spectral density");
        %     draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
        % otherwise
        %     disp("Command not found.");
    end
end

% FUNCTION

function index = get_index(users)
    id = input("Enter user id: ", "s");

    index = -1;
    for i = 1 : length(users)
        if users(i).id == id
            index = i;
        end
    end
end