//
module aplic_domain_gateway #(
    parameter int NR_SRC = 32,
    parameter int NR_BITS_SRC = (NR_SRC > 32)? 32:NR_SRC,
    parameter int NR_REG = (NR_SRC > 32)? NR_SRC/32:1
) (
    input   logic                                     i_clk,
    input   logic                                     ni_rst,
    input   logic [NR_SRC-1:0]                        i_sources,
    input   logic [NR_SRC-1:0][10:0]                  i_sourcecfg,
    input   logic [NR_REG-1:0][NR_BITS_SRC-1:0]       i_setip,
    input   logic                                     i_domaincfgDM,
    input   logic [NR_SRC-1:0]                        i_active,
    input   logic [NR_SRC-1:0]                        i_claimed,
    input   logic [NR_SRC-1:0]                        i_forwarded,
    input   logic [NR_SRC-1:0]                        i_succ_w_clr,
    output  logic [NR_REG-1:0][NR_BITS_SRC-1:0]       o_intp_pen,
    output  logic [NR_SRC-1:0]                        o_rectified_src
);

localparam INACTIVE         = 3'h0;
localparam DETACHED         = 3'h1;
localparam EDGE1            = 3'h4;
localparam EDGE0            = 3'h5;
localparam LEVEL1           = 3'h6;
localparam LEVEL0           = 3'h7;

localparam INACTIVE_C       = 3'h0;
localparam DETACHED_C       = 3'h1;
localparam EDGEX_C          = 3'h2;
localparam LEVELXDM0_C      = 3'h3;
localparam LEVELXDM1_C      = 3'h4;

/** Internal signals*/
logic [NR_SRC-1:0]          rectified_src_i;
logic [NR_SRC-1:0]          new_intp_i;
logic [NR_SRC-1:0]          rectified_src_qi;
/** Control signals */
logic [NR_SRC-1:0]          new_intp_src;
logic [NR_SRC-1:0][2:0]     intp_pen_src_i;

/** Control Logic */
for (int i = 1; i < NR_SRC; i++) begin
    new_intp_src[i]     = 1'b0;
    intp_pen_src_i[i]   = INACTIVE_C;
    case (i_sourcecfg[2:0])
        INACTIVE: begin
            intp_pen_src_i[i] = INACTIVE_C;
        end
        DETACHED: begin
            intp_pen_src_i[i] = DETACHED_C;
        end
        EDGE1, EDGE0: begin
            new_intp_src[i] = 1'b1;
            intp_pen_src_i[i] = EDGEX_C;
        end
        LEVEL1, LEVEL0: begin
            if(i_domaincfgDM)begin
                new_intp_src[i] = 1'b1;
                intp_pen_src_i[i] = LEVELXDM1_C;
            end else begin
                intp_pen_src_i[i] = LEVELXDM0_C;
            end
        end
        default: begin 
            new_intp_src[i] = 1'b0;
            intp_pen_src_i[i] = INACTIVE_C;
        end 
    endcase
end

/** Rectify the input*/
always_comb begin
    for (int i = 1; i < NR_SRC; i++) begin
        rectified_src_i[i] = i_sources[i] xor i_sourcecfg[i][0];
        o_rectified_src[i] = rectified_src_i[i]; 
    end
end

/** Select the new interrupt */
always_comb begin
  for (int i = 1 ; i < NR_SRC; i++) begin    
    new_intp_i[i] = (new_intp_src[i]) ? (rectified_src_i[i] & ~rectified_src_qi[i]) : rectified_src_i[i];
  end
end

/** Choose logic to set pend */
always_comb begin
    for (int i = 1; i < NR_SRC; i++) begin
        case (intp_pen_src_i[i])
            DETACHED_C: begin
                o_intp_pen[i/32][i%32] = i_setip[i/32][i%32] & i_active[i] & ~(i_claimed[i] | i_forwarded[i] | i_succ_w_clr[i]);
            end
            EDGEX_C: begin
                o_intp_pen[i/32][i%32] = (new_intp_i[i] | i_setip[i/32][i%32]) & i_active[i] & ~(i_claimed[i] | i_forwarded[i] | i_succ_w_clr[i]);
            end
            LEVELXDM0_C: begin
                o_intp_pen[i/32][i%32] = new_intp_i[i] & i_active[i];
            end
            LEVELXDM1_C: begin
                o_intp_pen[i/32][i%32] = (new_intp_i[i] | i_setip[i/32][i%32]) & i_active[i] & ~(~new_intp_i[i] | i_forwarded[i] | i_succ_w_clr[i]);
            end
            default: begin
                o_intp_pen[i/32][i%32] = 1'b0;
            end
        endcase

    end
end

always_ff @(posedge i_clk, negedge ni_rst) begin
    if(!ni_rst)begin
        rectified_src_qi <= '0;
    end else begin
        rectified_src_qi <= rectified_src_i;
    end
end

endmodule