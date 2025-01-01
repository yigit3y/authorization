module HomeOasis_Top(
    input clk,
    input reset,
    input [3:0] code,
    input validate,
    input light_on,
    input light_dim,
    input start_washer,
    input start_dishwasher,
    input [7:0] temperature,
    input [7:0] humidity,
    input motion_detected,
    input smoke_detected,
    output auth_status,
    output [1:0] light_state,
    output washer_status,
    output dishwasher_status,
    output heater_on,
    output cooler_on,
    output alarm
);

    // Authorization System
    AuthorizationSystem auth_sys (
        .clk(clk),
        .reset(reset),
        .code(code),
        .validate(validate),
        .auth_status(auth_status)
    );

    // Lighting Control
    LightingControl light_ctrl (
        .clk(clk),
        .reset(reset),
        .light_on(light_on),
        .light_dim(light_dim),
        .state(light_state)
    );

    // White Goods Control
    WhiteGoodsControl wg_ctrl (
        .clk(clk),
        .reset(reset),
        .start_washer(start_washer),
        .start_dishwasher(start_dishwasher),
        .washer_status(washer_status),
        .dishwasher_status(dishwasher_status)
    );

    // Climate Control
    ClimateControl climate_ctrl (
        .clk(clk),
        .reset(reset),
        .temperature(temperature),
        .humidity(humidity),
        .heater_on(heater_on),
        .cooler_on(cooler_on)
    );

    // Safety System
    SafetySystem safety_sys (
        .clk(clk),
        .reset(reset),
        .motion_detected(motion_detected),
        .smoke_detected(smoke_detected),
        .alarm(alarm)
    );

endmodule
