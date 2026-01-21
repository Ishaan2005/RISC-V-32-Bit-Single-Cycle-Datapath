module pc(input clk, reset,input[31:0]pc_in,output reg[31:0]pc_out);
always@(posedge clk or posedge reset)begin
if(reset)
pc_out <= 32'b0;
else
pc_out <= pc_in; 
endmodule

module pcplus4(input[31:0]from_pc, output reg[31:0]next_pc);
assign next_pc = from_pc + 4; 
endmodule
