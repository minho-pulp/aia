// Do not edit - auto-generated
module aplic_regs (
  // Register: domaincfg
  input logic [0:0][31:0] domaincfg_i,
  output logic [0:0][31:0] domaincfg_o,
  output logic [0:0] domaincfg_we_o,
  output logic [0:0] domaincfg_re_o,
  // Register: sourcecfg
  input logic [30:0][10:0] sourcecfg_i,
  output logic [30:0][10:0] sourcecfg_o,
  output logic [30:0] sourcecfg_we_o,
  output logic [30:0] sourcecfg_re_o,
  // Register: mmsiaddrcfg
  input logic [0:0][31:0] mmsiaddrcfg_i,
  output logic [0:0][31:0] mmsiaddrcfg_o,
  output logic [0:0] mmsiaddrcfg_we_o,
  output logic [0:0] mmsiaddrcfg_re_o,
  // Register: mmsiaddrcfgh
  input logic [0:0][31:0] mmsiaddrcfgh_i,
  output logic [0:0][31:0] mmsiaddrcfgh_o,
  output logic [0:0] mmsiaddrcfgh_we_o,
  output logic [0:0] mmsiaddrcfgh_re_o,
  // Register: smsiaddrcfg
  input logic [0:0][31:0] smsiaddrcfg_i,
  output logic [0:0][31:0] smsiaddrcfg_o,
  output logic [0:0] smsiaddrcfg_we_o,
  output logic [0:0] smsiaddrcfg_re_o,
  // Register: smsiaddrcfgh
  input logic [0:0][31:0] smsiaddrcfgh_i,
  output logic [0:0][31:0] smsiaddrcfgh_o,
  output logic [0:0] smsiaddrcfgh_we_o,
  output logic [0:0] smsiaddrcfgh_re_o,
  // Register: setip
  input logic [0:0][30:0] setip_i,
  output logic [0:0][30:0] setip_o,
  output logic [0:0] setip_we_o,
  output logic [0:0] setip_re_o,
  // Register: setipnum
  input logic [0:0][31:0] setipnum_i,
  output logic [0:0][31:0] setipnum_o,
  output logic [0:0] setipnum_we_o,
  output logic [0:0] setipnum_re_o,
  // Register: in_clrip
  input logic [0:0][30:0] in_clrip_i,
  output logic [0:0][30:0] in_clrip_o,
  output logic [0:0] in_clrip_we_o,
  output logic [0:0] in_clrip_re_o,
  // Register: clripnum
  input logic [0:0][31:0] clripnum_i,
  output logic [0:0][31:0] clripnum_o,
  output logic [0:0] clripnum_we_o,
  output logic [0:0] clripnum_re_o,
  // Register: setie
  input logic [0:0][30:0] setie_i,
  output logic [0:0][30:0] setie_o,
  output logic [0:0] setie_we_o,
  output logic [0:0] setie_re_o,
  // Register: setienum
  input logic [0:0][31:0] setienum_i,
  output logic [0:0][31:0] setienum_o,
  output logic [0:0] setienum_we_o,
  output logic [0:0] setienum_re_o,
  // Register: clrie
  input logic [0:0][30:0] clrie_i,
  output logic [0:0][30:0] clrie_o,
  output logic [0:0] clrie_we_o,
  output logic [0:0] clrie_re_o,
  // Register: clrienum
  input logic [0:0][31:0] clrienum_i,
  output logic [0:0][31:0] clrienum_o,
  output logic [0:0] clrienum_we_o,
  output logic [0:0] clrienum_re_o,
  // Register: setipnum_le
  input logic [0:0][31:0] setipnum_le_i,
  output logic [0:0][31:0] setipnum_le_o,
  output logic [0:0] setipnum_le_we_o,
  output logic [0:0] setipnum_le_re_o,
  // Register: setipnum_be
  input logic [0:0][31:0] setipnum_be_i,
  output logic [0:0][31:0] setipnum_be_o,
  output logic [0:0] setipnum_be_we_o,
  output logic [0:0] setipnum_be_re_o,
  // Register: genmsi
  input logic [0:0][31:0] genmsi_i,
  output logic [0:0][31:0] genmsi_o,
  output logic [0:0] genmsi_we_o,
  output logic [0:0] genmsi_re_o,
  // Register: target
  input logic [30:0][31:0] target_i,
  output logic [30:0][31:0] target_o,
  output logic [30:0] target_we_o,
  output logic [30:0] target_re_o,
  // Register: idelivery
  input logic [0:0][0:0] idelivery_i,
  output logic [0:0][0:0] idelivery_o,
  output logic [0:0] idelivery_we_o,
  output logic [0:0] idelivery_re_o,
  // Register: iforce
  input logic [0:0][0:0] iforce_i,
  output logic [0:0][0:0] iforce_o,
  output logic [0:0] iforce_we_o,
  output logic [0:0] iforce_re_o,
  // Register: ithreshold
  input logic [0:0][2:0] ithreshold_i,
  output logic [0:0][2:0] ithreshold_o,
  output logic [0:0] ithreshold_we_o,
  output logic [0:0] ithreshold_re_o,
  // Register: topi
  input logic [0:0][24:0] topi_i,
  output logic [0:0] topi_re_o,
  // Register: claimi
  input logic [0:0][24:0] claimi_i,
  output logic [0:0] claimi_re_o,
  // Bus Interface
  input  reg_intf::reg_intf_req_a32_d32 req_i,
  output reg_intf::reg_intf_resp_d32    resp_o
);
always_comb begin
  resp_o.ready = 1'b1;
  resp_o.rdata = '0;
  resp_o.error = '0;
  domaincfg_o = '0;
  domaincfg_we_o = '0;
  domaincfg_re_o = '0;
  sourcecfg_o = '0;
  sourcecfg_we_o = '0;
  sourcecfg_re_o = '0;
  mmsiaddrcfg_o = '0;
  mmsiaddrcfg_we_o = '0;
  mmsiaddrcfg_re_o = '0;
  mmsiaddrcfgh_o = '0;
  mmsiaddrcfgh_we_o = '0;
  mmsiaddrcfgh_re_o = '0;
  smsiaddrcfg_o = '0;
  smsiaddrcfg_we_o = '0;
  smsiaddrcfg_re_o = '0;
  smsiaddrcfgh_o = '0;
  smsiaddrcfgh_we_o = '0;
  smsiaddrcfgh_re_o = '0;
  setip_o = '0;
  setip_we_o = '0;
  setip_re_o = '0;
  setipnum_o = '0;
  setipnum_we_o = '0;
  setipnum_re_o = '0;
  in_clrip_o = '0;
  in_clrip_we_o = '0;
  in_clrip_re_o = '0;
  clripnum_o = '0;
  clripnum_we_o = '0;
  clripnum_re_o = '0;
  setie_o = '0;
  setie_we_o = '0;
  setie_re_o = '0;
  setienum_o = '0;
  setienum_we_o = '0;
  setienum_re_o = '0;
  clrie_o = '0;
  clrie_we_o = '0;
  clrie_re_o = '0;
  clrienum_o = '0;
  clrienum_we_o = '0;
  clrienum_re_o = '0;
  setipnum_le_o = '0;
  setipnum_le_we_o = '0;
  setipnum_le_re_o = '0;
  setipnum_be_o = '0;
  setipnum_be_we_o = '0;
  setipnum_be_re_o = '0;
  genmsi_o = '0;
  genmsi_we_o = '0;
  genmsi_re_o = '0;
  target_o = '0;
  target_we_o = '0;
  target_re_o = '0;
  idelivery_o = '0;
  idelivery_we_o = '0;
  idelivery_re_o = '0;
  iforce_o = '0;
  iforce_we_o = '0;
  iforce_re_o = '0;
  ithreshold_o = '0;
  ithreshold_we_o = '0;
  ithreshold_re_o = '0;
  if (req_i.valid) begin
    if (req_i.write) begin
      unique case(req_i.addr)
        32'hc000000: begin
          domaincfg_o[0][31:0] = req_i.wdata[31:0];
          domaincfg_we_o[0] = 1'b1;
        end
        32'hc000004: begin
          sourcecfg_o[0][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[0] = 1'b1;
        end
        32'hc000008: begin
          sourcecfg_o[1][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[1] = 1'b1;
        end
        32'hc00000c: begin
          sourcecfg_o[2][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[2] = 1'b1;
        end
        32'hc000010: begin
          sourcecfg_o[3][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[3] = 1'b1;
        end
        32'hc000014: begin
          sourcecfg_o[4][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[4] = 1'b1;
        end
        32'hc000018: begin
          sourcecfg_o[5][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[5] = 1'b1;
        end
        32'hc00001c: begin
          sourcecfg_o[6][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[6] = 1'b1;
        end
        32'hc000020: begin
          sourcecfg_o[7][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[7] = 1'b1;
        end
        32'hc000024: begin
          sourcecfg_o[8][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[8] = 1'b1;
        end
        32'hc000028: begin
          sourcecfg_o[9][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[9] = 1'b1;
        end
        32'hc00002c: begin
          sourcecfg_o[10][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[10] = 1'b1;
        end
        32'hc000030: begin
          sourcecfg_o[11][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[11] = 1'b1;
        end
        32'hc000034: begin
          sourcecfg_o[12][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[12] = 1'b1;
        end
        32'hc000038: begin
          sourcecfg_o[13][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[13] = 1'b1;
        end
        32'hc00003c: begin
          sourcecfg_o[14][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[14] = 1'b1;
        end
        32'hc000040: begin
          sourcecfg_o[15][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[15] = 1'b1;
        end
        32'hc000044: begin
          sourcecfg_o[16][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[16] = 1'b1;
        end
        32'hc000048: begin
          sourcecfg_o[17][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[17] = 1'b1;
        end
        32'hc00004c: begin
          sourcecfg_o[18][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[18] = 1'b1;
        end
        32'hc000050: begin
          sourcecfg_o[19][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[19] = 1'b1;
        end
        32'hc000054: begin
          sourcecfg_o[20][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[20] = 1'b1;
        end
        32'hc000058: begin
          sourcecfg_o[21][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[21] = 1'b1;
        end
        32'hc00005c: begin
          sourcecfg_o[22][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[22] = 1'b1;
        end
        32'hc000060: begin
          sourcecfg_o[23][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[23] = 1'b1;
        end
        32'hc000064: begin
          sourcecfg_o[24][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[24] = 1'b1;
        end
        32'hc000068: begin
          sourcecfg_o[25][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[25] = 1'b1;
        end
        32'hc00006c: begin
          sourcecfg_o[26][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[26] = 1'b1;
        end
        32'hc000070: begin
          sourcecfg_o[27][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[27] = 1'b1;
        end
        32'hc000074: begin
          sourcecfg_o[28][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[28] = 1'b1;
        end
        32'hc000078: begin
          sourcecfg_o[29][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[29] = 1'b1;
        end
        32'hc00007c: begin
          sourcecfg_o[30][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[30] = 1'b1;
        end
        32'hc001bc0: begin
          mmsiaddrcfg_o[0][31:0] = req_i.wdata[31:0];
          mmsiaddrcfg_we_o[0] = 1'b1;
        end
        32'hc001bc4: begin
          mmsiaddrcfgh_o[0][31:0] = req_i.wdata[31:0];
          mmsiaddrcfgh_we_o[0] = 1'b1;
        end
        32'hc001bc8: begin
          smsiaddrcfg_o[0][31:0] = req_i.wdata[31:0];
          smsiaddrcfg_we_o[0] = 1'b1;
        end
        32'hc001bcc: begin
          smsiaddrcfgh_o[0][31:0] = req_i.wdata[31:0];
          smsiaddrcfgh_we_o[0] = 1'b1;
        end
        32'hc001c00: begin
          setip_o[0][30:0] = req_i.wdata[30:0];
          setip_we_o[0] = 1'b1;
        end
        32'hc001cdc: begin
          setipnum_o[0][31:0] = req_i.wdata[31:0];
          setipnum_we_o[0] = 1'b1;
        end
        32'hc001d00: begin
          in_clrip_o[0][30:0] = req_i.wdata[30:0];
          in_clrip_we_o[0] = 1'b1;
        end
        32'hc001ddc: begin
          clripnum_o[0][31:0] = req_i.wdata[31:0];
          clripnum_we_o[0] = 1'b1;
        end
        32'hc001e00: begin
          setie_o[0][30:0] = req_i.wdata[30:0];
          setie_we_o[0] = 1'b1;
        end
        32'hc001edc: begin
          setienum_o[0][31:0] = req_i.wdata[31:0];
          setienum_we_o[0] = 1'b1;
        end
        32'hc001f00: begin
          clrie_o[0][30:0] = req_i.wdata[30:0];
          clrie_we_o[0] = 1'b1;
        end
        32'hc001fdc: begin
          clrienum_o[0][31:0] = req_i.wdata[31:0];
          clrienum_we_o[0] = 1'b1;
        end
        32'hc002000: begin
          setipnum_le_o[0][31:0] = req_i.wdata[31:0];
          setipnum_le_we_o[0] = 1'b1;
        end
        32'hc002004: begin
          setipnum_be_o[0][31:0] = req_i.wdata[31:0];
          setipnum_be_we_o[0] = 1'b1;
        end
        32'hc003000: begin
          genmsi_o[0][31:0] = req_i.wdata[31:0];
          genmsi_we_o[0] = 1'b1;
        end
        32'hc003004: begin
          target_o[0][31:0] = req_i.wdata[31:0];
          target_we_o[0] = 1'b1;
        end
        32'hc003008: begin
          target_o[1][31:0] = req_i.wdata[31:0];
          target_we_o[1] = 1'b1;
        end
        32'hc00300c: begin
          target_o[2][31:0] = req_i.wdata[31:0];
          target_we_o[2] = 1'b1;
        end
        32'hc003010: begin
          target_o[3][31:0] = req_i.wdata[31:0];
          target_we_o[3] = 1'b1;
        end
        32'hc003014: begin
          target_o[4][31:0] = req_i.wdata[31:0];
          target_we_o[4] = 1'b1;
        end
        32'hc003018: begin
          target_o[5][31:0] = req_i.wdata[31:0];
          target_we_o[5] = 1'b1;
        end
        32'hc00301c: begin
          target_o[6][31:0] = req_i.wdata[31:0];
          target_we_o[6] = 1'b1;
        end
        32'hc003020: begin
          target_o[7][31:0] = req_i.wdata[31:0];
          target_we_o[7] = 1'b1;
        end
        32'hc003024: begin
          target_o[8][31:0] = req_i.wdata[31:0];
          target_we_o[8] = 1'b1;
        end
        32'hc003028: begin
          target_o[9][31:0] = req_i.wdata[31:0];
          target_we_o[9] = 1'b1;
        end
        32'hc00302c: begin
          target_o[10][31:0] = req_i.wdata[31:0];
          target_we_o[10] = 1'b1;
        end
        32'hc003030: begin
          target_o[11][31:0] = req_i.wdata[31:0];
          target_we_o[11] = 1'b1;
        end
        32'hc003034: begin
          target_o[12][31:0] = req_i.wdata[31:0];
          target_we_o[12] = 1'b1;
        end
        32'hc003038: begin
          target_o[13][31:0] = req_i.wdata[31:0];
          target_we_o[13] = 1'b1;
        end
        32'hc00303c: begin
          target_o[14][31:0] = req_i.wdata[31:0];
          target_we_o[14] = 1'b1;
        end
        32'hc003040: begin
          target_o[15][31:0] = req_i.wdata[31:0];
          target_we_o[15] = 1'b1;
        end
        32'hc003044: begin
          target_o[16][31:0] = req_i.wdata[31:0];
          target_we_o[16] = 1'b1;
        end
        32'hc003048: begin
          target_o[17][31:0] = req_i.wdata[31:0];
          target_we_o[17] = 1'b1;
        end
        32'hc00304c: begin
          target_o[18][31:0] = req_i.wdata[31:0];
          target_we_o[18] = 1'b1;
        end
        32'hc003050: begin
          target_o[19][31:0] = req_i.wdata[31:0];
          target_we_o[19] = 1'b1;
        end
        32'hc003054: begin
          target_o[20][31:0] = req_i.wdata[31:0];
          target_we_o[20] = 1'b1;
        end
        32'hc003058: begin
          target_o[21][31:0] = req_i.wdata[31:0];
          target_we_o[21] = 1'b1;
        end
        32'hc00305c: begin
          target_o[22][31:0] = req_i.wdata[31:0];
          target_we_o[22] = 1'b1;
        end
        32'hc003060: begin
          target_o[23][31:0] = req_i.wdata[31:0];
          target_we_o[23] = 1'b1;
        end
        32'hc003064: begin
          target_o[24][31:0] = req_i.wdata[31:0];
          target_we_o[24] = 1'b1;
        end
        32'hc003068: begin
          target_o[25][31:0] = req_i.wdata[31:0];
          target_we_o[25] = 1'b1;
        end
        32'hc00306c: begin
          target_o[26][31:0] = req_i.wdata[31:0];
          target_we_o[26] = 1'b1;
        end
        32'hc003070: begin
          target_o[27][31:0] = req_i.wdata[31:0];
          target_we_o[27] = 1'b1;
        end
        32'hc003074: begin
          target_o[28][31:0] = req_i.wdata[31:0];
          target_we_o[28] = 1'b1;
        end
        32'hc003078: begin
          target_o[29][31:0] = req_i.wdata[31:0];
          target_we_o[29] = 1'b1;
        end
        32'hc00307c: begin
          target_o[30][31:0] = req_i.wdata[31:0];
          target_we_o[30] = 1'b1;
        end
        32'hc004000: begin
          idelivery_o[0][0:0] = req_i.wdata[0:0];
          idelivery_we_o[0] = 1'b1;
        end
        32'hc004004: begin
          iforce_o[0][0:0] = req_i.wdata[0:0];
          iforce_we_o[0] = 1'b1;
        end
        32'hc004008: begin
          ithreshold_o[0][2:0] = req_i.wdata[2:0];
          ithreshold_we_o[0] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end else begin
      unique case(req_i.addr)
        32'hc000000: begin
          resp_o.rdata[31:0] = domaincfg_i[0][31:0];
          domaincfg_re_o[0] = 1'b1;
        end
        32'hc000004: begin
          resp_o.rdata[10:0] = sourcecfg_i[0][10:0];
          sourcecfg_re_o[0] = 1'b1;
        end
        32'hc000008: begin
          resp_o.rdata[10:0] = sourcecfg_i[1][10:0];
          sourcecfg_re_o[1] = 1'b1;
        end
        32'hc00000c: begin
          resp_o.rdata[10:0] = sourcecfg_i[2][10:0];
          sourcecfg_re_o[2] = 1'b1;
        end
        32'hc000010: begin
          resp_o.rdata[10:0] = sourcecfg_i[3][10:0];
          sourcecfg_re_o[3] = 1'b1;
        end
        32'hc000014: begin
          resp_o.rdata[10:0] = sourcecfg_i[4][10:0];
          sourcecfg_re_o[4] = 1'b1;
        end
        32'hc000018: begin
          resp_o.rdata[10:0] = sourcecfg_i[5][10:0];
          sourcecfg_re_o[5] = 1'b1;
        end
        32'hc00001c: begin
          resp_o.rdata[10:0] = sourcecfg_i[6][10:0];
          sourcecfg_re_o[6] = 1'b1;
        end
        32'hc000020: begin
          resp_o.rdata[10:0] = sourcecfg_i[7][10:0];
          sourcecfg_re_o[7] = 1'b1;
        end
        32'hc000024: begin
          resp_o.rdata[10:0] = sourcecfg_i[8][10:0];
          sourcecfg_re_o[8] = 1'b1;
        end
        32'hc000028: begin
          resp_o.rdata[10:0] = sourcecfg_i[9][10:0];
          sourcecfg_re_o[9] = 1'b1;
        end
        32'hc00002c: begin
          resp_o.rdata[10:0] = sourcecfg_i[10][10:0];
          sourcecfg_re_o[10] = 1'b1;
        end
        32'hc000030: begin
          resp_o.rdata[10:0] = sourcecfg_i[11][10:0];
          sourcecfg_re_o[11] = 1'b1;
        end
        32'hc000034: begin
          resp_o.rdata[10:0] = sourcecfg_i[12][10:0];
          sourcecfg_re_o[12] = 1'b1;
        end
        32'hc000038: begin
          resp_o.rdata[10:0] = sourcecfg_i[13][10:0];
          sourcecfg_re_o[13] = 1'b1;
        end
        32'hc00003c: begin
          resp_o.rdata[10:0] = sourcecfg_i[14][10:0];
          sourcecfg_re_o[14] = 1'b1;
        end
        32'hc000040: begin
          resp_o.rdata[10:0] = sourcecfg_i[15][10:0];
          sourcecfg_re_o[15] = 1'b1;
        end
        32'hc000044: begin
          resp_o.rdata[10:0] = sourcecfg_i[16][10:0];
          sourcecfg_re_o[16] = 1'b1;
        end
        32'hc000048: begin
          resp_o.rdata[10:0] = sourcecfg_i[17][10:0];
          sourcecfg_re_o[17] = 1'b1;
        end
        32'hc00004c: begin
          resp_o.rdata[10:0] = sourcecfg_i[18][10:0];
          sourcecfg_re_o[18] = 1'b1;
        end
        32'hc000050: begin
          resp_o.rdata[10:0] = sourcecfg_i[19][10:0];
          sourcecfg_re_o[19] = 1'b1;
        end
        32'hc000054: begin
          resp_o.rdata[10:0] = sourcecfg_i[20][10:0];
          sourcecfg_re_o[20] = 1'b1;
        end
        32'hc000058: begin
          resp_o.rdata[10:0] = sourcecfg_i[21][10:0];
          sourcecfg_re_o[21] = 1'b1;
        end
        32'hc00005c: begin
          resp_o.rdata[10:0] = sourcecfg_i[22][10:0];
          sourcecfg_re_o[22] = 1'b1;
        end
        32'hc000060: begin
          resp_o.rdata[10:0] = sourcecfg_i[23][10:0];
          sourcecfg_re_o[23] = 1'b1;
        end
        32'hc000064: begin
          resp_o.rdata[10:0] = sourcecfg_i[24][10:0];
          sourcecfg_re_o[24] = 1'b1;
        end
        32'hc000068: begin
          resp_o.rdata[10:0] = sourcecfg_i[25][10:0];
          sourcecfg_re_o[25] = 1'b1;
        end
        32'hc00006c: begin
          resp_o.rdata[10:0] = sourcecfg_i[26][10:0];
          sourcecfg_re_o[26] = 1'b1;
        end
        32'hc000070: begin
          resp_o.rdata[10:0] = sourcecfg_i[27][10:0];
          sourcecfg_re_o[27] = 1'b1;
        end
        32'hc000074: begin
          resp_o.rdata[10:0] = sourcecfg_i[28][10:0];
          sourcecfg_re_o[28] = 1'b1;
        end
        32'hc000078: begin
          resp_o.rdata[10:0] = sourcecfg_i[29][10:0];
          sourcecfg_re_o[29] = 1'b1;
        end
        32'hc00007c: begin
          resp_o.rdata[10:0] = sourcecfg_i[30][10:0];
          sourcecfg_re_o[30] = 1'b1;
        end
        32'hc001bc0: begin
          resp_o.rdata[31:0] = mmsiaddrcfg_i[0][31:0];
          mmsiaddrcfg_re_o[0] = 1'b1;
        end
        32'hc001bc4: begin
          resp_o.rdata[31:0] = mmsiaddrcfgh_i[0][31:0];
          mmsiaddrcfgh_re_o[0] = 1'b1;
        end
        32'hc001bc8: begin
          resp_o.rdata[31:0] = smsiaddrcfg_i[0][31:0];
          smsiaddrcfg_re_o[0] = 1'b1;
        end
        32'hc001bcc: begin
          resp_o.rdata[31:0] = smsiaddrcfgh_i[0][31:0];
          smsiaddrcfgh_re_o[0] = 1'b1;
        end
        32'hc001c00: begin
          resp_o.rdata[30:0] = setip_i[0][30:0];
          setip_re_o[0] = 1'b1;
        end
        32'hc001cdc: begin
          resp_o.rdata[31:0] = setipnum_i[0][31:0];
          setipnum_re_o[0] = 1'b1;
        end
        32'hc001d00: begin
          resp_o.rdata[30:0] = in_clrip_i[0][30:0];
          in_clrip_re_o[0] = 1'b1;
        end
        32'hc001ddc: begin
          resp_o.rdata[31:0] = clripnum_i[0][31:0];
          clripnum_re_o[0] = 1'b1;
        end
        32'hc001e00: begin
          resp_o.rdata[30:0] = setie_i[0][30:0];
          setie_re_o[0] = 1'b1;
        end
        32'hc001edc: begin
          resp_o.rdata[31:0] = setienum_i[0][31:0];
          setienum_re_o[0] = 1'b1;
        end
        32'hc001f00: begin
          resp_o.rdata[30:0] = clrie_i[0][30:0];
          clrie_re_o[0] = 1'b1;
        end
        32'hc001fdc: begin
          resp_o.rdata[31:0] = clrienum_i[0][31:0];
          clrienum_re_o[0] = 1'b1;
        end
        32'hc002000: begin
          resp_o.rdata[31:0] = setipnum_le_i[0][31:0];
          setipnum_le_re_o[0] = 1'b1;
        end
        32'hc002004: begin
          resp_o.rdata[31:0] = setipnum_be_i[0][31:0];
          setipnum_be_re_o[0] = 1'b1;
        end
        32'hc003000: begin
          resp_o.rdata[31:0] = genmsi_i[0][31:0];
          genmsi_re_o[0] = 1'b1;
        end
        32'hc003004: begin
          resp_o.rdata[31:0] = target_i[0][31:0];
          target_re_o[0] = 1'b1;
        end
        32'hc003008: begin
          resp_o.rdata[31:0] = target_i[1][31:0];
          target_re_o[1] = 1'b1;
        end
        32'hc00300c: begin
          resp_o.rdata[31:0] = target_i[2][31:0];
          target_re_o[2] = 1'b1;
        end
        32'hc003010: begin
          resp_o.rdata[31:0] = target_i[3][31:0];
          target_re_o[3] = 1'b1;
        end
        32'hc003014: begin
          resp_o.rdata[31:0] = target_i[4][31:0];
          target_re_o[4] = 1'b1;
        end
        32'hc003018: begin
          resp_o.rdata[31:0] = target_i[5][31:0];
          target_re_o[5] = 1'b1;
        end
        32'hc00301c: begin
          resp_o.rdata[31:0] = target_i[6][31:0];
          target_re_o[6] = 1'b1;
        end
        32'hc003020: begin
          resp_o.rdata[31:0] = target_i[7][31:0];
          target_re_o[7] = 1'b1;
        end
        32'hc003024: begin
          resp_o.rdata[31:0] = target_i[8][31:0];
          target_re_o[8] = 1'b1;
        end
        32'hc003028: begin
          resp_o.rdata[31:0] = target_i[9][31:0];
          target_re_o[9] = 1'b1;
        end
        32'hc00302c: begin
          resp_o.rdata[31:0] = target_i[10][31:0];
          target_re_o[10] = 1'b1;
        end
        32'hc003030: begin
          resp_o.rdata[31:0] = target_i[11][31:0];
          target_re_o[11] = 1'b1;
        end
        32'hc003034: begin
          resp_o.rdata[31:0] = target_i[12][31:0];
          target_re_o[12] = 1'b1;
        end
        32'hc003038: begin
          resp_o.rdata[31:0] = target_i[13][31:0];
          target_re_o[13] = 1'b1;
        end
        32'hc00303c: begin
          resp_o.rdata[31:0] = target_i[14][31:0];
          target_re_o[14] = 1'b1;
        end
        32'hc003040: begin
          resp_o.rdata[31:0] = target_i[15][31:0];
          target_re_o[15] = 1'b1;
        end
        32'hc003044: begin
          resp_o.rdata[31:0] = target_i[16][31:0];
          target_re_o[16] = 1'b1;
        end
        32'hc003048: begin
          resp_o.rdata[31:0] = target_i[17][31:0];
          target_re_o[17] = 1'b1;
        end
        32'hc00304c: begin
          resp_o.rdata[31:0] = target_i[18][31:0];
          target_re_o[18] = 1'b1;
        end
        32'hc003050: begin
          resp_o.rdata[31:0] = target_i[19][31:0];
          target_re_o[19] = 1'b1;
        end
        32'hc003054: begin
          resp_o.rdata[31:0] = target_i[20][31:0];
          target_re_o[20] = 1'b1;
        end
        32'hc003058: begin
          resp_o.rdata[31:0] = target_i[21][31:0];
          target_re_o[21] = 1'b1;
        end
        32'hc00305c: begin
          resp_o.rdata[31:0] = target_i[22][31:0];
          target_re_o[22] = 1'b1;
        end
        32'hc003060: begin
          resp_o.rdata[31:0] = target_i[23][31:0];
          target_re_o[23] = 1'b1;
        end
        32'hc003064: begin
          resp_o.rdata[31:0] = target_i[24][31:0];
          target_re_o[24] = 1'b1;
        end
        32'hc003068: begin
          resp_o.rdata[31:0] = target_i[25][31:0];
          target_re_o[25] = 1'b1;
        end
        32'hc00306c: begin
          resp_o.rdata[31:0] = target_i[26][31:0];
          target_re_o[26] = 1'b1;
        end
        32'hc003070: begin
          resp_o.rdata[31:0] = target_i[27][31:0];
          target_re_o[27] = 1'b1;
        end
        32'hc003074: begin
          resp_o.rdata[31:0] = target_i[28][31:0];
          target_re_o[28] = 1'b1;
        end
        32'hc003078: begin
          resp_o.rdata[31:0] = target_i[29][31:0];
          target_re_o[29] = 1'b1;
        end
        32'hc00307c: begin
          resp_o.rdata[31:0] = target_i[30][31:0];
          target_re_o[30] = 1'b1;
        end
        32'hc004000: begin
          resp_o.rdata[0:0] = idelivery_i[0][0:0];
          idelivery_re_o[0] = 1'b1;
        end
        32'hc004004: begin
          resp_o.rdata[0:0] = iforce_i[0][0:0];
          iforce_re_o[0] = 1'b1;
        end
        32'hc004008: begin
          resp_o.rdata[2:0] = ithreshold_i[0][2:0];
          ithreshold_re_o[0] = 1'b1;
        end
        32'hc004018: begin
          resp_o.rdata[24:0] = topi_i[0][24:0];
          topi_re_o[0] = 1'b1;
        end
        32'hc00401c: begin
          resp_o.rdata[24:0] = claimi_i[0][24:0];
          claimi_re_o[0] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end
  end
end
endmodule

