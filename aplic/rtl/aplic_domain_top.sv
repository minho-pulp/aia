// Do not edit - auto-generated
module aplic_domain_top #(
   parameter int                           N_SOURCE = 30,
   parameter int                           N_TARGET = 2,
) (
   input  logic                            i_clk,
   input  logic                            ni_rst,
   input  reg_intf::reg_intf_req_a32_d32   i_req,
   output reg_intf::reg_intf_resp_d32      o_resp,
   input  logic [N_SOURCE-1:0]             i_irq_sources,
   output logic [N_TARGET-1:0]             o_seip_targets
);

// Register domaincfg
logic [0:0][31:0] domaincfg_to_regmap;
logic [0:0][31:0] domaincfg_from_regmap;
logic [0:0]       domaincfg_we;
logic [0:0]       domaincfg_re;

// Register sourcecfg
logic [30:0][10:0] sourcecfg_to_regmap;
logic [30:0][10:0] sourcecfg_from_regmap;
logic [30:0]       sourcecfg_we;
logic [30:0]       sourcecfg_re;

// Register setip
logic [0:0][30:0] setip_to_regmap;
logic [0:0][30:0] setip_from_regmap;
logic [0:0]       setip_we;
logic [0:0]       setip_re;

// Register setipnum
logic [0:0][31:0] setipnum_to_regmap;
logic [0:0][31:0] setipnum_from_regmap;
logic [0:0]       setipnum_we;
logic [0:0]       setipnum_re;

// Register in_clrip
logic [0:0][30:0] in_clrip_to_regmap;
logic [0:0][30:0] in_clrip_from_regmap;
logic [0:0]       in_clrip_we;
logic [0:0]       in_clrip_re;

// Register clripnum
logic [0:0][31:0] clripnum_to_regmap;
logic [0:0][31:0] clripnum_from_regmap;
logic [0:0]       clripnum_we;
logic [0:0]       clripnum_re;

// Register setie
logic [0:0][30:0] setie_to_regmap;
logic [0:0][30:0] setie_from_regmap;
logic [0:0]       setie_we;
logic [0:0]       setie_re;

// Register setienum
logic [0:0][31:0] setienum_to_regmap;
logic [0:0][31:0] setienum_from_regmap;
logic [0:0]       setienum_we;
logic [0:0]       setienum_re;

// Register clrie
logic [0:0][30:0] clrie_to_regmap;
logic [0:0][30:0] clrie_from_regmap;
logic [0:0]       clrie_we;
logic [0:0]       clrie_re;

// Register clrienum
logic [0:0][31:0] clrienum_to_regmap;
logic [0:0][31:0] clrienum_from_regmap;
logic [0:0]       clrienum_we;
logic [0:0]       clrienum_re;

// Register setipnum_le
logic [0:0][31:0] setipnum_le_to_regmap;
logic [0:0][31:0] setipnum_le_from_regmap;
logic [0:0]       setipnum_le_we;
logic [0:0]       setipnum_le_re;

// Register setipnum_be
logic [0:0][31:0] setipnum_be_to_regmap;
logic [0:0][31:0] setipnum_be_from_regmap;
logic [0:0]       setipnum_be_we;
logic [0:0]       setipnum_be_re;

// Register genmsi
logic [0:0][31:0] genmsi_to_regmap;
logic [0:0][31:0] genmsi_from_regmap;
logic [0:0]       genmsi_we;
logic [0:0]       genmsi_re;

// Register target
logic [30:0][31:0] target_to_regmap;
logic [30:0][31:0] target_from_regmap;
logic [30:0]       target_we;
logic [30:0]       target_re;

// Register idelivery
logic [1:0][0:0] idelivery_to_regmap;
logic [1:0][0:0] idelivery_from_regmap;
logic [1:0]       idelivery_we;
logic [1:0]       idelivery_re;

// Register iforce
logic [1:0][0:0] iforce_to_regmap;
logic [1:0][0:0] iforce_from_regmap;
logic [1:0]       iforce_we;
logic [1:0]       iforce_re;

// Register ithreshold
logic [1:0][2:0] ithreshold_to_regmap;
logic [1:0][2:0] ithreshold_from_regmap;
logic [1:0]       ithreshold_we;
logic [1:0]       ithreshold_re;

// Register topi
logic [1:0][24:0] topi_to_regmap;
logic [1:0]       topi_re;

// Register claimi
logic [1:0][24:0] claimi_to_regmap;
logic [1:0]       claimi_re;
endmodule

