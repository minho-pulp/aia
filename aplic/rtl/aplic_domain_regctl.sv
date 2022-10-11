/**
*
* Name: APLIC Domain Register Control
* Date: 11/10/2022 
* Author: F.Marques <fmarques_00@protonmail.com>
*
* Description: This module is responsible for all the
*              logic used to determine the registers value.
*
*/

module aplic_domain_regctl #(
    parameter int                                       DOMAIN_ADDR = 32'hc000000,
    parameter int                                       NR_SRC    = 30,
    parameter int                                       MIN_PRIO  = 6,
    parameter int                                       IPRIOLEN  = 3,
    parameter int                                       NR_IDCs   = 2,
    // DO NOT EDIT BY PARAMETER
    parameter int                                       NR_BITS_SRC = (NR_SRC > 31)? 32 : NR_SRC,
    parameter int                                       NR_REG = (NR_SRC-1)/32  
) (
    input   logic                                       i_clk,
    input   logic                                       ni_rst,
    /** Register config: AXI interface From/To system bus */
    input   reg_intf::reg_intf_req_a32_d32              i_req,
    output  reg_intf::reg_intf_resp_d32                 o_resp,
    /** Gateway */
    output  logic [NR_SRC-1:0][10:0]                    o_sourcecfg,
    output  logic [NR_REG:0][NR_BITS_SRC-1:0]           o_sugg_setip,
    output  logic                                       o_domaincfgDM,
    output  logic [NR_REG:0][NR_BITS_SRC-1:0]           o_active,
    output  logic [NR_REG:0][NR_BITS_SRC-1:0]           o_claimed_forwarded,
    input   logic [NR_REG:0][NR_BITS_SRC-1:0]           i_intp_pen,
    input   logic [NR_REG:0][NR_BITS_SRC-1:0]           i_rectified_src,
    /** Notifier */
    output  logic                                       o_domaincfgIE,
    output  logic [NR_REG:0][NR_BITS_SRC-1:0]           o_setip_q,
    output  logic [NR_REG:0][NR_BITS_SRC-1:0]           o_setie_q,
    output  logic [NR_SRC-1:0][31:0]                    o_target_q,
        /**  interface for direct mode */
    output  logic [NR_IDC-1:0][0:0]                     o_idelivery,
    output  logic [NR_IDC-1:0][0:0]                     o_iforce,
    output  logic [NR_IDC-1:0][IPRIOLEN-1:0]            o_ithreshold,
    input   logic [NR_IDC-1:0][25:0]                    i_topi_sugg,
    input   logic                                       i_topi_update
        /**  interface for direct mode */
);

/** Register Map instantiation */

// Register domaincfg
logic [0:0][31:0]               domaincfg_qi, domaincfg_di;
logic [0:0][31:0]               domaincfg_o;
logic [0:0]                     domaincfg_we;
logic [0:0]                     domaincfg_re;

// Register sourcecfg
logic [NR_SRC:0][10-1:0]        sourcecfg_qi, sourcecfg_di;
logic [NR_SRC:0][10-1:0]        sourcecfg_o;
logic [NR_SRC:0]                sourcecfg_we;
logic [NR_SRC:0]                sourcecfg_re;

// Register mmsiaddrcfg
logic [0:0][31:0]               mmsiaddrcfg_qi, mmsiaddrcfg_di;
logic [0:0][31:0]               mmsiaddrcfg_o;
logic [0:0]                     mmsiaddrcfg_we;
logic [0:0]                     mmsiaddrcfg_re;

// Register mmsiaddrcfgh
logic [0:0][31:0]               mmsiaddrcfgh_qi, mmsiaddrcfgh_di;
logic [0:0][31:0]               mmsiaddrcfgh_o;
logic [0:0]                     mmsiaddrcfgh_we;
logic [0:0]                     mmsiaddrcfgh_re;

// Register smsiaddrcfg
logic [0:0][31:0]               smsiaddrcfg_qi, smsiaddrcfg_di;
logic [0:0][31:0]               smsiaddrcfg_o;
logic [0:0]                     smsiaddrcfg_we;
logic [0:0]                     smsiaddrcfg_re;

// Register smsiaddrcfgh
logic [0:0][31:0]               smsiaddrcfgh_qi, smsiaddrcfgh_di;
logic [0:0][31:0]               smsiaddrcfgh_o;
logic [0:0]                     smsiaddrcfgh_we;
logic [0:0]                     smsiaddrcfgh_re;

// Register setip
logic [0:0][31:0]               setip_qi, setip_di;
logic [0:0][31:0]               setip_o;
logic [0:0]                     setip_we;
logic [0:0]                     setip_re;

// Register setipnum
logic [0:0][31:0]               setipnum_o;
logic [0:0]                     setipnum_we;

// Register in_clrip
logic [0:0][31:0]               in_clrip_qi, in_clrip_di;
logic [0:0][31:0]               in_clrip_o;
logic [0:0]                     in_clrip_we;
logic [0:0]                     in_clrip_re;

// Register clripnum
logic [0:0][31:0]               clripnum_o;
logic [0:0]                     clripnum_we;

// Register setie
logic [0:0][31:0]               setie_qi, setie_di;
logic [0:0][31:0]               setie_o;
logic [0:0]                     setie_we;
logic [0:0]                     setie_re;

// Register setienum
logic [0:0][31:0]               setienum_o;
logic [0:0]                     setienum_we;

// Register clrie
logic [0:0][31:0]               clrie_o;
logic [0:0]                     clrie_we;

// Register clrienum
logic [0:0][31:0]               clrienum_o;
logic [0:0]                     clrienum_we;

// Register setipnum_le
logic [0:0][31:0]               setipnum_le_qi, setipnum_le_di;
logic [0:0][31:0]               setipnum_le_o;
logic [0:0]                     setipnum_le_we;
logic [0:0]                     setipnum_le_re;

// Register setipnum_be
logic [0:0][31:0]               setipnum_be_qi, setipnum_be_di;
logic [0:0][31:0]               setipnum_be_o;
logic [0:0]                     setipnum_be_we;
logic [0:0]                     setipnum_be_re;

// Register genmsi
logic [0:0][31:0]               genmsi_qi, genmsi_di;
logic [0:0][31:0]               genmsi_o;
logic [0:0]                     genmsi_we;
logic [0:0]                     genmsi_re;

// Register target
logic [NR_SRC:0][31-1:0]        target_qi, target_di;
logic [NR_SRC:0][31-1:0]        target_o;
logic [NR_SRC:0]                target_we;
logic [NR_SRC:0]                target_re;

// Register idelivery
logic [NR_IDCs-1:0][0:0]        idelivery_qi, idelivery_di;
logic [NR_IDCs-1:0][0:0]        idelivery_o;
logic [NR_IDCs-1:0]             idelivery_we;
logic [NR_IDCs-1:0]             idelivery_re;

// Register iforce
logic [NR_IDCs-1:0][0:0]        iforce_qi, iforce_di;
logic [NR_IDCs-1:0][0:0]        iforce_o;
logic [NR_IDCs-1:0]             iforce_we;
logic [NR_IDCs-1:0]             iforce_re;

// Register ithreshold
logic [NR_IDCs-1:0][IPRIOLEN-1:0]   ithreshold_qi, ithreshold_di;
logic [NR_IDCs-1:0][IPRIOLEN-1:0]   ithreshold_o;
logic [NR_IDCs-1:0]             ithreshold_we;
logic [NR_IDCs-1:0]             ithreshold_re;

// Register topi
logic [NR_IDCs-1:0][25:0]       topi_qi, topi_di;
logic [NR_IDCs-1:0]             topi_re;

// Register claimi
logic [NR_IDCs-1:0][25:0]       claimi_qi, claimi_di;
logic [NR_IDCs-1:0]             claimi_re;

aplic_regmap #(
   .DOMAIN_ADDR(DOMAIN_ADDR),
   .NR_SRC(NR_SRC),
   .MIN_PRIO(MIN_PRIO),
   .IPRIOLEN(IPRIOLEN),
   .NR_IDCs(NR_IDCs)
) i_aplic_regmap (
   // Register: domaincfg
   .i_domaincfg(domaincfg_qi),
   .o_domaincfg(domaincfg_o),
   .o_domaincfg_we(domaincfg_we),
   .o_domaincfg_re(domaincfg_re),
   // Register: sourcecfg
   .i_sourcecfg(sourcecfg_qi),
   .o_sourcecfg(sourcecfg_o),
   .o_sourcecfg_we(sourcecfg_we),
   .o_sourcecfg_re(sourcecfg_re),
   // Register: mmsiaddrcfg
   .i_mmsiaddrcfg(mmsiaddrcfg_qi),
   .o_mmsiaddrcfg(mmsiaddrcfg_o),
   .o_mmsiaddrcfg_we(mmsiaddrcfg_we),
   .o_mmsiaddrcfg_re(mmsiaddrcfg_re),
   // Register: mmsiaddrcfgh
   .i_mmsiaddrcfgh(mmsiaddrcfgh_qi),
   .o_mmsiaddrcfgh(mmsiaddrcfgh_o),
   .o_mmsiaddrcfgh_we(mmsiaddrcfgh_we),
   .o_mmsiaddrcfgh_re(mmsiaddrcfgh_re),
   // Register: smsiaddrcfg
   .i_smsiaddrcfg(smsiaddrcfg_qi),
   .o_smsiaddrcfg(smsiaddrcfg_o),
   .o_smsiaddrcfg_we(smsiaddrcfg_we),
   .o_smsiaddrcfg_re(smsiaddrcfg_re),
   // Register: smsiaddrcfgh
   .i_smsiaddrcfgh(smsiaddrcfgh_qi),
   .o_smsiaddrcfgh(smsiaddrcfgh_o),
   .o_smsiaddrcfgh_we(smsiaddrcfgh_we),
   .o_smsiaddrcfgh_re(smsiaddrcfgh_re),
   // Register: setip
   .i_setip(setip_qi),
   .o_setip(setip_o),
   .o_setip_we(setip_we),
   .o_setip_re(setip_re),
   // Register: setipnum
   .o_setipnum(setipnum_o),
   .o_setipnum_we(setipnum_we),
   // Register: in_clrip
   .i_in_clrip(in_clrip_qi),
   .o_in_clrip(in_clrip_o),
   .o_in_clrip_we(in_clrip_we),
   .o_in_clrip_re(in_clrip_re),
   // Register: clripnum
   .o_clripnum(clripnum_o),
   .o_clripnum_we(clripnum_we),
   // Register: setie
   .i_setie(setie_qi),
   .o_setie(setie_o),
   .o_setie_we(setie_we),
   .o_setie_re(setie_re),
   // Register: setienum
   .o_setienum(setienum_o),
   .o_setienum_we(setienum_we),
   // Register: clrie
   .o_clrie(clrie_o),
   .o_clrie_we(clrie_we),
   // Register: clrienum
   .o_clrienum(clrienum_o),
   .o_clrienum_we(clrienum_we),
   // Register: setipnum_le
   .i_setipnum_le(setipnum_le_qi),
   .o_setipnum_le(setipnum_le_o),
   .o_setipnum_le_we(setipnum_le_we),
   .o_setipnum_le_re(setipnum_le_re),
   // Register: setipnum_be
   .i_setipnum_be(setipnum_be_qi),
   .o_setipnum_be(setipnum_be_o),
   .o_setipnum_be_we(setipnum_be_we),
   .o_setipnum_be_re(setipnum_be_re),
   // Register: genmsi
   .i_genmsi(genmsi_qi),
   .o_genmsi(genmsi_o),
   .o_genmsi_we(genmsi_we),
   .o_genmsi_re(genmsi_re),
   // Register: target
   .i_target(target_qi),
   .o_target(target_o),
   .o_target_we(target_we),
   .o_target_re(target_re),
   // Register: idelivery
   .i_idelivery(idelivery_qi),
   .o_idelivery(idelivery_o),
   .o_idelivery_we(idelivery_we),
   .o_idelivery_re(idelivery_re),
   // Register: iforce
   .i_iforce(iforce_qi),
   .o_iforce(iforce_o),
   .o_iforce_we(iforce_we),
   .o_iforce_re(iforce_re),
   // Register: ithreshold
   .i_ithreshold(ithreshold_qi),
   .o_ithreshold(ithreshold_o),
   .o_ithreshold_we(ithreshold_we),
   .o_ithreshold_re(ithreshold_re),
   // Register: topi
   .i_topi(topi_qi),
   .o_topi_re(topi_re),
   // Register: claimi
   .i_claimi(claimi_qi),
   .o_claimi_re(claimi_re),
); // End of Regmap instance

/** Registers combinational logic */


/** Registers sequential logic */
always_ff @( posedge i_clk or negedge ni_rst ) begin
   if (!ni_rst) begin
     domaincfg_qi <= '0;
     sourcecfg_qi <= '0;
     mmsiaddrcfg_qi <= '0;
     mmsiaddrcfgh_qi <= '0;
     smsiaddrcfg_qi <= '0;
     smsiaddrcfgh_qi <= '0;
     setip_qi <= '0;
     in_clrip_qi <= '0;
     setie_qi <= '0;
     setipnum_le_qi <= '0;
     setipnum_be_qi <= '0;
     genmsi_qi <= '0;
     target_qi <= '0;
     idelivery_qi <= '0;
     iforce_qi <= '0;
     ithreshold_qi <= '0;
     topi_qi <= '0;
     claimi_qi <= '0;
   end else begin
     claimed_forwarded_qi <= claimed_forwarded_di;
     domaincfg_qi <= domaincfg_di;
     sourcecfg_qi <= sourcecfg_di;
     mmsiaddrcfg_qi <= mmsiaddrcfg_di;
     mmsiaddrcfgh_qi <= mmsiaddrcfgh_di;
     smsiaddrcfg_qi <= smsiaddrcfg_di;
     smsiaddrcfgh_qi <= smsiaddrcfgh_di;
     setip_qi <= setip_di;
     in_clrip_qi <= in_clrip_di;
     setie_qi <= setie_di;
     setipnum_le_qi <= setipnum_le_di;
     setipnum_be_qi <= setipnum_be_di;
     genmsi_qi <= genmsi_di;
     target_qi <= target_di;
     idelivery_qi <= idelivery_di;
     iforce_qi <= iforce_di;
     ithreshold_qi <= ithreshold_di;
     topi_qi <= topi_di;
     claimi_qi <= claimi_di;
   end
end

endmodule