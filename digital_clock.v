module digital_clock_with_nanoseconds (
 input clk, 
 input reset, 
 output reg [5:0] seconds, 
 output reg [5:0] minutes, 
 output reg [4:0] hours, 
 output reg [29:0] nanoseconds
);
reg [25:0] cycle_count;
parameter ONE_SECOND_CYCLES = 50_000_000;
parameter NANOSECONDS_PER_SECOND = 1_000_000_000;
reg [29:0] nano_count;
always @(posedge clk or posedge reset) begin
 if (reset) begin
 cycle_count <= 0;
4
 seconds <= 0;
 minutes <= 0;
 hours <= 0;
 nano_count <= 0;
 nanoseconds <= 0; 
 end else begin
 nano_count <= nano_count + 1;
 if (nano_count == NANOSECONDS_PER_SECOND - 1) begin
 nano_count <= 0;
 cycle_count <= cycle_count + 1;
 end
 if (cycle_count == ONE_SECOND_CYCLES - 1) begin
 cycle_count <= 0;
 if (seconds == 59) begin
 seconds <= 0;
 if (minutes == 59) begin
 minutes <= 0;
 if (hours == 23) begin
 hours <= 0; 
 end else begin
 hours <= hours + 1;
 end
 end else begin
 minutes <= minutes + 1;
 end
 end else begin
 seconds <= seconds + 1;
 end
 end 
 nanoseconds <= nano_count; 
5
 end
end
endmodule
