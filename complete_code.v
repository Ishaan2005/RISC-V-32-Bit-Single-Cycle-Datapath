// program counter module
module pc(input[31:0]pc_in, input clk, reset, output[31:0]reg pc_out);
always@(posedge clk or posedge reset)begin
if(reset)
pc_out <= 32'b0;
else 
pc_out < = pc_in;
end
endmodule

//module to update program counter, byter addressable
module pcplus4(input[31:0]from_pc,output[31:0]next_pc);
assign next_pc = from_pc + 4;
endmodule

//instruction memory, stores instructions
module instr_mem(input clk, reset,input[31:0]read_addr,output reg[31:0]inst_out);
reg [31:0]i_mem[255:0];
integer i;
always@(posedge clk or posedge reset)begin
	if(reset)begin
		for(i =0;i<=255;i=i+1)begin
		i_mem[i] <= 32'b0;
		end
	end
	else begin
	inst_out <= i_mem[read_addr];
	end
end
endmodule


//register file for source and destination registers
module registers(input clk,reset,regwrite, input[4:0]rs1,rs2,rd,input[31:0]write_data,output[31:0]read_data1,read_data2);
reg[31:0]registers[31:0];//32 registers each 32 bit wide
integer i;
always@(posedge clk or posedge reset)begin
if(reset)begin
for(i = 0; i<=31; i = i+1)begin
registers[i] <= 32'b0;
end
end
else if(regwrite & rd != 5'b0) begin
registers[rd] <= write_data;
end
end
assign read_data1 = registers[rs1];
assign read_data2 = registers[rs2];
endmodule 


//immediate address generator
module immgen(input[6:0]opcode,input[31:0]instruction,output[31:0]immex);
always@(*)begin
case(opcode)
		7'b0000011: immex = {{20{instruction[31]}},instruction[31:20]}; //lw
		7'b0100011: immex = {{20{instruction[31]}},instruction[31:25],instruction[11:7]}; //sw
		7'b1100011: immex = {{19{instruction[31]}},instruction[31],instruction[30:25],instruction[11:8],0}; ///branch
		endcase
	end
endmodule


//control unit to control complete flow
module control_unit(input[6:0]instruction, output reg branch,regwrite,alusrc,memwrite,memtoreg,memread,output reg[1:0] aluop);
always@(*)begin
case(instruction)
		7'b0110011: {alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop} <= 8'b00_1000_10; //r type
		7'b0000011: {alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop} <= 8'b11_1100_00; //lw type
		7'b0100011: {alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop} <= 8'b10_0010_00; //sw type  1x0010_00, x taken as 1
		7'b1100011: {alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop} <= 8'b00_0001_01; //beq      0x0001_01, x taken as 1
		default: {alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop} <= 8'b0;
		endcase
	end
endmodule


//alu to compute operations
module alu(input[31:0]A,B,input[3:0]control_in,output reg[31:0]alu_result,output reg zero);
always@(control_in or A or B)begin
case(control_in)
	4'b0000: begin 
		zero <= 0; 
		alu_result <= A&B;
		end
		
	4'b0001: begin 
		zero <= 0; 
		alu_result <= A|B;
		end
		
	4'b0010: begin 
		zero <= 0; 
		alu_result <= A+B;
		end
		
	4'b0011: begin
		zero <= 0;
		alu_result <= A^B;
		end
		
	4'b0110: begin 
		if(A==B) 
		zero <= 1; 
		else begin
		zero <= 0;
		alu_result <= A-B;
		end
	end
	
default: alu_result <= 32'b0;
endcase
end
endmodule

//alu control to decide which operation to perform
module alu_control(input[1:0]aluop,input[2:0]fun3,input fun7,output reg[3:0]control_out);
always@(*)begin 
casez({aluop,fun7,fun3})
6'b00_0_000: control_out = 0010; //6'b00_x_xxx
6'bx1_0_000: control_out = 0110; //6'bx1_x_xxx take x = 0
6'b10_0_000: control_out = 0010;
6'b10_1_000: control_out = 0110;
6'b10_0_111: control_out = 0000;
6'b10_0_110: control_out = 0001;
//the main control unit only generates 00,01 and 10 not 11
endcase
end
endmodule


//data memory to update the data after performing instructions
module data_mem(input clk,reset,memwrite,memread, input[31:0]read_address,write_data,output[31:0]memdata_out);
reg[31:0]d_mem[63:0];
integer i;
always@(posedge clk or posedge reset)begin
if(reset)begin
for(i =0; i<=63; i=i+1)begin
d_mem[i] <= 32'b0;
end
end
else if(memwrite) begin
d_mem[read_address] <= write_data;
end
end
assign memdata_out = (memread) ? d_mem[read_address]:32'b0;
endmodule

//3 muxes used
module mux1(input sel1,input[31:0]A1,B1,output[31:0]mux1out);
assign mux1out = (sel1)? A1:B1;
endmodule

module mux2(input sel2,input[31:0]A2,B2,output[31:0]mux2out);
assign mux2out = (sel2)? A2:B2;
endmodule

module mux3(input sel3,input[31:0]A3,B3,output[31:0]mux3out);
assign mux3out = (sel3)? A3:B3;
endmodule

//and gate for zero flag and beq
module and_gate(input branch,zero,output and_out);
assign and_out = branch & zero;
endmodule

//adder to add immediate address
module adder(input[31:0]in1,in2,output[31:0]sum_out);
assign sum_out = in1 + in2;
endmodule
