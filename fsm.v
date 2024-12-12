module authorization_fsm (
    input clk,
    input reset,
    input start,       
    input valid,       
    output reg access  
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        INPUT = 2'b01,
        VERIFY = 2'b10,
        GRANTED = 2'b11
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        access = 0;

        case (current_state)
            IDLE: begin
                if (start)
                    next_state = INPUT;
            end
            INPUT: begin
                next_state = VERIFY;
            end
            VERIFY: begin
                if (valid)
                    next_state = GRANTED;
                else
                    next_state = IDLE;
            end
            GRANTED: begin
                access = 1;  
                next_state = IDLE;
            end
        endcase
    end
endmodule

module lighting_fsm (
    input clk,
    input reset,
    input switch_on,   
    input dim,         
    input timer_done,  
    output reg [1:0] light_state  
);

   
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON = 2'b01,
        DIM = 2'b10,
        TIMER = 2'b11
    } state_t;

    state_t current_state, next_state;

    
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= OFF;
        else
            current_state <= next_state;
    end

   
    always @(*) begin
        next_state = current_state;

        case (current_state)
            OFF: begin
                if (switch_on)
                    next_state = ON;
            end
            ON: begin
                if (dim)
                    next_state = DIM;
                else if (timer_done)
                    next_state = TIMER;
            end
            DIM: begin
                if (switch_on)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            TIMER: begin
                if (timer_done)
                    next_state = OFF;
            end
        endcase
        light_state = current_state; 
    end
endmodule


module climate_control_fsm (
    input clk,
    input reset,
    input temp_high,   
    input temp_low,    
    input fan_on,      
    output reg [1:0] climate_state 
);

    
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        HEATING = 2'b01,
        COOLING = 2'b10,
        FAN = 2'b11
    } state_t;

    state_t current_state, next_state;

    
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

   
    always @(*) begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (temp_low)
                    next_state = HEATING;
                else if (temp_high)
                    next_state = COOLING;
                else if (fan_on)
                    next_state = FAN;
            end
            HEATING: begin
                if (!temp_low)
                    next_state = IDLE;
            end
            COOLING: begin
                if (!temp_high)
                    next_state = IDLE;
            end
            FAN: begin
                if (!fan_on)
                    next_state = IDLE;
            end
        endcase
        climate_state = current_state; 
    end
endmodule

module safety_fsm (
    input clk,
    input reset,
    input sensor_triggered,  
    input alarm_acknowledged, 
    input emergency_button,  
    output reg [1:0] safety_state 
);


    typedef enum reg [1:0] {
        SAFE = 2'b00,
        ALARM_TRIGGERED = 2'b01,
        EMERGENCY = 2'b10
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= SAFE;
        else
            current_state <= next_state;
    end


    always @(*) begin
        next_state = current_state;

        case (current_state)
            SAFE: begin
                if (sensor_triggered)
                    next_state = ALARM_TRIGGERED;
                else if (emergency_button)
                    next_state = EMERGENCY;
            end
            ALARM_TRIGGERED: begin
                if (alarm_acknowledged)
                    next_state = SAFE;
                else if (emergency_button)
                    next_state = EMERGENCY;
            end
            EMERGENCY: begin
                
                if (!emergency_button)
                    next_state = SAFE;
            end
        endcase
        safety_state = current_state; 
    end
endmodule

