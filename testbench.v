`timescale 1ns/1ps

module tb_AuthorizationSystem;
    reg clk;
    reg reset;
    reg [3:0] code;
    reg validate;
    wire auth_status;

    AuthorizationSystem uut (
        .clk(clk),
        .reset(reset),
        .code(code),
        .validate(validate),
        .auth_status(auth_status)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; code = 4'b0000; validate = 0;
        #10 reset = 0;

        #10 code = 4'b1010; validate = 1;
        #10 validate = 0;

        #10 code = 4'b1100; validate = 1;
        #10 validate = 0;

        #10 reset = 1;
        #10 reset = 0;

        #20 $stop;
    end
endmodule

`timescale 1ns/1ps

module tb_GeneralManagement;
    reg clk;
    reg reset;
    reg [2:0] control_signals;
    wire [2:0] module_status;

    GeneralManagement uut (
        .clk(clk),
        .reset(reset),
        .control_signals(control_signals),
        .module_status(module_status)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; control_signals = 3'b000;
        #10 reset = 0;

        #10 control_signals = 3'b101;
        #10 control_signals = 3'b111;
        #10 control_signals = 3'b000;

        #10 reset = 1;
        #10 reset = 0;

        #20 $stop;
    end
endmodule


`timescale 1ns/1ps

module tb_LightingControl;
    reg clk;
    reg reset;
    reg light_on;
    reg light_dim;
    wire [1:0] state;

    LightingControl uut (
        .clk(clk),
        .reset(reset),
        .light_on(light_on),
        .light_dim(light_dim),
        .state(state)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; light_on = 0; light_dim = 0;
        #10 reset = 0;

        #10 light_on = 1;
        #10 light_on = 0;

        #10 light_dim = 1;
        #10 light_dim = 0;

        #10 reset = 1;
        #10 reset = 0;

        #20 $stop;
    end
endmodule


`timescale 1ns/1ps

module tb_WhiteGoodsControl;
    reg clk;
    reg reset;
    reg start_washer;
    reg start_dishwasher;
    wire washer_status;
    wire dishwasher_status;

    WhiteGoodsControl uut (
        .clk(clk),
        .reset(reset),
        .start_washer(start_washer),
        .start_dishwasher(start_dishwasher),
        .washer_status(washer_status),
        .dishwasher_status(dishwasher_status)
    );


  always #5 clk = ~clk;

    initial begin

      clk = 0; reset = 1; start_washer = 0; start_dishwasher = 0;
        #10 reset = 0;

        #10 start_washer = 1;
        #10 start_washer = 0;

        #10 start_dishwasher = 1;
        #10 start_dishwasher = 0;

        #10 reset = 1;
        #10 reset = 0;

        #20 $stop;
    end
endmodule


`timescale 1ns/1ps

module tb_ClimateControl;
    reg clk;
    reg reset;
    reg [7:0] temperature;
    reg [7:0] humidity;
    wire heater_on;
    wire cooler_on;

    ClimateControl uut (
        .clk(clk),
        .reset(reset),
        .temperature(temperature),
        .humidity(humidity),
        .heater_on(heater_on),
        .cooler_on(cooler_on)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; temperature = 8'd20; humidity = 8'd50;
        #10 reset = 0;

        #10 temperature = 8'd30;
        #10 temperature = 8'd15;

        #10 reset = 1;
        #10 reset = 0;

        #20 $stop;
    end
endmodule


`timescale 1ns/1ps

module tb_SafetySystem;
    reg clk;
    reg reset;
    reg motion_detected;
    reg smoke_detected;
    wire alarm;

    SafetySystem uut (
        .clk(clk),
        .reset(reset),
        .motion_detected(motion_detected),
        .smoke_detected(smoke_detected),
        .alarm(alarm)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; motion_detected = 0; smoke_detected = 0;
        #10 reset = 0;

        #10 motion_detected = 1;
        #10 motion_detected = 0;

        #10 smoke_detected = 1;
        #10 smoke_detected = 0;

        #10 reset = 1;
        #10 reset = 0;

        #20 $stop;
    end
endmodule


