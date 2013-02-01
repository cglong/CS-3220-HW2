module ChristmasLight(LEDG, LEDR, CLOCK_50, KEY);
	input CLOCK_50;
	output [2:0] KEY;
	output [7:0] LEDG;
	output [7:0] LEDR;
	
	reg [31:0] Cnt;
	reg [31:0] TotalCnt;
	reg [7:0] greenValues;
	reg [7:0] redValues;
	reg [7:0] ledValues;
	reg [15:0] ledCounter;
	reg [15:0] state;
	
	initial Cnt = 0;
	initial TotalCnt = 32'd25000000;
	initial greenValues = 0;
	initial redValues = 0; 
	initial ledValues = 0;
	initial ledCounter = 1;
	initial state = 0;
	
	
	always @(posedge CLOCK_50) begin
		Cnt <= Cnt + 32'd1;
		if (Cnt == TotalCnt) begin
			ledValues <= ledValues ^ -8'd1;
			Cnt <= 32'd0;
			ledCounter <= ledCounter + 1;
		end
		
		if (ledCounter == 6) begin
			state <= (state + 1)  % 3;
			ledCounter <= 0;
		end
		
		if (state == 0) begin
			greenValues <= ledValues;
			redValues <= 0;
		end
		
		if (state == 1) begin
			greenValues <= 0;
			redValues <= ledValues;
		end
		
		if (state == 2) begin
			greenValues <= ledValues;
			redValues <= ledValues;
		end
		
		if (!KEY[0])
			if (TotalCnt <= 32'd250000000)
				TotalCnt <= TotalCnt + 32'd12500000;
		
		if (!KEY[1])
			if (TotalCnt >= 32'd12500000)
				TotalCnt <= TotalCnt - 32'd12500000;
		
		if (!KEY[2])
			TotalCnt <= 32'd25000000;
	end
	
	assign LEDR = redValues;
	assign LEDG = greenValues;
	
endmodule
