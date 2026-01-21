module data_memory(clk,reset,memwrite,memread,read_addr,write_data,memdata_out);
input clk,reset,memwrite,memread;
input[31:0]read_addr,write_data;
output[31:0]memdata_out;
reg[31:0]D_mem[63:0];
integer i;
always@(posedge clk or posedge reset)begin
if(reset)
for(i=0;i<63;i=i+1)begin
D_mem[i] <= 32'b0;
end
else if(memwrite)begin
D_mem[read_addr] <= write_data; //when memwrite is high, write the data write_data to the data memory at the read_addr
end
end
assign memdata_out = (memread) ? D_mem[read_addr]:32'b00;
endmodule