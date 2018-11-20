module Processor(DATA1, DATA2, OPCODE, DATAOUT, FLAGS);

input [7:0] DATA1, DATA2;
input [3:0] OPCODE;
output reg [7:0] DATAOUT;
output reg [4:0] FLAGS;
output reg c; // carry
output reg [7:0] sum; 
output reg [8:0] big_sum; //this reg holds the nine-bit value if it's necessary.
assign cin = 1'b0; // need this input for first full adder operation.
always @ (DATA1 or DATA2 or OPCODE or DATAOUT or FLAGS) 

case(OPCODE)
	4'b0000 :begin // ADD OPERATION
			sum[0] = (DATA1[0] ^ DATA2[0] ^ cin); // Full Adder operations. This step calculates the sum with using XOR gates. 
			c = ((DATA1[0]&DATA2[0])|(DATA2[0]&cin)|(DATA1[0]&cin)); // Full Adder operations. This step calculates the carry.
			sum[1] = (DATA1[1] ^ DATA2[1] ^ c);
			c = ((DATA1[1]&DATA2[1])|(DATA2[1]&c)|(DATA1[1]&c));
			sum[2] = (DATA1[2] ^ DATA2[2] ^ c);
			c = ((DATA1[2]&DATA2[2])|(DATA2[2]&c)|(DATA1[2]&c));
			sum[3] = (DATA1[3] ^ DATA2[3] ^ c);
			c = ((DATA1[3]&DATA2[3])|(DATA2[3]&c)|(DATA1[3]&c));
			sum[4] = (DATA1[4] ^ DATA2[4] ^ c);
			c = ((DATA1[4]&DATA2[4])|(DATA2[4]&c)|(DATA1[4]&c));
			sum[5] = (DATA1[5] ^ DATA2[5] ^ c);
			c = ((DATA1[5]&DATA2[5])|(DATA2[5]&c)|(DATA1[5]&c));
			sum[6] = (DATA1[6] ^ DATA2[6] ^ c);
			c = ((DATA1[6]&DATA2[6])|(DATA2[6]&c)|(DATA1[6]&c));
			sum[7] = (DATA1[7] ^ DATA2[7] ^ c);
			c = ((DATA1[7]&DATA2[7])|(DATA2[7]&c)|(DATA1[7]&c));
			if ( c == 1 )
				begin
					assign FLAGS = 5'b00100;
				end
			else 
				begin
					assign FLAGS = 5'b00000;
				end
			DATAOUT = sum;
			big_sum = sum;
			big_sum[8]= c;
		end
	4'b0001 :begin // SUB OPERATION
			if (DATA1 < DATA2)
				begin
					assign FLAGS = 5'b00010;
				end
		end
	4'b0010 :begin // AND OPERATION
			assign FLAGS = 5'b00000;
			assign DATAOUT = DATA1 & DATA2; // This step calculates the DATAOUT with using AND operator.
		end
	4'b0011 : begin // OR OPERATION
			assign FLAGS = 5'b00000;
			assign DATAOUT = (DATA1 | DATA2); // This step calculates the DATAOUT with using OR operator.
		end
	4'b0100 : begin // XOR OPERATION
			assign FLAGS = 5'b00000;
			assign DATAOUT = DATA1 ^ DATA2; // This step calculates the DATAOUT with using XOR operator.
		end
	4'b0101 : begin // NOT OPERATION
			assign FLAGS = 5'b00000;
			assign DATAOUT = ~DATA1; // This step calculates the DATAOUT with using NOT operator.
		end

	4'b0110 : begin // COMPARE OPERATIONS
			if (DATA1 == DATA2)
				begin
					assign FLAGS = 5'bx0000;
				end
			if (DATA1 > DATA2)
				begin
					assign FLAGS = 5'b10000;
				end
			if (DATA1 < DATA2)
				begin
					assign FLAGS = 5'b00000;
				end
		end
	4'b0111 : begin // SHIFT LEFT OPERATION
			assign FLAGS = 5'b00000;
			assign DATAOUT = DATA1 << DATA2; // This step calculates the DATAOUT with using shift operator.			
		end
	4'b1000 :  begin // SHIFT RIGHT OPERATION
			assign FLAGS = 5'b00000;
			assign DATAOUT = DATA1 >> DATA2; // This step calculates the DATAOUT with using shift operator.
		end

	default : $display("You entered wrong inputs!");
endcase
endmodule



