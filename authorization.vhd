 Authorization System
  module authorization_system(
    input [7:0] username,       
    input [7:0] password,       
    output reg authorized       
);
    // Sabit kullanıcı adı ve şifre belirleyelim
    parameter [7:0] USERNAME = 8'h55;  
    parameter [7:0] PASSWORD = 8'hAA;  
    // Yetkilendirme işlemi
    always @(*) begin
        if (username == USERNAME && password == PASSWORD)
            authorized = 1'b1;  
        else
            authorized = 1'b0;  
    end
endmodule
## General Managament System
      module general_management_system(
    input [7:0] user_id,             
    input [1:0] role,                
    input [1:0] operation,           
    output reg access_granted,       
    output reg operation_success     
);
    // Önceden tanımlanmış kullanıcı kimliği ve rolleri
    parameter [7:0] VALID_USER_ID = 8'hA5; 
    parameter [1:0] USER = 2'b00;
    parameter [1:0] ADMIN = 2'b01;
    parameter [1:0] SUPERVISOR = 2'b10;
    
    always @(*) begin
       
        access_granted = 1'b0;
        operation_success = 1'b0;
        
        if (user_id == VALID_USER_ID) begin
            access_granted = 1'b1;  
            case (role)
                USER: begin
                    if (operation == 2'b00)
                        operation_success = 1'b1;  
                end
                ADMIN: begin
                    if (operation == 2'b00 || operation == 2'b01)
                        operation_success = 1'b1;  
                end
                SUPERVISOR: begin
                    operation_success = 1'b1;  
                end
                default: begin
                    operation_success = 1'b0;
                end
            endcase
        end
    end
endmodule
      ## Smart Lighting System
      module smart_lighting_system(
    input light_sensor,            
    input motion_sensor,           
    input manual_switch,           
    input [3:0] hour,              
    output reg light               
);
    parameter NIGHT_START = 4'd18; 
    parameter NIGHT_END = 4'd6;    
    always @(*) begin
        if (manual_switch) begin
            light = 1'b1;
        end
        else if (light_sensor) begin
            if (motion_sensor) begin
                light = 1'b1;
            end
            else if ((hour >= NIGHT_START) || (hour < NIGHT_END)) begin
                light = 1'b1;
            end
            else begin
                light = 1'b0;
            end
        end
        else begin
            light = 1'b0;
        end
    end
endmodule
      ## White Goods Control
      module white_goods_control(
    input manual_laundry,           
    input manual_dishwasher,        
    input manual_oven,              
    input [3:0] hour,               
    output reg laundry_on,          
    output reg dishwasher_on,       
    output reg oven_on              
);
    parameter LAUNDRY_AUTO_START = 4'10d;     
    parameter DISHWASHER_AUTO_START = 4'd20; 
    parameter OVEN_AUTO_START = 4'd17;       
    always @(*) begin
        if (manual_laundry || (hour == LAUNDRY_AUTO_START)) begin
            laundry_on = 1'b1;  
        end else begin
            laundry_on = 1'b0;  
        end
        if (manual_dishwasher || (hour == DISHWASHER_AUTO_START)) begin
            dishwasher_on = 1'b1;  
        end else begin
            dishwasher_on = 1'b0;  
        end
        if (manual_oven || (hour == OVEN_AUTO_START)) begin
            oven_on = 1'b1;    
        end else begin
            oven_on = 1'b0; 
        end
    end
endmodule
      module CurtainWindowDoorControl (
    input wire curtain_open,
    input wire window_open,
    input wire door_open,
    output wire curtain_status,
    output wire window_status,
    output wire door_status
);
    assign curtain_status = curtain_open;
    assign window_status = window_open;
    assign door_status = door_open;
endmodule

          module ClimateControl (
    input wire ac_on,
    input wire [1:0] ac_mode,
    input wire heater_on,
    input wire [1:0] heater_mode,
    output wire ac_status,
    output wire [1:0] current_ac_mode,
    output wire heater_status,
    output wire [1:0] current_heater_mode
);
    assign ac_status = ac_on;
    assign current_ac_mode = ac_mode;
    assign heater_status = heater_on;
    assign current_heater_mode = heater_mode;
endmodule


          module SafetySystem (
    input wire fire_detected,
    input wire burglar_detected,
    input wire activate_fire_extinguisher,
    input wire lock_door,
    output wire fire_alarm,
    output wire burglar_alarm,
    output wire fire_extinguisher_status,
    output wire door_locked
);
    assign fire_alarm = fire_detected;
    assign burglar_alarm = burglar_detected;
    assign fire_extinguisher_status = activate_fire_extinguisher;
    assign door_locked = lock_door;
endmodule


              always(motion_sensor or arm_system) begin
                if (arm_system && motion_sensor) begin
                  alarm <= 1;        
                end else begin
                  alarm <= 0;       
                  end
          end

    endmodule 
            
                   
