`timescale 1ns / 1ps

module mealy(
    input logic clk, 
    input logic rst_n, 
    input logic in,
    output logic detected
    );
    
    typedef enum logic [1:0]{
        S0, 
        S1,
        S2,
        S3
    } state_t;
    
    state_t state,next_state;
    
    always_ff @(posedge clk or negedge rst_n) begin 
        if(!rst_n) state <= S0;
        else state <= next_state;
    end 
    
    always_comb begin
        next_state=state;
        case(state)
            S0: next_state = in?S1:S0; 
            S1: next_state = in?S1:S2; // found 10
            S2: next_state = in?S3:S0; // found 101
            S3: next_state = in?S1:S2; // found 1011
            default: next_state = S0; // prevent illegal state lockups    
        endcase
    end
    
    always_comb begin
        detected = (state==S3 && next_state==S1 && in==1)?1:0;
    end 
    
endmodule
