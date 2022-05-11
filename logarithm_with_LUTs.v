`timescale 1ns/1ps
module logarithm(input clock, output successful);

    (* ram_style = "distributed" *) reg [31:0] LUT [0:63];
    reg [31:0] x = 32'b00111111000100010010011011101001;
    reg [7:0] exp_decimal;
    reg [31:0] exp_fixed;
    reg exp_fixed_valid;
    wire [31:0] exp_float;
    wire decimal_to_float_valid;
    parameter q = 17;
    reg [7:0] operation_add = 8'b0;
    wire exp_log2man_sum_valid;
    wire [31:0] exp_log2man_sum;
    reg [31:0] ln2 = 32'b00111111001100010111001000011000;
    wire [31:0] logx;
        
    floating_point_0 decimal_to_float(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(exp_fixed_valid),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(exp_fixed),              // input wire [31 : 0] s_axis_a_tdata
      .m_axis_result_tvalid(decimal_to_float_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(exp_float)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_1 exp_log2man_summation(
      .aclk(clock),                                        // input wire aclk
      .s_axis_a_tvalid(decimal_to_float_valid),                  // input wire s_axis_a_tvalid
      .s_axis_a_tready(),                  // output wire s_axis_a_tready
      .s_axis_a_tdata(exp_float),                    // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(1),                  // input wire s_axis_b_tvalid
      .s_axis_b_tready(),                  // output wire s_axis_b_tready
      .s_axis_b_tdata(LUT[x[22:q]]),                    // input wire [31 : 0] s_axis_b_tdata
      .s_axis_operation_tvalid(1),  // input wire s_axis_operation_tvalid
      .s_axis_operation_tready(),  // output wire s_axis_operation_tready
      .s_axis_operation_tdata(operation_add),    // input wire [7 : 0] s_axis_operation_tdata
      .m_axis_result_tvalid(exp_log2man_sum_valid),        // output wire m_axis_result_tvalid
      .m_axis_result_tready(decimal_to_float_valid),        // input wire m_axis_result_tready
      .m_axis_result_tdata(exp_log2man_sum)          // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_2 logarithm_computation(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(exp_log2man_sum_valid),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(exp_log2man_sum),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(1),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(ln2),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(successful),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(exp_log2man_sum_valid),  // input wire m_axis_result_tready
      .m_axis_result_tdata(logx)    // output wire [31 : 0] m_axis_result_tdata
    );

    initial begin
        LUT[0] = 32'b00000000000000000000000000000000;
        LUT[1] = 32'b00111100101101110011110010110100;
        LUT[2] = 32'b00111101001101011101011010011100;
        LUT[3] = 32'b00111101100001110101100111000101;
        LUT[4] = 32'b00111101101100110001111110111000;
        LUT[5] = 32'b00111101110111100100001000010010;
        LUT[6] = 32'b00111110000001000110001011000100;
        LUT[7] = 32'b00111110000110010101011101001111;
        LUT[8] = 32'b00111110001011100000000011010010;
        LUT[9] = 32'b00111110010000100110000101011111;
        LUT[10] = 32'b00111110010101100111101011110001;
        LUT[11] = 32'b00111110011010100100111101110010;
        LUT[12] = 32'b00111110011111011110000010110110;
        LUT[13] = 32'b00111110100010001001100000111111;
        LUT[14] = 32'b00111110100100100010000000111101;
        LUT[15] = 32'b00111110100110111000100100100110;
        LUT[16] = 32'b00111110101001001101001111000010;
        LUT[17] = 32'b00111110101011100000000011010010;
        LUT[18] = 32'b00111110101101110001000100001110;
        LUT[19] = 32'b00111110110000000000010100101011;
        LUT[20] = 32'b00111110110010001101110111010100;
        LUT[21] = 32'b00111110110100011001101110110000;
        LUT[22] = 32'b00111110110110100011111101100000;
        LUT[23] = 32'b00111110111000101100100101111101;
        LUT[24] = 32'b00111110111010110011101010011111;
        LUT[25] = 32'b00111110111100111001001101010101;
        LUT[26] = 32'b00111110111110111101010000101011;
        LUT[27] = 32'b00111111000000011111111011010100;
        LUT[28] = 32'b00111111000001100000100000101000;
        LUT[29] = 32'b00111111000010100000011001010000;
        LUT[30] = 32'b00111111000011011111100110001001;
        LUT[31] = 32'b00111111000100011110001000001111;
        LUT[32] = 32'b00111111000101011100000000011010;
        LUT[33] = 32'b00111111000110011001001111100011;
        LUT[34] = 32'b00111111000111010101110110100000;
        LUT[35] = 32'b00111111001000010001110110000100;
        LUT[36] = 32'b00111111001001001101001111000010;
        LUT[37] = 32'b00111111001010001000000010001100;
        LUT[38] = 32'b00111111001011000010010000010001;
        LUT[39] = 32'b00111111001011111011111010000000;
        LUT[40] = 32'b00111111001100110101000000000100;
        LUT[41] = 32'b00111111001101101101100011001011;
        LUT[42] = 32'b00111111001110100101100011111111;
        LUT[43] = 32'b00111111001111011101000011001000;
        LUT[44] = 32'b00111111010000010100000001001111;
        LUT[45] = 32'b00111111010001001010011110111010;
        LUT[46] = 32'b00111111010010000000011100110001;
        LUT[47] = 32'b00111111010010110101111011010111;
        LUT[48] = 32'b00111111010011101010111011010000;
        LUT[49] = 32'b00111111010100011111011101000000;
        LUT[50] = 32'b00111111010101010011100001001000;
        LUT[51] = 32'b00111111010110000111001000001001;
        LUT[52] = 32'b00111111010110111010010010100100;
        LUT[53] = 32'b00111111010111101101000000111001;
        LUT[54] = 32'b00111111011000011111010011100101;
        LUT[55] = 32'b00111111011001010001001011000111;
        LUT[56] = 32'b00111111011010000010100111111011;
        LUT[57] = 32'b00111111011010110011101010011111;
        LUT[58] = 32'b00111111011011100100010011001101;
        LUT[59] = 32'b00111111011100010100100010100001;
        LUT[60] = 32'b00111111011101000100011000110110;
        LUT[61] = 32'b00111111011101110011110110100100;
        LUT[62] = 32'b00111111011110100010111100000100;
        LUT[63] = 32'b00111111011111010001101001110001;
   
        exp_fixed_valid = 0;
     end
     
     always@(posedge clock) begin
        exp_decimal = x[30:23] - 8'b10000000;
        if(exp_decimal[7]) begin
            exp_fixed = {24'b111111111111111111111111, x[30:23] - 8'b01111111};
        end
        else begin
            exp_fixed = {24'b0, x[30:23] - 8'b01111111};    
        end
        exp_fixed_valid = 1;
     end
endmodule