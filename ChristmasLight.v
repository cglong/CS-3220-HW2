module ChristmasLight(LEDG, LEDR, CLOCK_50, KEY);
	input CLOCK_50;
	output [2:0] KEY;
	output [7:0] LEDG;
	output [7:0] LEDR;
	reg [31:0] Cnt;
	initial Cnt = 0;
	reg [7:0] greenValues;
	reg [7:0] redValues;
	reg [7:0] ledValues;
	initial greenValues = 0;
	initial redValues = 0; 
	initial ledValues = 0;
	reg [31:0] ledCounter;
	initial ledCounter = 1;
	reg [31:0] state;
	initial state = 1;
	
	always @(posedge CLOCK_50) begin
		Cnt <= Cnt + 32'd1;
		if (Cnt == 32'd25000000) begin
			ledValues <= ledValues ^ -32'd1;
			Cnt <= 32'd0;
			ledCounter <= ledCounter + 1;
		end
		if (ledCounter == 6) begin
			state <= (state + 1)  % 3;
			ledCounter <= 0;
		end
		if (state == 1) begin
			greenValues <= ledValues;
			redValues <= 0;
		end
		if (state == 2) begin
			greenValues <= 0;
			redValues <= ledValues;
		end
		if (state == 3) begin
			greenValues <= ledValues;
			redValues <= ledValues;
		end	
	end
	
	assign LEDR = redValues;
	assign LEDG = greenValues;
	
endmodule
