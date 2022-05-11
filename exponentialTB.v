`timescale 1ns / 1ps
module exponentialTB;
    reg clock;
    wire successful;
        
    exponential func(clock, successful);
    
    initial begin
        clock = 0;
    end
    
    always begin
        #5 clock = ~clock;
    end
endmodule
