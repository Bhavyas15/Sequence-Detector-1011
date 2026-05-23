`timescale 1ns / 1ps

module tb(
    );
    logic clk;
    logic rst_n;
    logic in;
    logic detected=0;
    
    // for self-checking assertion
    // logic [0:12] expected = 13'b0001001000001; 
    logic expected [0:12] = '{
        0,0,0,1,
        0,0,1,
        0,0,0,0,0,1
    };

    int cycle;
    
//Uncomment appropriate dut case

//    moore dut (
//        .clk(clk),
//        .rst_n(rst_n),
//        .in(in),
//        .detected(detected)
//    );

    mealy dut (
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .detected(detected)
    );
    
    always #5 clk=~clk;
    
    task send_bit(input logic b);
    begin
        in=b;
        @(posedge  clk);
    end 
    endtask
    
    initial begin
        clk = 0;
        rst_n = 0;
        in = 0;

        #20;
        rst_n = 1;

        $display("-----------------------------------------");
        $display("Checking assertion");
        $display("-----------------------------------------");

        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);        
        send_bit(0);
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);
        
        #40;
        $finish;
    end
    
    always @(posedge clk) begin
        if (rst_n && cycle<$size(expected)) begin
            assert (detected == expected[cycle])
            else
                $error(
                    "Mismatch at cycle %0d : expected=%0b got=%0b",
                    cycle,
                    expected[cycle],
                    detected
                );
            cycle++;
        end
    end
    
endmodule
