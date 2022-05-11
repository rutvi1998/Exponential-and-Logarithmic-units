`timescale 1ns / 1ps
module logarithmTB;
    reg clock;
    wire successful;
        
    logarithm func(clock, successful);
    
    initial begin
        clock = 0;
    end
    
    always begin
        #5 clock = ~clock;
    end
endmodule
