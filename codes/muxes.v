module mux1(input sel1,input[31:0]A1,B1,output[31:0]mux1out);
assign mux1out = (sel1)? A1:B1;
endmodule

module mux2(input sel2,input[31:0]A2,B2,output[31:0]mux2out);
assign mux1out = (sel2)? A2:B2;
endmodule


module mux3(input sel3,input[31:0]A3,B3,output[31:0]mux3out);
assign mux3out = (sel3)? A3:B3;
endmodule