module authorization_system(
    input [7:0] username,   
    input [7:0] password,   
    output authorized       
);

    wire username_match, password_match;


    comparator #(8) username_comparator (
        .a(username),
        .b(8'h55),         
        .eq(username_match)
    );

    comparator #(8) password_comparator (
        .a(password),
        .b(8'hAA),         
        .eq(password_match)
    );


    and_gate and1 (
        .a(username_match),
        .b(password_match),
        .y(authorized)
    );

endmodule


module comparator #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a, b,
    output eq
);
    assign eq = (a == b);
endmodule


module and_gate(
    input a, b,
    output y
);
    assign y = a & b;
endmodule

  module general_management_system(
    input [7:0] user_id,
    input [1:0] role,
    input [1:0] operation,
    output access_granted,
    output operation_success
);

    wire valid_user_id;
    wire [2:0] role_permissions; 


    comparator #(8) user_id_comparator (
        .a(user_id),
        .b(8'hA5), 
        .eq(valid_user_id)
    );


    rbac rbac_module (
        .role(role),
        .operation(operation),
        .permissions(role_permissions)
    );


    and_gate and1 (
        .a(valid_user_id),
        .b(role_permissions[0]), 
        .y(access_granted)
    );

    assign operation_success = role_permissions[operation];

endmodule


module rbac(
    input [1:0] role,
    input [1:0] operation,
    output [2:0] permissions
);
    reg [2:0] role_matrix[0:2]; 
    initial begin
        role_matrix[0] = 3'b100; 
        role_matrix[1] = 3'b110; 
        role_matrix[2] = 3'b111; 
    end

    assign permissions = role_matrix[role];
endmodule

module smart_lighting_system(
    input light_sensor,
    input motion_sensor,
    input manual_switch,
    input [3:0] hour,
    output light
);

    wire night_time, light_control, motion_or_timer;


    night_timer nt (
        .hour(hour),
        .night_time(night_time)
    );


    or_gate or1 (
        .a(motion_sensor),
        .b(night_time),
        .y(motion_or_timer)
    );


    or_gate or2 (
        .a(manual_switch),
        .b(motion_or_timer),
        .y(light_control)
    );


    and_gate and1 (
        .a(light_sensor),
        .b(light_control),
        .y(light)
    );

endmodule

module night_timer(
    input [3:0] hour,
    output night_time
);
    assign night_time = (hour >= 4'd18) || (hour < 4'd6);
endmodule


module or_gate(
    input a, b,
    output y
);
    assign y = a | b;
endmodule


module and_gate(
    input a, b,
    output y
);
    assign y = a & b;
endmodule


module white_goods_control(
    input manual_laundry,
    input manual_dishwasher,
    input manual_oven,
    input [3:0] hour,
    output laundry_on,
    output dishwasher_on,
    output oven_on
);

    wire laundry_auto, dishwasher_auto, oven_auto;


    timer laundry_timer (
        .hour(hour),
        .start_hour(4'd10), 
        .active(laundry_auto)
    );

    timer dishwasher_timer (
        .hour(hour),
        .start_hour(4'd20), 
        .active(dishwasher_auto)
    );

    timer oven_timer (
        .hour(hour),
        .start_hour(4'd17), 
        .active(oven_auto)
    );


    or_gate or1 (
        .a(manual_laundry),
        .b(laundry_auto),
        .y(laundry_on)
    );

    or_gate or2 (
        .a(manual_dishwasher),
        .b(dishwasher_auto),
        .y(dishwasher_on)
    );

    or_gate or3 (
        .a(manual_oven),
        .b(oven_auto),
        .y(oven_on)
    );

endmodule

module timer(
    input [3:0] hour,
    input [3:0] start_hour,
    output active
);
    assign active = (hour == start_hour);
endmodule




  module CurtainWindowDoorControl (
    input curtain_open,
    input window_open,
    input door_open,
    output curtain_status,
    output window_status,
    output door_status
);

    assign curtain_status = curtain_open;
    assign window_status = window_open;
    assign door_status = door_open;

endmodule


module ClimateControl (
    input ac_on,
    input [1:0] ac_mode,
    input heater_on,
    input [1:0] heater_mode,
    output ac_status,
    output [1:0] current_ac_mode,
    output heater_status,
    output [1:0] current_heater_mode
);

    assign ac_status = ac_on;
    assign current_ac_mode = ac_mode;
    assign heater_status = heater_on;
    assign current_heater_mode = heater_mode;

endmodule


  
  module SafetySystem (
    input fire_detected,
    input burglar_detected,
    input activate_fire_extinguisher,
    input lock_door,
    output fire_alarm,
    output burglar_alarm,
    output fire_extinguisher_status,
    output door_locked
);

    // Basit bağlamalar
    assign fire_alarm = fire_detected;
    assign burglar_alarm = burglar_detected;
    assign fire_extinguisher_status = activate_fire_extinguisher;
    assign door_locked = lock_door;

endmodule


  module AlarmLogic (
    input motion_sensor,
    input arm_system,
    output reg alarm
);

    always @(*) begin
        if (arm_system && motion_sensor) begin
            alarm = 1'b1; 
        end else begin
            alarm = 1'b0; 
        end
    end

endmodule

          
          
