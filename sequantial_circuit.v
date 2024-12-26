module AuthorizationSystem(
    input wire clk,         
    input wire reset,       
    input wire [3:0] code,  
    input wire validate,    
    output reg auth_status  
);

    parameter CORRECT_CODE = 4'b1010; 

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            auth_status <= 0; 
        end else if (validate) begin
            auth_status <= (code == CORRECT_CODE); 
        end
    end

endmodule

module GeneralManagement(
    input wire clk,
    input wire reset,
    input wire [2:0] control_signals, 
    output reg [2:0] module_status    
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            module_status <= 3'b000; 
        end else begin
            module_status <= control_signals; 
        end
    end

endmodule


module LightingControl(
    input wire clk,
    input wire reset,
    input wire light_on,
    input wire light_dim,
    output reg [1:0] state 
);

    parameter OFF = 2'b00, DIM = 2'b01, ON = 2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= OFF;
        else begin
            case (state)
                OFF: if (light_on) state <= ON; else if (light_dim) state <= DIM;
                DIM: if (light_on) state <= ON; else if (!light_dim) state <= OFF;
                ON: if (!light_on) state <= OFF;
            endcase
        end
    end

endmodule

module WhiteGoodsControl(
    input wire clk,
    input wire reset,
    input wire start_washer,
    input wire start_dishwasher,
    output reg washer_status,
    output reg dishwasher_status
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            washer_status <= 0;
            dishwasher_status <= 0;
        end else begin
            washer_status <= start_washer;
            dishwasher_status <= start_dishwasher;
        end
    end

endmodule


module ClimateControl(
    input wire clk,
    input wire reset,
    input wire [7:0] temperature, 
    input wire [7:0] humidity,    
    output reg heater_on,         
    output reg cooler_on          
);

    parameter TEMP_HIGH = 8'd25; // Sıcaklık eşik değerleri
    parameter TEMP_LOW = 8'd18;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            heater_on <= 0;
            cooler_on <= 0;
        end else begin
            if (temperature > TEMP_HIGH)
                cooler_on <= 1;
            else
                cooler_on <= 0;

            if (temperature < TEMP_LOW)
                heater_on <= 1;
            else
                heater_on <= 0;
        end
    end

endmodule


module SafetySystem(
    input wire clk,
    input wire reset,
    input wire motion_detected,
    input wire smoke_detected,
    output reg alarm
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            alarm <= 0;
        else if (motion_detected || smoke_detected)
            alarm <= 1; 
        else
            alarm <= 0; 
    end

endmodule


