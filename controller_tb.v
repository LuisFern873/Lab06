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
		$dumpfile("controller_tb.vcd");
		$dumpvars;
        reset <= 1; #10 ; reset <= 0;
    end

    always begin
        clk <= 1; #5; clk <= 0; #5;
    end
    
	initial begin
        #10;
        // 20'b11100000010011110000
        Instr = 20'b11100000010011110000;   // MAIN     SUB R0, R15, R15     ; R0 = 0
        ALUFlags = 4'b0100;
    
        #40;
        Instr = 20'b11100010100000000010;   //          ADD R2, R0, #5       ; R2 = 5
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100010100000000011;   //          ADD R3, R0, #12      ; R3 = 12
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100010010000110111;   //          SUB R7, R3, #9       ; R7 = 3
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100001100001110100;   //          ORR R4, R7, R2       ; R4 = 3 OR 5 = 7 
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100000000000110101;   //          AND R5, R3, R4    	; R5 = 12 AND 7 = 4
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100000100001010101;   //          ADD R5, R5, R4    	; R5 = 4 + 7 = 11
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100000010101011000;   //          SUBS R8, R5, R7    	; R8 <= 11 - 3 = 8, set Flags
        ALUFlags = 4'b0010;
        #40;
        Instr = 20'b00001010000000000000;   //          BEQ END        		; shouldn't be taken 
        ALUFlags = 4'b0000;
        #30;
        Instr = 20'b11100000010100111000;   //          SUBS R8, R3, R4    	; R8 = 12 - 7  = 5
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b10101010000000000000;   //          BGE AROUND       	; should be taken 
        ALUFlags = 4'b0000;
        #30;
        Instr = 20'b11100010100000000101;   //          ADD R5, R0, #0     	; should be skipped
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100000010101111000;   // AROUND   SUBS R8, R7, R2   	; R8 = 3 - 5 = -2, set Flags
        ALUFlags = 4'b1000;
        #40;
        Instr = 20'b10110010100001010111;   //          ADDLT R7, R5, #1  	; R7 = 11 + 1 = 12
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100000010001110111;   //          SUB R7, R7, R2    	; R7 = 12 - 5 = 7
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100101100000110111;   //          STR R7, [R3, #84]  	; mem[12+84] = 7
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100101100100000010;   //          LDR R2, [R0, #96]  	; R2 = mem[96] = 7
        ALUFlags = 4'b0000;
        #50;
        Instr = 20'b11100000100011111111;   //          ADD R15, R15, R0	; PC <- PC + 8 (skips next)
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100010100000000010;   //          ADD R2, R0, #14    	; shouldn't happen
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11101010000000000000;   //          B END             	; always taken
        ALUFlags = 4'b0000;
        #30;
        Instr = 20'b11100010100000000010;   //          ADD R2, R0, #13   	; shouldn't happen
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100010100000000010;   //          ADD R2, R0, #10		; shouldn't happen
        ALUFlags = 4'b0000;
        #40;
        Instr = 20'b11100101100000000010;   // END      STR R2, [R0, #100] 	; mem[100] = 7
        ALUFlags = 4'b0000;
        #40;
        $finish;
    end

    // Solo falta:
    // Completar los flags (si es que faltan)

endmodule

// 11100101100100000010