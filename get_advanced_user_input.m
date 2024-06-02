function [message, spreading_factor] = get_advanced_user_input()
    message = input("Enter message: ", "s");
    
    spreading_factor = input ("Enter spreading factor (7-12): ");

    if spreading_factor < 7
        spreading_factor = 7;
    elseif spreading_factor > 12
        spreading_factor = 12;
    end
end

