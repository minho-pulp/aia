//
module aplic_domain_regctl_wrapper #(
    parameter int   NR_SRC      = 32,
    parameter int   NR_BITS_SRC = (NR_SRC > 31)? 32:NR_SRC,
    parameter int   NR_REG      = (NR_SRC-1)/32,
    parameter int   NR_IDC      = 1,
    parameter       MODE        = "DIRECT"
) (
    input   logic                                       i_clk,
    input   logic                                       ni_rst,
    /** Gateway */
    input   logic [(NR_SRC*11)-1:0]                     i_sourcecfg,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_sugg_setip,
    input   logic                                       i_domaincfgDM,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_active,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_claimed_forwarded,
    output  logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        o_intp_pen,
    output  logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        o_rectified_src,
    /** Notifier */
    input   logic                                       i_domaincfgIE,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_setip_q,
    input   logic [((NR_REG+1)*NR_BITS_SRC)-1:0]        i_setie_q,
    input   logic [(NR_SRC*32)-1:0]                     i_target_q,
        /**  interface for direct mode */
    input   logic [NR_IDCs-1:0]                         i_idelivery,
    input   logic [NR_IDCs-1:0]                         i_iforce,
    input   logic [(NR_IDCs*IPRIOLEN)-1:0]              i_ithreshold,
    output  logic [NR_IDCs-1:0][25:0]                   o_topi_sugg,
    output  logic [(NR_IDCs*26)-1:0]                    o_topi_update
        /**  interface for msi mode */
);

logic                                       clk_i;
logic                                       rst_ni;
logic [NR_SRC-1:0][10:0]                    sourcecfg_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]           sugg_setip_i;
logic                                       domaincfgDM_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]           active_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]           claimed_forwarded_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]           intp_pen_o;
logic [NR_REG:0][NR_BITS_SRC-1:0]           rectified_src_o;
logic                                       domaincfgIE_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]           setip_q_i;
logic [NR_REG:0][NR_BITS_SRC-1:0]           setie_q_i;
logic [NR_SRC-1:0][31:0]                    target_q_i;
logic [NR_IDCs-1:0][0:0]                    idelivery_i;
logic [NR_IDCs-1:0][0:0]                    iforce_i;
logic [NR_IDCs-1:0][IPRIOLEN-1:0]           ithreshold_i;
logic [NR_IDCs-1:0][25:0]                   topi_sugg_o;
logic                                       topi_update_o;

assign clk_i            = i_clk;
assign rst_ni           = ni_rst;
assign domaincfgDM_i    = i_domaincfgDM;
assign domaincfgIE_i    = i_domaincfgIE;
assign o_topi_update    = topi_update_o;

for (genvar i = 0; i < NR_SRC; i++) begin
    sourcecfg_i[i]  = i_sourcecfg[i*11 +: 11];
    target_q_i[i]   = i_target_q[i*32 +: 32];
end

for (genvar i = 0; i < NR_REG; i++) begin
    sugg_setip_i[i]                                 = i_sugg_setip[i*NR_BITS_SRC +: NR_BITS_SRC];
    active_i[i]                                     = i_active[i*NR_BITS_SRC +: NR_BITS_SRC];
    claimed_forwarded_i[i]                          = i_claimed_forwarded[i*NR_BITS_SRC +: NR_BITS_SRC];
    o_intp_pen[i*NR_BITS_SRC +: NR_BITS_SRC];       = intp_pen_o[i];
    o_rectified_src[i*NR_BITS_SRC +: NR_BITS_SRC];  = rectified_src_o[i];
    setip_q_i[i]                                    = i_setip_q[i*NR_BITS_SRC +: NR_BITS_SRC];
    setie_q_i[i]                                    = i_setie_q[i*NR_BITS_SRC +: NR_BITS_SRC];
end

for (genvar i = 0; i < NR_IDCs; i++) begin
    idelivery_i[i]              = i_idelivery[i];
    iforce_i[i]                 = iforce_i[i];
    ithreshold_i[i]             = i_ithreshold[i*IPRIOLEN +: IPRIOLEN];
    o_topi_sugg[i*26 +: 26]     = topi_sugg_i[i];
end

aplic_domain_regctl #(
    .DOMAIN_ADDR(DOMAIN_ADDR), 
    .NR_SRC(NR_SRC),      
    .MIN_PRIO(MIN_PRIO),  
    .IPRIOLEN(IPRIOLEN),
    .NR_IDCs(NR_IDCs),
    .APLIC(APLIC) 
) i_aplic_domain_regctl (
    .i_clk(clk_i),
    .ni_rst(_rst_ni),
    .i_req(req_i),
    .o_resp(resp_o),
    .o_sourcecfg(sourcecfg_o),
    .o_sugg_setip(sugg_setip_o),
    .o_domaincfgDM(domaincfgDM_o),
    .o_active(active_o),
    .o_claimed_forwarded(claimed_forwarded_o),
    .i_intp_pen(intp_pen_i),
    .i_rectified_src(rectified_src_i),
    .o_domaincfgIE(domaincfgIE_o),
    .o_setip_q(setip_q_o),
    .o_setie_q(setie_q_o),
    .o_target_q(target_q_o),
    .o_idelivery(idelivery_o),
    .o_iforce(iforce_o),
    .o_ithreshold(ithreshold_o),
    .i_topi_sugg(topi_sugg_i),
    .i_topi_update(topi_update_i)

);
endmodule