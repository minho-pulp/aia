//
module aplic_m_domain_top #(
   parameter int                           N_SOURCE = 30,
   parameter int                           N_TARGET = 2
) (
   input  logic                            i_clk,
   input  logic                            ni_rst,
   input  reg_intf::reg_intf_req_a32_d32   i_req,
   output reg_intf::reg_intf_resp_d32      o_resp,
   input  logic [N_SOURCE-1:0]             i_irq_sources,
   output logic [N_SOURCE-1:0]             o_irq_del_sources,
   output logic [N_TARGET-1:0]             o_meip_targets
);

// Register domaincfg
logic [0:0][31:0]   domaincfg_qi;
logic [0:0][31:0]   domaincfg_qo;
logic [0:0]         domaincfg_we;
logic [0:0]         domaincfg_re;

// Register sourcecfg
logic [30:0][10:0]   sourcecfg_qi;
logic [30:0][10:0]   sourcecfg_qo;
logic [30:0]         sourcecfg_we;
logic [30:0]         sourcecfg_re;

// Register mmsiaddrcfg
logic [0:0][31:0]   mmsiaddrcfg_qi;
logic [0:0][31:0]   mmsiaddrcfg_qo;
logic [0:0]         mmsiaddrcfg_we;
logic [0:0]         mmsiaddrcfg_re;

// Register mmsiaddrcfgh
logic [0:0][31:0]   mmsiaddrcfgh_qi;
logic [0:0][31:0]   mmsiaddrcfgh_qo;
logic [0:0]         mmsiaddrcfgh_we;
logic [0:0]         mmsiaddrcfgh_re;

// Register smsiaddrcfg
logic [0:0][31:0]   smsiaddrcfg_qi;
logic [0:0][31:0]   smsiaddrcfg_qo;
logic [0:0]         smsiaddrcfg_we;
logic [0:0]         smsiaddrcfg_re;

// Register smsiaddrcfgh
logic [0:0][31:0]   smsiaddrcfgh_qi;
logic [0:0][31:0]   smsiaddrcfgh_qo;
logic [0:0]         smsiaddrcfgh_we;
logic [0:0]         smsiaddrcfgh_re;

// Register setip
logic [0:0][31:0]   setip_qi;
logic [0:0][31:0]   setip_qo;
logic [0:0]         setip_we;
logic [0:0]         setip_re;

// Register setipnum
logic [0:0][31:0]   setipnum_qi;
logic [0:0][31:0]   setipnum_qo;
logic [0:0]         setipnum_we;
logic [0:0]         setipnum_re;

// Register in_clrip
logic [0:0][31:0]   in_clrip_qi;
logic [0:0][31:0]   in_clrip_qo;
logic [0:0]         in_clrip_we;
logic [0:0]         in_clrip_re;

// Register clripnum
logic [0:0][31:0]   clripnum_qi;
logic [0:0][31:0]   clripnum_qo;
logic [0:0]         clripnum_we;
logic [0:0]         clripnum_re;

// Register setie
logic [0:0][31:0]   setie_qi;
logic [0:0][31:0]   setie_qo;
logic [0:0]         setie_we;
logic [0:0]         setie_re;

// Register setienum
logic [0:0][31:0]   setienum_qi;
logic [0:0][31:0]   setienum_qo;
logic [0:0]         setienum_we;
logic [0:0]         setienum_re;

// Register clrie
logic [0:0][31:0]   clrie_qi;
logic [0:0][31:0]   clrie_qo;
logic [0:0]         clrie_we;
logic [0:0]         clrie_re;

// Register clrienum
logic [0:0][31:0]   clrienum_qi;
logic [0:0][31:0]   clrienum_qo;
logic [0:0]         clrienum_we;
logic [0:0]         clrienum_re;

// Register setipnum_le
logic [0:0][31:0]   setipnum_le_qi;
logic [0:0][31:0]   setipnum_le_qo;
logic [0:0]         setipnum_le_we;
logic [0:0]         setipnum_le_re;

// Register setipnum_be
logic [0:0][31:0]   setipnum_be_qi;
logic [0:0][31:0]   setipnum_be_qo;
logic [0:0]         setipnum_be_we;
logic [0:0]         setipnum_be_re;

// Register genmsi
logic [0:0][31:0]   genmsi_qi;
logic [0:0][31:0]   genmsi_qo;
logic [0:0]         genmsi_we;
logic [0:0]         genmsi_re;

// Register target
logic [30:0][31:0]   target_qi;
logic [30:0][31:0]   target_qo;
logic [30:0]         target_we;
logic [30:0]         target_re;

// Register idelivery
logic [1:0][0:0]   idelivery_qi;
logic [1:0][0:0]   idelivery_qo;
logic [1:0]         idelivery_we;
logic [1:0]         idelivery_re;

// Register iforce
logic [1:0][0:0]   iforce_qi;
logic [1:0][0:0]   iforce_qo;
logic [1:0]         iforce_we;
logic [1:0]         iforce_re;

// Register ithreshold
logic [1:0][2:0]   ithreshold_qi;
logic [1:0][2:0]   ithreshold_qo;
logic [1:0]         ithreshold_we;
logic [1:0]         ithreshold_re;

// Register topi
logic [1:0][24:0]   topi_qi;
logic [1:0]         topi_re;

// Register claimi
logic [1:0][24:0]   claimi_qi;
logic [1:0]         claimi_re;

aplic_m_regmap i_aplic_m_regmap(
  // Register: domaincfg
   .i_domaincfg(domaincfg_qi),
   .o_domaincfg(domaincfg_qo),
   .o_domaincfg_we(domaincfg_we),
   .o_domaincfg_re(domaincfg_re),
  // Register: sourcecfg
   .i_sourcecfg(sourcecfg_qi),
   .o_sourcecfg(sourcecfg_qo),
   .o_sourcecfg_we(sourcecfg_we),
   .o_sourcecfg_re(sourcecfg_re),
  // Register: mmsiaddrcfg
   .i_mmsiaddrcfg(mmsiaddrcfg_qi),
   .o_mmsiaddrcfg(mmsiaddrcfg_qo),
   .o_mmsiaddrcfg_we(mmsiaddrcfg_we),
   .o_mmsiaddrcfg_re(mmsiaddrcfg_re),
  // Register: mmsiaddrcfgh
   .i_mmsiaddrcfgh(mmsiaddrcfgh_qi),
   .o_mmsiaddrcfgh(mmsiaddrcfgh_qo),
   .o_mmsiaddrcfgh_we(mmsiaddrcfgh_we),
   .o_mmsiaddrcfgh_re(mmsiaddrcfgh_re),
  // Register: smsiaddrcfg
   .i_smsiaddrcfg(smsiaddrcfg_qi),
   .o_smsiaddrcfg(smsiaddrcfg_qo),
   .o_smsiaddrcfg_we(smsiaddrcfg_we),
   .o_smsiaddrcfg_re(smsiaddrcfg_re),
  // Register: smsiaddrcfgh
   .i_smsiaddrcfgh(smsiaddrcfgh_qi),
   .o_smsiaddrcfgh(smsiaddrcfgh_qo),
   .o_smsiaddrcfgh_we(smsiaddrcfgh_we),
   .o_smsiaddrcfgh_re(smsiaddrcfgh_re),
  // Register: setip
   .i_setip(setip_qi),
   .o_setip(setip_qo),
   .o_setip_we(setip_we),
   .o_setip_re(setip_re),
  // Register: setipnum
   .i_setipnum(setipnum_qi),
   .o_setipnum(setipnum_qo),
   .o_setipnum_we(setipnum_we),
   .o_setipnum_re(setipnum_re),
  // Register: in_clrip
   .i_in_clrip(in_clrip_qi),
   .o_in_clrip(in_clrip_qo),
   .o_in_clrip_we(in_clrip_we),
   .o_in_clrip_re(in_clrip_re),
  // Register: clripnum
   .i_clripnum(clripnum_qi),
   .o_clripnum(clripnum_qo),
   .o_clripnum_we(clripnum_we),
   .o_clripnum_re(clripnum_re),
  // Register: setie
   .i_setie(setie_qi),
   .o_setie(setie_qo),
   .o_setie_we(setie_we),
   .o_setie_re(setie_re),
  // Register: setienum
   .i_setienum(setienum_qi),
   .o_setienum(setienum_qo),
   .o_setienum_we(setienum_we),
   .o_setienum_re(setienum_re),
  // Register: clrie
   .i_clrie(clrie_qi),
   .o_clrie(clrie_qo),
   .o_clrie_we(clrie_we),
   .o_clrie_re(clrie_re),
  // Register: clrienum
   .i_clrienum(clrienum_qi),
   .o_clrienum(clrienum_qo),
   .o_clrienum_we(clrienum_we),
   .o_clrienum_re(clrienum_re),
  // Register: setipnum_le
   .i_setipnum_le(setipnum_le_qi),
   .o_setipnum_le(setipnum_le_qo),
   .o_setipnum_le_we(setipnum_le_we),
   .o_setipnum_le_re(setipnum_le_re),
  // Register: setipnum_be
   .i_setipnum_be(setipnum_be_qi),
   .o_setipnum_be(setipnum_be_qo),
   .o_setipnum_be_we(setipnum_be_we),
   .o_setipnum_be_re(setipnum_be_re),
  // Register: genmsi
   .i_genmsi(genmsi_qi),
   .o_genmsi(genmsi_qo),
   .o_genmsi_we(genmsi_we),
   .o_genmsi_re(genmsi_re),
  // Register: target
   .i_target(target_qi),
   .o_target(target_qo),
   .o_target_we(target_we),
   .o_target_re(target_re),
  // Register: idelivery
   .i_idelivery(idelivery_qi),
   .o_idelivery(idelivery_qo),
   .o_idelivery_we(idelivery_we),
   .o_idelivery_re(idelivery_re),
  // Register: iforce
   .i_iforce(iforce_qi),
   .o_iforce(iforce_qo),
   .o_iforce_we(iforce_we),
   .o_iforce_re(iforce_re),
  // Register: ithreshold
   .i_ithreshold(ithreshold_qi),
   .o_ithreshold(ithreshold_qo),
   .o_ithreshold_we(ithreshold_we),
   .o_ithreshold_re(ithreshold_re),
  // Register: topi
   .i_topi(topi_qi),
   .o_topi_re(topi_re),
  // Register: claimi
   .i_claimi(claimi_qi),
   .o_claimi_re(claimi_re),
); // End of Regmap instance

endmodule

