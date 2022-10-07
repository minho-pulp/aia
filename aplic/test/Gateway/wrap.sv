module aplic_domain_gateway_wrapper #(
    parameter int NR_SRC = 64,
    parameter int NR_BITS_SRC = (NR_SRC > 31)? 32 : NR_SRC,
    parameter int NR_REG = (NR_SRC-1)/32 
) (
    input   logic                                       i_clk,
    input   logic                                       ni_rst,
    input   logic [NR_SRC-1:0]                          i_sources,
    input   logic [((NR_SRC)*11)-1:0]                   i_sourcecfg,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_setip,
    input   logic                                       i_domaincfgDM,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_active,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_claimed,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_forwarded,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_succ_w_clr,
    output  logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        o_intp_pen,
    output  logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        o_rectified_src
);

logic                                     clk_i;
logic                                     rst_ni;
logic [NR_SRC-1:0]                        sources_i;
logic [NR_SRC-1:0][10:0]                  sourcecfg_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]         setip_i;
logic                                     domaincfgDM_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]         active_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]         claimed_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]         forwarded_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]         succ_w_clr_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]         intp_pen_o;
logic [NR_REG:0][NR_BITS_SRC-1:0]         rectified_src_o;

/** Assign single lines */
assign clk_i            = i_clk;
assign rst_ni           = ni_rst;
assign domaincfgDM_i    = i_domaincfgDM;

/** Converts 1D array into 2D array */
for (genvar i = 0; i < NR_SRC; i++) begin
    assign sources_i[i]         = i_sources[i];
    assign sourcecfg_i[i]       = i_sourcecfg[i*11 +: 11];
end
for (genvar i = 0; i <= NR_REG; i++) begin
    assign setip_i[i]           = i_setip[i*NR_BITS_SRC +: NR_BITS_SRC];
    assign active_i[i]          = i_active[i*NR_BITS_SRC +: NR_BITS_SRC];
    assign claimed_i[i]         = i_claimed[i*NR_BITS_SRC +: NR_BITS_SRC];
    assign forwarded_i[i]       = i_forwarded[i*NR_BITS_SRC +: NR_BITS_SRC];
    assign succ_w_clr_i[i]      = i_succ_w_clr[i*NR_BITS_SRC +: NR_BITS_SRC];

    assign o_intp_pen[i*NR_BITS_SRC +: NR_BITS_SRC]         = intp_pen_o[i];
    assign o_rectified_src[i*NR_BITS_SRC +: NR_BITS_SRC]    = rectified_src_o[i];
end

/** Instantiate the DUT*/
aplic_domain_gateway#(
    .NR_SRC(NR_SRC)
) aplic_domain_gateway_i(
        .i_clk(clk_i),
        .ni_rst(rst_ni),
        .i_sources(sources_i),
        .i_sourcecfg(sourcecfg_i),
        .i_setip(setip_i),
        .i_domaincfgDM(domaincfgDM_i),
        .i_active(active_i),
        .i_claimed(claimed_i),
        .i_forwarded(forwarded_i),
        .i_succ_w_clr(succ_w_clr_i),
        .o_intp_pen(intp_pen_o),
        .o_rectified_src(rectified_src_o)
);

endmodule