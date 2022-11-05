`include "controller.v"
`timescale 1ns / 1ps

module controller_tb;
    // inputs
    reg clk;
    reg reset;
    reg [31:12] Instr;
    reg [3:0] ALUFlags;

    // outputs
    wire PCWrite;
    wire MemWrite;
    wire RegWrite;
    wire IRWrite;
    wire AdrSrc;
    wire [1:0] RegSrc;
    wire [1:0] ALUSrcA;
    wire [1:0] ALUSrcB;
    wire [1:0] ResultSrc;
    wire [1:0] ImmSrc;
    wire [1:0] ALUControl;
    

	controller c(
		.clk(clk),
		.reset(reset),
		.Instr(Instr),
		.ALUFlags(ALUFlags),
		.PCWrite(PCWrite),
		.MemWrite(MemWrite),
		.RegWrite(RegWrite),
		.IRWrite(IRWrite),
		.AdrSrc(AdrSrc),
		.RegSrc(RegSrc),
		.ALUSrcA(ALUSrcA),
		.ALUSrcB(ALUSrcB),
		.ResultSrc(ResultSrc),
		.ImmSrc(ImmSrc),
		.ALUControl(ALUControl)
	);
    

    initial begin
        reset <= 1; #22 ; reset <= 0;
    end

    always begin
        clk <= 1; #5; clk <= 0; #5;
    end
    
	initial begin
        #10
        Instr = 20'b11100000010011110000; 
        ALUFlags = 4'b0000;
        #40;
        // Completar aqui 
        // - las instrucciones en binaro estan el memfile.dat
        // - guiarse del report árabe xd

        
    end
endmodule