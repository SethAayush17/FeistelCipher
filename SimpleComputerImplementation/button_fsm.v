////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: button_fsm.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This finite state machine is used to generate one clock pulse every time the button
//              is pushed.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module button_fsm(clock, reset, button, enable);
	input  clock;
	input  reset;
	input  button;
	output enable;
	reg    enable;

	reg    state;  
	reg    next_state;  

	parameter s0 = 1'b0, s1 = 1'b1;
	
	always@(posedge clock) begin
		if (reset == 1'b1)
			state <= s0;
		else
			state <= next_state;  
	end 
     
   always@(state or button) begin
		enable = 1'b0;
		case(state)
			s0: begin
				if(button == 1'b0) begin
					next_state = s1;
					enable = 1'b1;
				end
				else
					next_state = s0;
			end
			s1: begin
				if(button == 1'b1)
					next_state = s0;
				else
					next_state = s1; 
			end
			default: next_state = s0;
		endcase
	end 
  
endmodule  
