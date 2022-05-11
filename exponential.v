`timescale 1ns / 1ps
module exponential(input clock, output successful);        
    wire terms_one_and_two_valid;
    wire [31:0] terms_one_and_two;
    wire intermediate_term_three_valid;
    wire [31:0] intermediate_term_three;
    wire term_three_valid;
    wire [31:0] term_three;
    wire terms_one_two_and_three_valid;
    wire [31:0] terms_one_two_and_three;
    wire intermediate_term_four_valid;
    wire [31:0] intermediate_term_four;
    wire term_four_valid;
    wire [31:0] term_four;
    wire terms_one_two_three_and_four_valid;
    wire [31:0] terms_one_two_three_and_four;
    /*
    wire intermediate_term_five_valid;
    wire [31:0] intermediate_term_five;
    wire term_five_valid;
    wire [31:0] term_five;
    wire terms_one_two_three_four_and_five_valid;
    wire [31:0] terms_one_two_three_four_and_five;
    wire intermediate_term_six_valid;
    wire [31:0] intermediate_term_six;
    */
    wire [31:0] e_x;
    
    reg [31:0] term_one = 32'b00111111100000000000000000000000;
    reg [31:0] x = 32'b10111110100000000000000000000000;
    reg [7:0] operation_add = 8'b0;
    reg [31:0] two = 32'b01000000000000000000000000000000;
    reg [31:0] three = 32'b01000000010000000000000000000000;
    //reg [31:0] four = 32'b01000000100000000000000000000000;
    //reg [31:0] five = 32'b01000000101000000000000000000000;
    
    /*
    always@(posedge clock) begin
        e_x = 32'b001111111_00000000000000000000000 + x + x * x * 32'b001111110_00000000000000000000000 + x * x * x * 32'b001111100_01010101010101010101011 + x * x * x * x * 32'b001111010_01010101010101010101011;
    end 
    */
    
    /*
    floating_point_0 computing_exponential(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(x),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_a_tlast(1),              // input wire s_axis_a_tlast
      .m_axis_result_tvalid(successful),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(e_x),    // output wire [31 : 0] m_axis_result_tdata
      .m_axis_result_tlast()    // output wire m_axis_result_tlast
    );    
    */
    
    floating_point_1 computing_terms_one_and_two(
      .aclk(clock),                                        // input wire aclk
      .s_axis_a_tvalid(1),                  // input wire s_axis_a_tvalid
      .s_axis_a_tready(),                  // output wire s_axis_a_tready
      .s_axis_a_tdata(term_one),                    // input wire [31 : 0] s_axis_a_tdata
      .s_axis_a_tlast(1),                    // input wire s_axis_a_tlast
      .s_axis_b_tvalid(1),                  // input wire s_axis_b_tvalid
      .s_axis_b_tready(),                  // output wire s_axis_b_tready
      .s_axis_b_tdata(x),                    // input wire [31 : 0] s_axis_b_tdata
      .s_axis_operation_tvalid(1),  // input wire s_axis_operation_tvalid
      .s_axis_operation_tready(),  // output wire s_axis_operation_tready
      .s_axis_operation_tdata(operation_add),    // input wire [7 : 0] s_axis_operation_tdata
      .m_axis_result_tvalid(terms_one_and_two_valid),        // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),        // input wire m_axis_result_tready
      .m_axis_result_tdata(terms_one_and_two),          // output wire [31 : 0] m_axis_result_tdata
      .m_axis_result_tlast()          // output wire m_axis_result_tlast
    );
    
    floating_point_2 computing_intermediate_term_three(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(x),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(1),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(two),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(intermediate_term_three_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(intermediate_term_three)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_3 computing_term_three(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(x),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(intermediate_term_three_valid),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(intermediate_term_three),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(term_three_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(term_three)    // output wire [31 : 0] m_axis_result_tdata
    );

    floating_point_4 computing_terms_one_two_and_three(
      .aclk(clock),                                        // input wire aclk
      .s_axis_a_tvalid(terms_one_and_two_valid),                  // input wire s_axis_a_tvalid
      .s_axis_a_tready(),                  // output wire s_axis_a_tready
      .s_axis_a_tdata(terms_one_and_two),                    // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(term_three_valid),                  // input wire s_axis_b_tvalid
      .s_axis_b_tready(),                  // output wire s_axis_b_tready
      .s_axis_b_tdata(term_three),                    // input wire [31 : 0] s_axis_b_tdata
      .s_axis_operation_tvalid(1),  // input wire s_axis_operation_tvalid
      .s_axis_operation_tready(),  // output wire s_axis_operation_tready
      .s_axis_operation_tdata(operation_add),    // input wire [7 : 0] s_axis_operation_tdata
      .m_axis_result_tvalid(terms_one_two_and_three_valid),        // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),        // input wire m_axis_result_tready
      .m_axis_result_tdata(terms_one_two_and_three)          // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_5 computing_intermediate_term_four(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(x),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(1),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(three),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(intermediate_term_four_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(intermediate_term_four)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_6 computing_term_four(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(term_three_valid),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(term_three),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(intermediate_term_four_valid),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(intermediate_term_four),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(term_four_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(term_four)    // output wire [31 : 0] m_axis_result_tdata
    );

    floating_point_7 computing_terms_one_two_three_and_four(
      .aclk(clock),                                        // input wire aclk
      .s_axis_a_tvalid(terms_one_two_and_three_valid),                  // input wire s_axis_a_tvalid
      .s_axis_a_tready(),                  // output wire s_axis_a_tready
      .s_axis_a_tdata(terms_one_two_and_three),                    // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(term_four_valid),                  // input wire s_axis_b_tvalid
      .s_axis_b_tready(),                  // output wire s_axis_b_tready
      .s_axis_b_tdata(term_four),                    // input wire [31 : 0] s_axis_b_tdata
      .s_axis_operation_tvalid(1),  // input wire s_axis_operation_tvalid
      .s_axis_operation_tready(),  // output wire s_axis_operation_tready
      .s_axis_operation_tdata(operation_add),    // input wire [7 : 0] s_axis_operation_tdata
      .m_axis_result_tvalid(successful),        // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),        // input wire m_axis_result_tready
      .m_axis_result_tdata(e_x)          // output wire [31 : 0] m_axis_result_tdata
    );
    
    /*
    floating_point_8 computing_intermediate_term_five(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(x),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(1),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(four),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(intermediate_term_five_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(intermediate_term_five)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_9 computing_term_five(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(term_four_valid),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(term_four),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(intermediate_term_five_valid),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(intermediate_term_five),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(term_five_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(term_five)    // output wire [31 : 0] m_axis_result_tdata
    );

    floating_point_10 computing_terms_one_two_three_four_and_five(
      .aclk(clock),                                        // input wire aclk
      .s_axis_a_tvalid(terms_one_two_three_and_four_valid),                  // input wire s_axis_a_tvalid
      .s_axis_a_tready(),                  // output wire s_axis_a_tready
      .s_axis_a_tdata(terms_one_two_three_and_four),                    // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(term_five_valid),                  // input wire s_axis_b_tvalid
      .s_axis_b_tready(),                  // output wire s_axis_b_tready
      .s_axis_b_tdata(term_five),                    // input wire [31 : 0] s_axis_b_tdata
      .s_axis_operation_tvalid(1),  // input wire s_axis_operation_tvalid
      .s_axis_operation_tready(),  // output wire s_axis_operation_tready
      .s_axis_operation_tdata(operation_add),    // input wire [7 : 0] s_axis_operation_tdata
      .m_axis_result_tvalid(terms_one_two_three_four_and_five_valid),        // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),        // input wire m_axis_result_tready
      .m_axis_result_tdata(terms_one_two_three_four_and_five)          // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_11 computing_intermediate_term_six(
      .aclk(clock),                                  // input wire aclk
      .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(x),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(1),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(),            // output wire s_axis_b_tready
      .s_axis_b_tdata(five),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(intermediate_term_six_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),  // input wire m_axis_result_tready
      .m_axis_result_tdata(intermediate_term_six)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    floating_point_12 computing_exponential(
      .aclk(clock),                                        // input wire aclk
      .s_axis_a_tvalid(term_five_valid),                  // input wire s_axis_a_tvalid
      .s_axis_a_tready(),                  // output wire s_axis_a_tready
      .s_axis_a_tdata(term_five),                    // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(intermediate_term_six_valid),                  // input wire s_axis_b_tvalid
      .s_axis_b_tready(),                  // output wire s_axis_b_tready
      .s_axis_b_tdata(intermediate_term_six),                    // input wire [31 : 0] s_axis_b_tdata
      .s_axis_c_tvalid(terms_one_two_three_four_and_five_valid),                  // input wire s_axis_c_tvalid
      .s_axis_c_tready(),                  // output wire s_axis_c_tready
      .s_axis_c_tdata(terms_one_two_three_four_and_five),                    // input wire [31 : 0] s_axis_c_tdata
      .s_axis_operation_tvalid(1),  // input wire s_axis_operation_tvalid
      .s_axis_operation_tready(),  // output wire s_axis_operation_tready
      .s_axis_operation_tdata(operation_add),    // input wire [7 : 0] s_axis_operation_tdata
      .m_axis_result_tvalid(successful),        // output wire m_axis_result_tvalid
      .m_axis_result_tready(1),        // input wire m_axis_result_tready
      .m_axis_result_tdata(e_x)          // output wire [31 : 0] m_axis_result_tdata
    );
    */
    
    ila_0 ila(
        .clk(clock), // input wire clk    
        .probe0(e_x) // input wire [31:0] probe0
    );
endmodule