// Do not edit - auto-generated
module aplic_m_regmap #(
   parameter int NR_SRC 30,
   parameter int NR_IDCs 2
) (
  // Register: domaincfg
  input logic [0:0][31:0] i_domaincfg,
  output logic [0:0][31:0] o_domaincfg,
  output logic [0:0] o_domaincfg_we,
  output logic [0:0] o_domaincfg_re,
  // Register: sourcecfg
  input logic [30:0][10:0] i_sourcecfg,
  output logic [30:0][10:0] o_sourcecfg,
  output logic [30:0] o_sourcecfg_we,
  output logic [30:0] o_sourcecfg_re,
  // Register: mmsiaddrcfg
  input logic [0:0][31:0] i_mmsiaddrcfg,
  output logic [0:0][31:0] o_mmsiaddrcfg,
  output logic [0:0] o_mmsiaddrcfg_we,
  output logic [0:0] o_mmsiaddrcfg_re,
  // Register: mmsiaddrcfgh
  input logic [0:0][31:0] i_mmsiaddrcfgh,
  output logic [0:0][31:0] o_mmsiaddrcfgh,
  output logic [0:0] o_mmsiaddrcfgh_we,
  output logic [0:0] o_mmsiaddrcfgh_re,
  // Register: smsiaddrcfg
  input logic [0:0][31:0] i_smsiaddrcfg,
  output logic [0:0][31:0] o_smsiaddrcfg,
  output logic [0:0] o_smsiaddrcfg_we,
  output logic [0:0] o_smsiaddrcfg_re,
  // Register: smsiaddrcfgh
  input logic [0:0][31:0] i_smsiaddrcfgh,
  output logic [0:0][31:0] o_smsiaddrcfgh,
  output logic [0:0] o_smsiaddrcfgh_we,
  output logic [0:0] o_smsiaddrcfgh_re,
  // Register: setip
  input logic [0:0][31:0] i_setip,
  output logic [0:0][31:0] o_setip,
  output logic [0:0] o_setip_we,
  output logic [0:0] o_setip_re,
  // Register: setipnum
  input logic [0:0][31:0] i_setipnum,
  output logic [0:0][31:0] o_setipnum,
  output logic [0:0] o_setipnum_we,
  output logic [0:0] o_setipnum_re,
  // Register: in_clrip
  input logic [0:0][31:0] i_in_clrip,
  output logic [0:0][31:0] o_in_clrip,
  output logic [0:0] o_in_clrip_we,
  output logic [0:0] o_in_clrip_re,
  // Register: clripnum
  input logic [0:0][31:0] i_clripnum,
  output logic [0:0][31:0] o_clripnum,
  output logic [0:0] o_clripnum_we,
  output logic [0:0] o_clripnum_re,
  // Register: setie
  input logic [0:0][31:0] i_setie,
  output logic [0:0][31:0] o_setie,
  output logic [0:0] o_setie_we,
  output logic [0:0] o_setie_re,
  // Register: setienum
  input logic [0:0][31:0] i_setienum,
  output logic [0:0][31:0] o_setienum,
  output logic [0:0] o_setienum_we,
  output logic [0:0] o_setienum_re,
  // Register: clrie
  input logic [0:0][31:0] i_clrie,
  output logic [0:0][31:0] o_clrie,
  output logic [0:0] o_clrie_we,
  output logic [0:0] o_clrie_re,
  // Register: clrienum
  input logic [0:0][31:0] i_clrienum,
  output logic [0:0][31:0] o_clrienum,
  output logic [0:0] o_clrienum_we,
  output logic [0:0] o_clrienum_re,
  // Register: setipnum_le
  input logic [0:0][31:0] i_setipnum_le,
  output logic [0:0][31:0] o_setipnum_le,
  output logic [0:0] o_setipnum_le_we,
  output logic [0:0] o_setipnum_le_re,
  // Register: setipnum_be
  input logic [0:0][31:0] i_setipnum_be,
  output logic [0:0][31:0] o_setipnum_be,
  output logic [0:0] o_setipnum_be_we,
  output logic [0:0] o_setipnum_be_re,
  // Register: genmsi
  input logic [0:0][31:0] i_genmsi,
  output logic [0:0][31:0] o_genmsi,
  output logic [0:0] o_genmsi_we,
  output logic [0:0] o_genmsi_re,
  // Register: target
  input logic [30:0][31:0] i_target,
  output logic [30:0][31:0] o_target,
  output logic [30:0] o_target_we,
  output logic [30:0] o_target_re,
  // Register: idelivery
  input logic [1:0][0:0] i_idelivery,
  output logic [1:0][0:0] o_idelivery,
  output logic [1:0] o_idelivery_we,
  output logic [1:0] o_idelivery_re,
  // Register: iforce
  input logic [1:0][0:0] i_iforce,
  output logic [1:0][0:0] o_iforce,
  output logic [1:0] o_iforce_we,
  output logic [1:0] o_iforce_re,
  // Register: ithreshold
  input logic [1:0][2:0] i_ithreshold,
  output logic [1:0][2:0] o_ithreshold,
  output logic [1:0] o_ithreshold_we,
  output logic [1:0] o_ithreshold_re,
  // Register: topi
  input logic [1:0][24:0] i_topi,
  output logic [1:0] o_topi_re,
  // Register: claimi
  input logic [1:0][24:0] i_claimi,
  output logic [1:0] o_claimi_re,
  // Bus Interface
  input  reg_intf::reg_intf_req_a32_d32 i_req,
  output reg_intf::reg_intf_resp_d32    o_resp
);
always_comb begin
  o_resp.ready = 1'b1;
  o_resp.rdata = '0;
  o_resp.error = '0;
  o_domaincfg_o = '0;
  o_domaincfg_we = '0;
  o_domaincfg_re = '0;
  o_sourcecfg_o = '0;
  o_sourcecfg_we = '0;
  o_sourcecfg_re = '0;
  o_mmsiaddrcfg_o = '0;
  o_mmsiaddrcfg_we = '0;
  o_mmsiaddrcfg_re = '0;
  o_mmsiaddrcfgh_o = '0;
  o_mmsiaddrcfgh_we = '0;
  o_mmsiaddrcfgh_re = '0;
  o_smsiaddrcfg_o = '0;
  o_smsiaddrcfg_we = '0;
  o_smsiaddrcfg_re = '0;
  o_smsiaddrcfgh_o = '0;
  o_smsiaddrcfgh_we = '0;
  o_smsiaddrcfgh_re = '0;
  o_setip_o = '0;
  o_setip_we = '0;
  o_setip_re = '0;
  o_setipnum_o = '0;
  o_setipnum_we = '0;
  o_setipnum_re = '0;
  o_in_clrip_o = '0;
  o_in_clrip_we = '0;
  o_in_clrip_re = '0;
  o_clripnum_o = '0;
  o_clripnum_we = '0;
  o_clripnum_re = '0;
  o_setie_o = '0;
  o_setie_we = '0;
  o_setie_re = '0;
  o_setienum_o = '0;
  o_setienum_we = '0;
  o_setienum_re = '0;
  o_clrie_o = '0;
  o_clrie_we = '0;
  o_clrie_re = '0;
  o_clrienum_o = '0;
  o_clrienum_we = '0;
  o_clrienum_re = '0;
  o_setipnum_le_o = '0;
  o_setipnum_le_we = '0;
  o_setipnum_le_re = '0;
  o_setipnum_be_o = '0;
  o_setipnum_be_we = '0;
  o_setipnum_be_re = '0;
  o_genmsi_o = '0;
  o_genmsi_we = '0;
  o_genmsi_re = '0;
  o_target_o = '0;
  o_target_we = '0;
  o_target_re = '0;
  o_idelivery_o = '0;
  o_idelivery_we = '0;
  o_idelivery_re = '0;
  o_iforce_o = '0;
  o_iforce_we = '0;
  o_iforce_re = '0;
  o_ithreshold_o = '0;
  o_ithreshold_we = '0;
  o_ithreshold_re = '0;
  if (i_req.valid) begin
    if (i_req.write) begin
      unique case(i_req.addr)
        32'hc000000: begin
          o_domaincfg[0][31:0] = i_req.wdata[31:0];
          o_domaincfg_we[0] = 1'b1;
        end
        32'hc000004: begin
          o_sourcecfg[0][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[0] = 1'b1;
        end
        32'hc000008: begin
          o_sourcecfg[1][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[1] = 1'b1;
        end
        32'hc00000c: begin
          o_sourcecfg[2][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[2] = 1'b1;
        end
        32'hc000010: begin
          o_sourcecfg[3][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[3] = 1'b1;
        end
        32'hc000014: begin
          o_sourcecfg[4][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[4] = 1'b1;
        end
        32'hc000018: begin
          o_sourcecfg[5][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[5] = 1'b1;
        end
        32'hc00001c: begin
          o_sourcecfg[6][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[6] = 1'b1;
        end
        32'hc000020: begin
          o_sourcecfg[7][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[7] = 1'b1;
        end
        32'hc000024: begin
          o_sourcecfg[8][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[8] = 1'b1;
        end
        32'hc000028: begin
          o_sourcecfg[9][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[9] = 1'b1;
        end
        32'hc00002c: begin
          o_sourcecfg[10][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[10] = 1'b1;
        end
        32'hc000030: begin
          o_sourcecfg[11][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[11] = 1'b1;
        end
        32'hc000034: begin
          o_sourcecfg[12][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[12] = 1'b1;
        end
        32'hc000038: begin
          o_sourcecfg[13][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[13] = 1'b1;
        end
        32'hc00003c: begin
          o_sourcecfg[14][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[14] = 1'b1;
        end
        32'hc000040: begin
          o_sourcecfg[15][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[15] = 1'b1;
        end
        32'hc000044: begin
          o_sourcecfg[16][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[16] = 1'b1;
        end
        32'hc000048: begin
          o_sourcecfg[17][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[17] = 1'b1;
        end
        32'hc00004c: begin
          o_sourcecfg[18][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[18] = 1'b1;
        end
        32'hc000050: begin
          o_sourcecfg[19][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[19] = 1'b1;
        end
        32'hc000054: begin
          o_sourcecfg[20][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[20] = 1'b1;
        end
        32'hc000058: begin
          o_sourcecfg[21][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[21] = 1'b1;
        end
        32'hc00005c: begin
          o_sourcecfg[22][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[22] = 1'b1;
        end
        32'hc000060: begin
          o_sourcecfg[23][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[23] = 1'b1;
        end
        32'hc000064: begin
          o_sourcecfg[24][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[24] = 1'b1;
        end
        32'hc000068: begin
          o_sourcecfg[25][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[25] = 1'b1;
        end
        32'hc00006c: begin
          o_sourcecfg[26][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[26] = 1'b1;
        end
        32'hc000070: begin
          o_sourcecfg[27][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[27] = 1'b1;
        end
        32'hc000074: begin
          o_sourcecfg[28][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[28] = 1'b1;
        end
        32'hc000078: begin
          o_sourcecfg[29][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[29] = 1'b1;
        end
        32'hc00007c: begin
          o_sourcecfg[30][10:0] = i_req.wdata[10:0];
          o_sourcecfg_we[30] = 1'b1;
        end
        32'hc001bc0: begin
          o_mmsiaddrcfg[0][31:0] = i_req.wdata[31:0];
          o_mmsiaddrcfg_we[0] = 1'b1;
        end
        32'hc001bc4: begin
          o_mmsiaddrcfgh[0][31:0] = i_req.wdata[31:0];
          o_mmsiaddrcfgh_we[0] = 1'b1;
        end
        32'hc001bc8: begin
          o_smsiaddrcfg[0][31:0] = i_req.wdata[31:0];
          o_smsiaddrcfg_we[0] = 1'b1;
        end
        32'hc001bcc: begin
          o_smsiaddrcfgh[0][31:0] = i_req.wdata[31:0];
          o_smsiaddrcfgh_we[0] = 1'b1;
        end
        32'hc001c00: begin
          o_setip[0][31:0] = i_req.wdata[31:0];
          o_setip_we[0] = 1'b1;
        end
        32'hc001cdc: begin
          o_setipnum[0][31:0] = i_req.wdata[31:0];
          o_setipnum_we[0] = 1'b1;
        end
        32'hc001d00: begin
          o_in_clrip[0][31:0] = i_req.wdata[31:0];
          o_in_clrip_we[0] = 1'b1;
        end
        32'hc001ddc: begin
          o_clripnum[0][31:0] = i_req.wdata[31:0];
          o_clripnum_we[0] = 1'b1;
        end
        32'hc001e00: begin
          o_setie[0][31:0] = i_req.wdata[31:0];
          o_setie_we[0] = 1'b1;
        end
        32'hc001edc: begin
          o_setienum[0][31:0] = i_req.wdata[31:0];
          o_setienum_we[0] = 1'b1;
        end
        32'hc001f00: begin
          o_clrie[0][31:0] = i_req.wdata[31:0];
          o_clrie_we[0] = 1'b1;
        end
        32'hc001fdc: begin
          o_clrienum[0][31:0] = i_req.wdata[31:0];
          o_clrienum_we[0] = 1'b1;
        end
        32'hc002000: begin
          o_setipnum_le[0][31:0] = i_req.wdata[31:0];
          o_setipnum_le_we[0] = 1'b1;
        end
        32'hc002004: begin
          o_setipnum_be[0][31:0] = i_req.wdata[31:0];
          o_setipnum_be_we[0] = 1'b1;
        end
        32'hc003000: begin
          o_genmsi[0][31:0] = i_req.wdata[31:0];
          o_genmsi_we[0] = 1'b1;
        end
        32'hc003004: begin
          o_target[0][31:0] = i_req.wdata[31:0];
          o_target_we[0] = 1'b1;
        end
        32'hc003008: begin
          o_target[1][31:0] = i_req.wdata[31:0];
          o_target_we[1] = 1'b1;
        end
        32'hc00300c: begin
          o_target[2][31:0] = i_req.wdata[31:0];
          o_target_we[2] = 1'b1;
        end
        32'hc003010: begin
          o_target[3][31:0] = i_req.wdata[31:0];
          o_target_we[3] = 1'b1;
        end
        32'hc003014: begin
          o_target[4][31:0] = i_req.wdata[31:0];
          o_target_we[4] = 1'b1;
        end
        32'hc003018: begin
          o_target[5][31:0] = i_req.wdata[31:0];
          o_target_we[5] = 1'b1;
        end
        32'hc00301c: begin
          o_target[6][31:0] = i_req.wdata[31:0];
          o_target_we[6] = 1'b1;
        end
        32'hc003020: begin
          o_target[7][31:0] = i_req.wdata[31:0];
          o_target_we[7] = 1'b1;
        end
        32'hc003024: begin
          o_target[8][31:0] = i_req.wdata[31:0];
          o_target_we[8] = 1'b1;
        end
        32'hc003028: begin
          o_target[9][31:0] = i_req.wdata[31:0];
          o_target_we[9] = 1'b1;
        end
        32'hc00302c: begin
          o_target[10][31:0] = i_req.wdata[31:0];
          o_target_we[10] = 1'b1;
        end
        32'hc003030: begin
          o_target[11][31:0] = i_req.wdata[31:0];
          o_target_we[11] = 1'b1;
        end
        32'hc003034: begin
          o_target[12][31:0] = i_req.wdata[31:0];
          o_target_we[12] = 1'b1;
        end
        32'hc003038: begin
          o_target[13][31:0] = i_req.wdata[31:0];
          o_target_we[13] = 1'b1;
        end
        32'hc00303c: begin
          o_target[14][31:0] = i_req.wdata[31:0];
          o_target_we[14] = 1'b1;
        end
        32'hc003040: begin
          o_target[15][31:0] = i_req.wdata[31:0];
          o_target_we[15] = 1'b1;
        end
        32'hc003044: begin
          o_target[16][31:0] = i_req.wdata[31:0];
          o_target_we[16] = 1'b1;
        end
        32'hc003048: begin
          o_target[17][31:0] = i_req.wdata[31:0];
          o_target_we[17] = 1'b1;
        end
        32'hc00304c: begin
          o_target[18][31:0] = i_req.wdata[31:0];
          o_target_we[18] = 1'b1;
        end
        32'hc003050: begin
          o_target[19][31:0] = i_req.wdata[31:0];
          o_target_we[19] = 1'b1;
        end
        32'hc003054: begin
          o_target[20][31:0] = i_req.wdata[31:0];
          o_target_we[20] = 1'b1;
        end
        32'hc003058: begin
          o_target[21][31:0] = i_req.wdata[31:0];
          o_target_we[21] = 1'b1;
        end
        32'hc00305c: begin
          o_target[22][31:0] = i_req.wdata[31:0];
          o_target_we[22] = 1'b1;
        end
        32'hc003060: begin
          o_target[23][31:0] = i_req.wdata[31:0];
          o_target_we[23] = 1'b1;
        end
        32'hc003064: begin
          o_target[24][31:0] = i_req.wdata[31:0];
          o_target_we[24] = 1'b1;
        end
        32'hc003068: begin
          o_target[25][31:0] = i_req.wdata[31:0];
          o_target_we[25] = 1'b1;
        end
        32'hc00306c: begin
          o_target[26][31:0] = i_req.wdata[31:0];
          o_target_we[26] = 1'b1;
        end
        32'hc003070: begin
          o_target[27][31:0] = i_req.wdata[31:0];
          o_target_we[27] = 1'b1;
        end
        32'hc003074: begin
          o_target[28][31:0] = i_req.wdata[31:0];
          o_target_we[28] = 1'b1;
        end
        32'hc003078: begin
          o_target[29][31:0] = i_req.wdata[31:0];
          o_target_we[29] = 1'b1;
        end
        32'hc00307c: begin
          o_target[30][31:0] = i_req.wdata[31:0];
          o_target_we[30] = 1'b1;
        end
        32'hc004000: begin
          o_idelivery[0][0:0] = i_req.wdata[0:0];
          o_idelivery_we[0] = 1'b1;
        end
        32'hc004020: begin
          o_idelivery[1][0:0] = i_req.wdata[0:0];
          o_idelivery_we[1] = 1'b1;
        end
        32'hc004004: begin
          o_iforce[0][0:0] = i_req.wdata[0:0];
          o_iforce_we[0] = 1'b1;
        end
        32'hc004024: begin
          o_iforce[1][0:0] = i_req.wdata[0:0];
          o_iforce_we[1] = 1'b1;
        end
        32'hc004008: begin
          o_ithreshold[0][2:0] = i_req.wdata[2:0];
          o_ithreshold_we[0] = 1'b1;
        end
        32'hc004028: begin
          o_ithreshold[1][2:0] = i_req.wdata[2:0];
          o_ithreshold_we[1] = 1'b1;
        end
        default: o_resp.error = 1'b1;
      endcase
    end else begin
      unique case(i_req.addr)
        32'hc000000: begin
          o_resp.rdata[31:0] = i_domaincfg[0][31:0];
          o_domaincfg_re[0] = 1'b1;
        end
        32'hc000004: begin
          o_resp.rdata[10:0] = i_sourcecfg[0][10:0];
          o_sourcecfg_re[0] = 1'b1;
        end
        32'hc000008: begin
          o_resp.rdata[10:0] = i_sourcecfg[1][10:0];
          o_sourcecfg_re[1] = 1'b1;
        end
        32'hc00000c: begin
          o_resp.rdata[10:0] = i_sourcecfg[2][10:0];
          o_sourcecfg_re[2] = 1'b1;
        end
        32'hc000010: begin
          o_resp.rdata[10:0] = i_sourcecfg[3][10:0];
          o_sourcecfg_re[3] = 1'b1;
        end
        32'hc000014: begin
          o_resp.rdata[10:0] = i_sourcecfg[4][10:0];
          o_sourcecfg_re[4] = 1'b1;
        end
        32'hc000018: begin
          o_resp.rdata[10:0] = i_sourcecfg[5][10:0];
          o_sourcecfg_re[5] = 1'b1;
        end
        32'hc00001c: begin
          o_resp.rdata[10:0] = i_sourcecfg[6][10:0];
          o_sourcecfg_re[6] = 1'b1;
        end
        32'hc000020: begin
          o_resp.rdata[10:0] = i_sourcecfg[7][10:0];
          o_sourcecfg_re[7] = 1'b1;
        end
        32'hc000024: begin
          o_resp.rdata[10:0] = i_sourcecfg[8][10:0];
          o_sourcecfg_re[8] = 1'b1;
        end
        32'hc000028: begin
          o_resp.rdata[10:0] = i_sourcecfg[9][10:0];
          o_sourcecfg_re[9] = 1'b1;
        end
        32'hc00002c: begin
          o_resp.rdata[10:0] = i_sourcecfg[10][10:0];
          o_sourcecfg_re[10] = 1'b1;
        end
        32'hc000030: begin
          o_resp.rdata[10:0] = i_sourcecfg[11][10:0];
          o_sourcecfg_re[11] = 1'b1;
        end
        32'hc000034: begin
          o_resp.rdata[10:0] = i_sourcecfg[12][10:0];
          o_sourcecfg_re[12] = 1'b1;
        end
        32'hc000038: begin
          o_resp.rdata[10:0] = i_sourcecfg[13][10:0];
          o_sourcecfg_re[13] = 1'b1;
        end
        32'hc00003c: begin
          o_resp.rdata[10:0] = i_sourcecfg[14][10:0];
          o_sourcecfg_re[14] = 1'b1;
        end
        32'hc000040: begin
          o_resp.rdata[10:0] = i_sourcecfg[15][10:0];
          o_sourcecfg_re[15] = 1'b1;
        end
        32'hc000044: begin
          o_resp.rdata[10:0] = i_sourcecfg[16][10:0];
          o_sourcecfg_re[16] = 1'b1;
        end
        32'hc000048: begin
          o_resp.rdata[10:0] = i_sourcecfg[17][10:0];
          o_sourcecfg_re[17] = 1'b1;
        end
        32'hc00004c: begin
          o_resp.rdata[10:0] = i_sourcecfg[18][10:0];
          o_sourcecfg_re[18] = 1'b1;
        end
        32'hc000050: begin
          o_resp.rdata[10:0] = i_sourcecfg[19][10:0];
          o_sourcecfg_re[19] = 1'b1;
        end
        32'hc000054: begin
          o_resp.rdata[10:0] = i_sourcecfg[20][10:0];
          o_sourcecfg_re[20] = 1'b1;
        end
        32'hc000058: begin
          o_resp.rdata[10:0] = i_sourcecfg[21][10:0];
          o_sourcecfg_re[21] = 1'b1;
        end
        32'hc00005c: begin
          o_resp.rdata[10:0] = i_sourcecfg[22][10:0];
          o_sourcecfg_re[22] = 1'b1;
        end
        32'hc000060: begin
          o_resp.rdata[10:0] = i_sourcecfg[23][10:0];
          o_sourcecfg_re[23] = 1'b1;
        end
        32'hc000064: begin
          o_resp.rdata[10:0] = i_sourcecfg[24][10:0];
          o_sourcecfg_re[24] = 1'b1;
        end
        32'hc000068: begin
          o_resp.rdata[10:0] = i_sourcecfg[25][10:0];
          o_sourcecfg_re[25] = 1'b1;
        end
        32'hc00006c: begin
          o_resp.rdata[10:0] = i_sourcecfg[26][10:0];
          o_sourcecfg_re[26] = 1'b1;
        end
        32'hc000070: begin
          o_resp.rdata[10:0] = i_sourcecfg[27][10:0];
          o_sourcecfg_re[27] = 1'b1;
        end
        32'hc000074: begin
          o_resp.rdata[10:0] = i_sourcecfg[28][10:0];
          o_sourcecfg_re[28] = 1'b1;
        end
        32'hc000078: begin
          o_resp.rdata[10:0] = i_sourcecfg[29][10:0];
          o_sourcecfg_re[29] = 1'b1;
        end
        32'hc00007c: begin
          o_resp.rdata[10:0] = i_sourcecfg[30][10:0];
          o_sourcecfg_re[30] = 1'b1;
        end
        32'hc001bc0: begin
          o_resp.rdata[31:0] = i_mmsiaddrcfg[0][31:0];
          o_mmsiaddrcfg_re[0] = 1'b1;
        end
        32'hc001bc4: begin
          o_resp.rdata[31:0] = i_mmsiaddrcfgh[0][31:0];
          o_mmsiaddrcfgh_re[0] = 1'b1;
        end
        32'hc001bc8: begin
          o_resp.rdata[31:0] = i_smsiaddrcfg[0][31:0];
          o_smsiaddrcfg_re[0] = 1'b1;
        end
        32'hc001bcc: begin
          o_resp.rdata[31:0] = i_smsiaddrcfgh[0][31:0];
          o_smsiaddrcfgh_re[0] = 1'b1;
        end
        32'hc001c00: begin
          o_resp.rdata[31:0] = i_setip[0][31:0];
          o_setip_re[0] = 1'b1;
        end
        32'hc001cdc: begin
          o_resp.rdata[31:0] = i_setipnum[0][31:0];
          o_setipnum_re[0] = 1'b1;
        end
        32'hc001d00: begin
          o_resp.rdata[31:0] = i_in_clrip[0][31:0];
          o_in_clrip_re[0] = 1'b1;
        end
        32'hc001ddc: begin
          o_resp.rdata[31:0] = i_clripnum[0][31:0];
          o_clripnum_re[0] = 1'b1;
        end
        32'hc001e00: begin
          o_resp.rdata[31:0] = i_setie[0][31:0];
          o_setie_re[0] = 1'b1;
        end
        32'hc001edc: begin
          o_resp.rdata[31:0] = i_setienum[0][31:0];
          o_setienum_re[0] = 1'b1;
        end
        32'hc001f00: begin
          o_resp.rdata[31:0] = i_clrie[0][31:0];
          o_clrie_re[0] = 1'b1;
        end
        32'hc001fdc: begin
          o_resp.rdata[31:0] = i_clrienum[0][31:0];
          o_clrienum_re[0] = 1'b1;
        end
        32'hc002000: begin
          o_resp.rdata[31:0] = i_setipnum_le[0][31:0];
          o_setipnum_le_re[0] = 1'b1;
        end
        32'hc002004: begin
          o_resp.rdata[31:0] = i_setipnum_be[0][31:0];
          o_setipnum_be_re[0] = 1'b1;
        end
        32'hc003000: begin
          o_resp.rdata[31:0] = i_genmsi[0][31:0];
          o_genmsi_re[0] = 1'b1;
        end
        32'hc003004: begin
          o_resp.rdata[31:0] = i_target[0][31:0];
          o_target_re[0] = 1'b1;
        end
        32'hc003008: begin
          o_resp.rdata[31:0] = i_target[1][31:0];
          o_target_re[1] = 1'b1;
        end
        32'hc00300c: begin
          o_resp.rdata[31:0] = i_target[2][31:0];
          o_target_re[2] = 1'b1;
        end
        32'hc003010: begin
          o_resp.rdata[31:0] = i_target[3][31:0];
          o_target_re[3] = 1'b1;
        end
        32'hc003014: begin
          o_resp.rdata[31:0] = i_target[4][31:0];
          o_target_re[4] = 1'b1;
        end
        32'hc003018: begin
          o_resp.rdata[31:0] = i_target[5][31:0];
          o_target_re[5] = 1'b1;
        end
        32'hc00301c: begin
          o_resp.rdata[31:0] = i_target[6][31:0];
          o_target_re[6] = 1'b1;
        end
        32'hc003020: begin
          o_resp.rdata[31:0] = i_target[7][31:0];
          o_target_re[7] = 1'b1;
        end
        32'hc003024: begin
          o_resp.rdata[31:0] = i_target[8][31:0];
          o_target_re[8] = 1'b1;
        end
        32'hc003028: begin
          o_resp.rdata[31:0] = i_target[9][31:0];
          o_target_re[9] = 1'b1;
        end
        32'hc00302c: begin
          o_resp.rdata[31:0] = i_target[10][31:0];
          o_target_re[10] = 1'b1;
        end
        32'hc003030: begin
          o_resp.rdata[31:0] = i_target[11][31:0];
          o_target_re[11] = 1'b1;
        end
        32'hc003034: begin
          o_resp.rdata[31:0] = i_target[12][31:0];
          o_target_re[12] = 1'b1;
        end
        32'hc003038: begin
          o_resp.rdata[31:0] = i_target[13][31:0];
          o_target_re[13] = 1'b1;
        end
        32'hc00303c: begin
          o_resp.rdata[31:0] = i_target[14][31:0];
          o_target_re[14] = 1'b1;
        end
        32'hc003040: begin
          o_resp.rdata[31:0] = i_target[15][31:0];
          o_target_re[15] = 1'b1;
        end
        32'hc003044: begin
          o_resp.rdata[31:0] = i_target[16][31:0];
          o_target_re[16] = 1'b1;
        end
        32'hc003048: begin
          o_resp.rdata[31:0] = i_target[17][31:0];
          o_target_re[17] = 1'b1;
        end
        32'hc00304c: begin
          o_resp.rdata[31:0] = i_target[18][31:0];
          o_target_re[18] = 1'b1;
        end
        32'hc003050: begin
          o_resp.rdata[31:0] = i_target[19][31:0];
          o_target_re[19] = 1'b1;
        end
        32'hc003054: begin
          o_resp.rdata[31:0] = i_target[20][31:0];
          o_target_re[20] = 1'b1;
        end
        32'hc003058: begin
          o_resp.rdata[31:0] = i_target[21][31:0];
          o_target_re[21] = 1'b1;
        end
        32'hc00305c: begin
          o_resp.rdata[31:0] = i_target[22][31:0];
          o_target_re[22] = 1'b1;
        end
        32'hc003060: begin
          o_resp.rdata[31:0] = i_target[23][31:0];
          o_target_re[23] = 1'b1;
        end
        32'hc003064: begin
          o_resp.rdata[31:0] = i_target[24][31:0];
          o_target_re[24] = 1'b1;
        end
        32'hc003068: begin
          o_resp.rdata[31:0] = i_target[25][31:0];
          o_target_re[25] = 1'b1;
        end
        32'hc00306c: begin
          o_resp.rdata[31:0] = i_target[26][31:0];
          o_target_re[26] = 1'b1;
        end
        32'hc003070: begin
          o_resp.rdata[31:0] = i_target[27][31:0];
          o_target_re[27] = 1'b1;
        end
        32'hc003074: begin
          o_resp.rdata[31:0] = i_target[28][31:0];
          o_target_re[28] = 1'b1;
        end
        32'hc003078: begin
          o_resp.rdata[31:0] = i_target[29][31:0];
          o_target_re[29] = 1'b1;
        end
        32'hc00307c: begin
          o_resp.rdata[31:0] = i_target[30][31:0];
          o_target_re[30] = 1'b1;
        end
        32'hc004000: begin
          o_resp.rdata[0:0] = i_idelivery[0][0:0];
          o_idelivery_re[0] = 1'b1;
        end
        32'hc004020: begin
          o_resp.rdata[0:0] = i_idelivery[1][0:0];
          o_idelivery_re[1] = 1'b1;
        end
        32'hc004004: begin
          o_resp.rdata[0:0] = i_iforce[0][0:0];
          o_iforce_re[0] = 1'b1;
        end
        32'hc004024: begin
          o_resp.rdata[0:0] = i_iforce[1][0:0];
          o_iforce_re[1] = 1'b1;
        end
        32'hc004008: begin
          o_resp.rdata[2:0] = i_ithreshold[0][2:0];
          o_ithreshold_re[0] = 1'b1;
        end
        32'hc004028: begin
          o_resp.rdata[2:0] = i_ithreshold[1][2:0];
          o_ithreshold_re[1] = 1'b1;
        end
        32'hc004018: begin
          o_resp.rdata[24:0] = i_topi[0][24:0];
          o_topi_re[0] = 1'b1;
        end
        32'hc004038: begin
          o_resp.rdata[24:0] = i_topi[1][24:0];
          o_topi_re[1] = 1'b1;
        end
        32'hc00401c: begin
          o_resp.rdata[24:0] = i_claimi[0][24:0];
          o_claimi_re[0] = 1'b1;
        end
        32'hc00403c: begin
          o_resp.rdata[24:0] = i_claimi[1][24:0];
          o_claimi_re[1] = 1'b1;
        end
        default: o_resp.error = 1'b1;
      endcase
    end
  end
end
endmodule

