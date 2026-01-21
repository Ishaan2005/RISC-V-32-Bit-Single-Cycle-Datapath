module alu_control(input[1:0]aluop,input[2:0]fun3,input fun7,output reg[3:0]control_out);
always@(*)begin 
casez({aluop,fun7,fun3})
6'b00_x_xxx: control_out = 0010;
6'bx1_x_xxx: control_out = 0110;
6'b10_0_000: control_out = 0010;
6'b10_1_000: control_out = 0110;
6'b10_0_111: control_out = 0000;
6'b10_0_110: control_out = 0001;
//the main control unit only generates 00,01 and 10 not 11
endcase
end
endmodule