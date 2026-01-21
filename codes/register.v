module register(clk,reset,regwrite,rs1,rs2,rd,write_data,read_data1,read_data2);
input clk,reset,regwrite;//control line to select whether to write data or not
input[4:0]rs1,rs2,rd;//rd is the destination register index
input[31:0]write_data;//data to be written
output[31:0]read_data1,read_data2;
reg[31:0]registers[31:0];//32x32 reg
integer i;
always@(posedge clk or posedge reset)begin
if(reset)begin
for(i=0;i<32;i=i+1)begin
registers[i] <= 32'b0;
end
end
else if(regwrite)begin//logic for synchronous write
registers[rd] <= write_data;
end
end
//read_data1 and read_data2 are combinational reads.
assign read_data1 = registers[rs1];
assign read_data2 = registers[rs2];
//Whatever values are stored at addresses rs1 and rs2 are continuously driven to the outputs.
//reading from the register file does not wait for the clock — you always get the current value.
//reads are combinational and hence async, whereas writes are sync sequentialto prevent glitching etc
endmodule