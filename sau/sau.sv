module sau(
	input logic[31:0] rs2_val_i,
	input logic adrs_1_i,
	input logic adrs_0_i,
	input logic[2:0] f3_i,
	input logic mem_we_i,

	output logic[31:0] wdata_o,
	output logic[3:0] strobe_o);

    logic [3:0] raw_strobe;

    // --- Icarus Bug Fix: Extract physical data slices ---
    wire [7:0]  rs2_byte = rs2_val_i[7:0];
    wire [15:0] rs2_hw   = rs2_val_i[15:0];

    always_comb begin
        // Default assignments to prevent inferred latches
        wdata_o    = rs2_val_i;
        raw_strobe = 4'b0000;

        case (f3_i)
            // sb (Store Byte)
            3'b000: begin 
                wdata_o = {4{rs2_byte}};
                raw_strobe = 4'b0001 << {adrs_1_i, adrs_0_i};
            end

            // sh (Store Halfword)
            3'b001: begin 
                wdata_o = {2{rs2_hw}};
                raw_strobe = adrs_1_i ? 4'b1100 : 4'b0011;
            end

            // sw (Store Word)
            3'b010: begin 
                wdata_o = rs2_val_i;
                raw_strobe = 4'b1111;
            end
            
            // Default catch-all
            default: begin
                wdata_o = rs2_val_i;
                raw_strobe = 4'b0000;
            end
        endcase
    end

    // The Hardware Safety Gate
    assign strobe_o = mem_we_i ? raw_strobe : 4'b0000;

endmodule

