module alu(input[31:0]A,B,input[3:0]control_in,output reg[31:0]alu_result,output reg zero);
always@(control_in or A or B)begin
case(control_in)
4'b0000: begin zero <= 0; alu_result <= A&B;
end
4'b0001: begin zero <= 0; alu_result <= A|B;
end
4'b0010: begin zero <= 0; alu_result <= A+B;
end
4'b0110: begin if(A==B) zero <= 1; else alu_result <= A-B;
end
endcase
end
endmodule