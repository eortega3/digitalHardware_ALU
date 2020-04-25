/*
 * File: alu32_tb.sv
 *
 * SystemVerilog self-checking testbench for a 32-bit version of the ALU
 * module.
 *
 * Note that this testbench reads test vectors from a file named alu32.tv.
 */
module testbench();

	// wires to connect to input/output of alu module
	logic [31:0] a, b, y;
	logic [2:0] f;
	logic zero, carry_out, overflow;

	// The clk isn't used by the ALU since it is a combinational circuit.
	// However, we'll use it in this testbench to give us a reference for when
	// to apply the inputs and then check the outputs.
	logic clk;

	integer test_num; // Number of the test vector we are currently testing.
	integer num_errors; // Number of errors encountered by testbench
	integer FIXME; //total number of tests

	// TODO: create new logic variables for the "expected" value for each of
	// the ALU outputs. These will be assigned to when we have a specific test
	// vector with which to work.

	logic [31:0] output_y; 
	logic zero_flag, carry_flag, overflow_flag;
	
	// TODO: XXX should be replace with one less than the number of bits in
	// each test vector, while YYY should be replaced with one less than the
	// total number of test vectors (i.e. how many rows were in your test
	// table).
	logic [111:0] test_vectors [32:0]; // will contain data we read from vector file.

	// TODO: instantiate 32-bit alu module. Name it "dut", short for "device
	// under test".

	alu #(32) dut(.a, .b, .y, .f, .zero, .carry_out, .overflow);
	
	initial
		forever
		begin
			clk = 0; #25; clk = 1; #25;
		end

	initial
	begin
		// Read test vector data from the alu32.tv file into our test_vectors
		// array.
		$readmemh("alu32.tv", test_vectors);

		num_errors = 0;
		FIXME = 32;
		
		// Go through all the test vectors and do the following:
		// 1. Advanced to the next negedge of the clk and set the ALU inputs
		//    to the values for those inputs contained in the test vectore.
		// 2. Advance to the next posedge of the clk, then set the "expected"
		//    values (again, from the test vector).
		// 3. Use $display to print out the following information for the
		// 	  current test vector:
		// 	  - It's test number (in decimal format))
		// 	  - It's inputs (in hex format)
		// 	  - It's actual and expected inputs (also hex format)
		// 4. Use an if statement to check that all alu outputs are the same
		//    as the expected outputs. If they are not, use $display to print
		//    out a "FAILED" message and increment num_errors to indicate we
		//    found a problematic test vector.
		for (test_num = 0; test_num < FIXME; test_num = test_num + 1)
		begin
			// TODO: Step 1
			
			//set the inputs
			@(negedge clk);
			a = test_vectors[test_num][107:76];
			b = test_vectors[test_num][75:44];
			f = test_vectors[test_num][110:108];
			
			// TODO: Step 2
			
			//set the expected outputs
			@(posedge clk);
			output_y = test_vectors[test_num][43:12];
			zero_flag = test_vectors[test_num][11:8];
			carry_flag = test_vectors[test_num][7:4];
			overflow_flag = test_vectors[test_num][3:0];
			
			// TODO: Step 3
			$display("----------------------------------------------------------------------------------");
			$display("Test Number: 		%3d",test_num);
			$display("Inputs: 			a = %h, b = %h, f = %h", a, b, f);
			$display("Actual Outputs: 	y = %h, zero = %h, carry = %h, overflow = %h", y, zero, carry_out, overflow);
			$display("Expected Inputs:	y = %h, zero = %h, carry = %h, overflow = %h", output_y, zero_flag, carry_flag, overflow_flag);
			$display("-----------------------------------------------------------------------------------");
			// TODO: Step 4
		
			assert(output_y === y
				& zero_flag === zero
				& carry_flag === carry_out
				& overflow_flag === overflow )
			else
			  begin
			  	$display("Vector -> %3d (%h)", test_num, test_vectors[test_num]);
				$display("FAILED: 	y = %h, zero = %h, carry = %h, overflow = %h", y, zero, carry_out, overflow);
				$display("EXPECTED: 	y = %h, zero = %h, carry = %h, overflow = %h", output_y, zero_flag, carry_flag, overflow_flag);
				$display("--------------------------------------------------------------------------------");
				num_errors++;
			  end
		end

		// Print a summary of your test results here.
		$display("%d out of FIXME tests failed!", num_errors);
	end

endmodule
