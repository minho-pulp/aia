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
        32'hd000000: begin
          domaincfg_o[0][31:0] = req_i.wdata[31:0];
          domaincfg_we_o[0] = 1'b1;
        end
        32'hd000004: begin
          sourcecfg_o[0][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[0] = 1'b1;
        end
        32'hd000008: begin
          sourcecfg_o[1][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[1] = 1'b1;
        end
        32'hd00000c: begin
          sourcecfg_o[2][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[2] = 1'b1;
        end
        32'hd000010: begin
          sourcecfg_o[3][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[3] = 1'b1;
        end
        32'hd000014: begin
          sourcecfg_o[4][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[4] = 1'b1;
        end
        32'hd000018: begin
          sourcecfg_o[5][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[5] = 1'b1;
        end
        32'hd00001c: begin
          sourcecfg_o[6][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[6] = 1'b1;
        end
        32'hd000020: begin
          sourcecfg_o[7][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[7] = 1'b1;
        end
        32'hd000024: begin
          sourcecfg_o[8][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[8] = 1'b1;
        end
        32'hd000028: begin
          sourcecfg_o[9][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[9] = 1'b1;
        end
        32'hd00002c: begin
          sourcecfg_o[10][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[10] = 1'b1;
        end
        32'hd000030: begin
          sourcecfg_o[11][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[11] = 1'b1;
        end
        32'hd000034: begin
          sourcecfg_o[12][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[12] = 1'b1;
        end
        32'hd000038: begin
          sourcecfg_o[13][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[13] = 1'b1;
        end
        32'hd00003c: begin
          sourcecfg_o[14][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[14] = 1'b1;
        end
        32'hd000040: begin
          sourcecfg_o[15][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[15] = 1'b1;
        end
        32'hd000044: begin
          sourcecfg_o[16][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[16] = 1'b1;
        end
        32'hd000048: begin
          sourcecfg_o[17][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[17] = 1'b1;
        end
        32'hd00004c: begin
          sourcecfg_o[18][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[18] = 1'b1;
        end
        32'hd000050: begin
          sourcecfg_o[19][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[19] = 1'b1;
        end
        32'hd000054: begin
          sourcecfg_o[20][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[20] = 1'b1;
        end
        32'hd000058: begin
          sourcecfg_o[21][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[21] = 1'b1;
        end
        32'hd00005c: begin
          sourcecfg_o[22][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[22] = 1'b1;
        end
        32'hd000060: begin
          sourcecfg_o[23][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[23] = 1'b1;
        end
        32'hd000064: begin
          sourcecfg_o[24][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[24] = 1'b1;
        end
        32'hd000068: begin
          sourcecfg_o[25][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[25] = 1'b1;
        end
        32'hd00006c: begin
          sourcecfg_o[26][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[26] = 1'b1;
        end
        32'hd000070: begin
          sourcecfg_o[27][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[27] = 1'b1;
        end
        32'hd000074: begin
          sourcecfg_o[28][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[28] = 1'b1;
        end
        32'hd000078: begin
          sourcecfg_o[29][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[29] = 1'b1;
        end
        32'hd00007c: begin
          sourcecfg_o[30][10:0] = req_i.wdata[10:0];
          sourcecfg_we_o[30] = 1'b1;
        end
        32'hd001c00: begin
          setip_o[0][30:0] = req_i.wdata[30:0];
          setip_we_o[0] = 1'b1;
        end
        32'hd001cdc: begin
          setipnum_o[0][31:0] = req_i.wdata[31:0];
          setipnum_we_o[0] = 1'b1;
        end
        32'hd001d00: begin
          in_clrip_o[0][30:0] = req_i.wdata[30:0];
          in_clrip_we_o[0] = 1'b1;
        end
        32'hd001ddc: begin
          clripnum_o[0][31:0] = req_i.wdata[31:0];
          clripnum_we_o[0] = 1'b1;
        end
        32'hd001e00: begin
          setie_o[0][30:0] = req_i.wdata[30:0];
          setie_we_o[0] = 1'b1;
        end
        32'hd001edc: begin
          setienum_o[0][31:0] = req_i.wdata[31:0];
          setienum_we_o[0] = 1'b1;
        end
        32'hd001f00: begin
          clrie_o[0][30:0] = req_i.wdata[30:0];
          clrie_we_o[0] = 1'b1;
        end
        32'hd001fdc: begin
          clrienum_o[0][31:0] = req_i.wdata[31:0];
          clrienum_we_o[0] = 1'b1;
        end
        32'hd002000: begin
          setipnum_le_o[0][31:0] = req_i.wdata[31:0];
          setipnum_le_we_o[0] = 1'b1;
        end
        32'hd002004: begin
          setipnum_be_o[0][31:0] = req_i.wdata[31:0];
          setipnum_be_we_o[0] = 1'b1;
        end
        32'hd003000: begin
          genmsi_o[0][31:0] = req_i.wdata[31:0];
          genmsi_we_o[0] = 1'b1;
        end
        32'hd003004: begin
          target_o[0][31:0] = req_i.wdata[31:0];
          target_we_o[0] = 1'b1;
        end
        32'hd003008: begin
          target_o[1][31:0] = req_i.wdata[31:0];
          target_we_o[1] = 1'b1;
        end
        32'hd00300c: begin
          target_o[2][31:0] = req_i.wdata[31:0];
          target_we_o[2] = 1'b1;
        end
        32'hd003010: begin
          target_o[3][31:0] = req_i.wdata[31:0];
          target_we_o[3] = 1'b1;
        end
        32'hd003014: begin
          target_o[4][31:0] = req_i.wdata[31:0];
          target_we_o[4] = 1'b1;
        end
        32'hd003018: begin
          target_o[5][31:0] = req_i.wdata[31:0];
          target_we_o[5] = 1'b1;
        end
        32'hd00301c: begin
          target_o[6][31:0] = req_i.wdata[31:0];
          target_we_o[6] = 1'b1;
        end
        32'hd003020: begin
          target_o[7][31:0] = req_i.wdata[31:0];
          target_we_o[7] = 1'b1;
        end
        32'hd003024: begin
          target_o[8][31:0] = req_i.wdata[31:0];
          target_we_o[8] = 1'b1;
        end
        32'hd003028: begin
          target_o[9][31:0] = req_i.wdata[31:0];
          target_we_o[9] = 1'b1;
        end
        32'hd00302c: begin
          target_o[10][31:0] = req_i.wdata[31:0];
          target_we_o[10] = 1'b1;
        end
        32'hd003030: begin
          target_o[11][31:0] = req_i.wdata[31:0];
          target_we_o[11] = 1'b1;
        end
        32'hd003034: begin
          target_o[12][31:0] = req_i.wdata[31:0];
          target_we_o[12] = 1'b1;
        end
        32'hd003038: begin
          target_o[13][31:0] = req_i.wdata[31:0];
          target_we_o[13] = 1'b1;
        end
        32'hd00303c: begin
          target_o[14][31:0] = req_i.wdata[31:0];
          target_we_o[14] = 1'b1;
        end
        32'hd003040: begin
          target_o[15][31:0] = req_i.wdata[31:0];
          target_we_o[15] = 1'b1;
        end
        32'hd003044: begin
          target_o[16][31:0] = req_i.wdata[31:0];
          target_we_o[16] = 1'b1;
        end
        32'hd003048: begin
          target_o[17][31:0] = req_i.wdata[31:0];
          target_we_o[17] = 1'b1;
        end
        32'hd00304c: begin
          target_o[18][31:0] = req_i.wdata[31:0];
          target_we_o[18] = 1'b1;
        end
        32'hd003050: begin
          target_o[19][31:0] = req_i.wdata[31:0];
          target_we_o[19] = 1'b1;
        end
        32'hd003054: begin
          target_o[20][31:0] = req_i.wdata[31:0];
          target_we_o[20] = 1'b1;
        end
        32'hd003058: begin
          target_o[21][31:0] = req_i.wdata[31:0];
          target_we_o[21] = 1'b1;
        end
        32'hd00305c: begin
          target_o[22][31:0] = req_i.wdata[31:0];
          target_we_o[22] = 1'b1;
        end
        32'hd003060: begin
          target_o[23][31:0] = req_i.wdata[31:0];
          target_we_o[23] = 1'b1;
        end
        32'hd003064: begin
          target_o[24][31:0] = req_i.wdata[31:0];
          target_we_o[24] = 1'b1;
        end
        32'hd003068: begin
          target_o[25][31:0] = req_i.wdata[31:0];
          target_we_o[25] = 1'b1;
        end
        32'hd00306c: begin
          target_o[26][31:0] = req_i.wdata[31:0];
          target_we_o[26] = 1'b1;
        end
        32'hd003070: begin
          target_o[27][31:0] = req_i.wdata[31:0];
          target_we_o[27] = 1'b1;
        end
        32'hd003074: begin
          target_o[28][31:0] = req_i.wdata[31:0];
          target_we_o[28] = 1'b1;
        end
        32'hd003078: begin
          target_o[29][31:0] = req_i.wdata[31:0];
          target_we_o[29] = 1'b1;
        end
        32'hd00307c: begin
          target_o[30][31:0] = req_i.wdata[31:0];
          target_we_o[30] = 1'b1;
        end
        32'hd004000: begin
          idelivery_o[0][0:0] = req_i.wdata[0:0];
          idelivery_we_o[0] = 1'b1;
        end
        32'hd004004: begin
          iforce_o[0][0:0] = req_i.wdata[0:0];
          iforce_we_o[0] = 1'b1;
        end
        32'hd004008: begin
          ithreshold_o[0][2:0] = req_i.wdata[2:0];
          ithreshold_we_o[0] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end else begin
      unique case(req_i.addr)
        32'hd000000: begin
          resp_o.rdata[31:0] = domaincfg_i[0][31:0];
          domaincfg_re_o[0] = 1'b1;
        end
        32'hd000004: begin
          resp_o.rdata[10:0] = sourcecfg_i[0][10:0];
          sourcecfg_re_o[0] = 1'b1;
        end
        32'hd000008: begin
          resp_o.rdata[10:0] = sourcecfg_i[1][10:0];
          sourcecfg_re_o[1] = 1'b1;
        end
        32'hd00000c: begin
          resp_o.rdata[10:0] = sourcecfg_i[2][10:0];
          sourcecfg_re_o[2] = 1'b1;
        end
        32'hd000010: begin
          resp_o.rdata[10:0] = sourcecfg_i[3][10:0];
          sourcecfg_re_o[3] = 1'b1;
        end
        32'hd000014: begin
          resp_o.rdata[10:0] = sourcecfg_i[4][10:0];
          sourcecfg_re_o[4] = 1'b1;
        end
        32'hd000018: begin
          resp_o.rdata[10:0] = sourcecfg_i[5][10:0];
          sourcecfg_re_o[5] = 1'b1;
        end
        32'hd00001c: begin
          resp_o.rdata[10:0] = sourcecfg_i[6][10:0];
          sourcecfg_re_o[6] = 1'b1;
        end
        32'hd000020: begin
          resp_o.rdata[10:0] = sourcecfg_i[7][10:0];
          sourcecfg_re_o[7] = 1'b1;
        end
        32'hd000024: begin
          resp_o.rdata[10:0] = sourcecfg_i[8][10:0];
          sourcecfg_re_o[8] = 1'b1;
        end
        32'hd000028: begin
          resp_o.rdata[10:0] = sourcecfg_i[9][10:0];
          sourcecfg_re_o[9] = 1'b1;
        end
        32'hd00002c: begin
          resp_o.rdata[10:0] = sourcecfg_i[10][10:0];
          sourcecfg_re_o[10] = 1'b1;
        end
        32'hd000030: begin
          resp_o.rdata[10:0] = sourcecfg_i[11][10:0];
          sourcecfg_re_o[11] = 1'b1;
        end
        32'hd000034: begin
          resp_o.rdata[10:0] = sourcecfg_i[12][10:0];
          sourcecfg_re_o[12] = 1'b1;
        end
        32'hd000038: begin
          resp_o.rdata[10:0] = sourcecfg_i[13][10:0];
          sourcecfg_re_o[13] = 1'b1;
        end
        32'hd00003c: begin
          resp_o.rdata[10:0] = sourcecfg_i[14][10:0];
          sourcecfg_re_o[14] = 1'b1;
        end
        32'hd000040: begin
          resp_o.rdata[10:0] = sourcecfg_i[15][10:0];
          sourcecfg_re_o[15] = 1'b1;
        end
        32'hd000044: begin
          resp_o.rdata[10:0] = sourcecfg_i[16][10:0];
          sourcecfg_re_o[16] = 1'b1;
        end
        32'hd000048: begin
          resp_o.rdata[10:0] = sourcecfg_i[17][10:0];
          sourcecfg_re_o[17] = 1'b1;
        end
        32'hd00004c: begin
          resp_o.rdata[10:0] = sourcecfg_i[18][10:0];
          sourcecfg_re_o[18] = 1'b1;
        end
        32'hd000050: begin
          resp_o.rdata[10:0] = sourcecfg_i[19][10:0];
          sourcecfg_re_o[19] = 1'b1;
        end
        32'hd000054: begin
          resp_o.rdata[10:0] = sourcecfg_i[20][10:0];
          sourcecfg_re_o[20] = 1'b1;
        end
        32'hd000058: begin
          resp_o.rdata[10:0] = sourcecfg_i[21][10:0];
          sourcecfg_re_o[21] = 1'b1;
        end
        32'hd00005c: begin
          resp_o.rdata[10:0] = sourcecfg_i[22][10:0];
          sourcecfg_re_o[22] = 1'b1;
        end
        32'hd000060: begin
          resp_o.rdata[10:0] = sourcecfg_i[23][10:0];
          sourcecfg_re_o[23] = 1'b1;
        end
        32'hd000064: begin
          resp_o.rdata[10:0] = sourcecfg_i[24][10:0];
          sourcecfg_re_o[24] = 1'b1;
        end
        32'hd000068: begin
          resp_o.rdata[10:0] = sourcecfg_i[25][10:0];
          sourcecfg_re_o[25] = 1'b1;
        end
        32'hd00006c: begin
          resp_o.rdata[10:0] = sourcecfg_i[26][10:0];
          sourcecfg_re_o[26] = 1'b1;
        end
        32'hd000070: begin
          resp_o.rdata[10:0] = sourcecfg_i[27][10:0];
          sourcecfg_re_o[27] = 1'b1;
        end
        32'hd000074: begin
          resp_o.rdata[10:0] = sourcecfg_i[28][10:0];
          sourcecfg_re_o[28] = 1'b1;
        end
        32'hd000078: begin
          resp_o.rdata[10:0] = sourcecfg_i[29][10:0];
          sourcecfg_re_o[29] = 1'b1;
        end
        32'hd00007c: begin
          resp_o.rdata[10:0] = sourcecfg_i[30][10:0];
          sourcecfg_re_o[30] = 1'b1;
        end
        32'hd001c00: begin
          resp_o.rdata[30:0] = setip_i[0][30:0];
          setip_re_o[0] = 1'b1;
        end
        32'hd001cdc: begin
          resp_o.rdata[31:0] = setipnum_i[0][31:0];
          setipnum_re_o[0] = 1'b1;
        end
        32'hd001d00: begin
          resp_o.rdata[30:0] = in_clrip_i[0][30:0];
          in_clrip_re_o[0] = 1'b1;
        end
        32'hd001ddc: begin
          resp_o.rdata[31:0] = clripnum_i[0][31:0];
          clripnum_re_o[0] = 1'b1;
        end
        32'hd001e00: begin
          resp_o.rdata[30:0] = setie_i[0][30:0];
          setie_re_o[0] = 1'b1;
        end
        32'hd001edc: begin
          resp_o.rdata[31:0] = setienum_i[0][31:0];
          setienum_re_o[0] = 1'b1;
        end
        32'hd001f00: begin
          resp_o.rdata[30:0] = clrie_i[0][30:0];
          clrie_re_o[0] = 1'b1;
        end
        32'hd001fdc: begin
          resp_o.rdata[31:0] = clrienum_i[0][31:0];
          clrienum_re_o[0] = 1'b1;
        end
        32'hd002000: begin
          resp_o.rdata[31:0] = setipnum_le_i[0][31:0];
          setipnum_le_re_o[0] = 1'b1;
        end
        32'hd002004: begin
          resp_o.rdata[31:0] = setipnum_be_i[0][31:0];
          setipnum_be_re_o[0] = 1'b1;
        end
        32'hd003000: begin
          resp_o.rdata[31:0] = genmsi_i[0][31:0];
          genmsi_re_o[0] = 1'b1;
        end
        32'hd003004: begin
          resp_o.rdata[31:0] = target_i[0][31:0];
          target_re_o[0] = 1'b1;
        end
        32'hd003008: begin
          resp_o.rdata[31:0] = target_i[1][31:0];
          target_re_o[1] = 1'b1;
        end
        32'hd00300c: begin
          resp_o.rdata[31:0] = target_i[2][31:0];
          target_re_o[2] = 1'b1;
        end
        32'hd003010: begin
          resp_o.rdata[31:0] = target_i[3][31:0];
          target_re_o[3] = 1'b1;
        end
        32'hd003014: begin
          resp_o.rdata[31:0] = target_i[4][31:0];
          target_re_o[4] = 1'b1;
        end
        32'hd003018: begin
          resp_o.rdata[31:0] = target_i[5][31:0];
          target_re_o[5] = 1'b1;
        end
        32'hd00301c: begin
          resp_o.rdata[31:0] = target_i[6][31:0];
          target_re_o[6] = 1'b1;
        end
        32'hd003020: begin
          resp_o.rdata[31:0] = target_i[7][31:0];
          target_re_o[7] = 1'b1;
        end
        32'hd003024: begin
          resp_o.rdata[31:0] = target_i[8][31:0];
          target_re_o[8] = 1'b1;
        end
        32'hd003028: begin
          resp_o.rdata[31:0] = target_i[9][31:0];
          target_re_o[9] = 1'b1;
        end
        32'hd00302c: begin
          resp_o.rdata[31:0] = target_i[10][31:0];
          target_re_o[10] = 1'b1;
        end
        32'hd003030: begin
          resp_o.rdata[31:0] = target_i[11][31:0];
          target_re_o[11] = 1'b1;
        end
        32'hd003034: begin
          resp_o.rdata[31:0] = target_i[12][31:0];
          target_re_o[12] = 1'b1;
        end
        32'hd003038: begin
          resp_o.rdata[31:0] = target_i[13][31:0];
          target_re_o[13] = 1'b1;
        end
        32'hd00303c: begin
          resp_o.rdata[31:0] = target_i[14][31:0];
          target_re_o[14] = 1'b1;
        end
        32'hd003040: begin
          resp_o.rdata[31:0] = target_i[15][31:0];
          target_re_o[15] = 1'b1;
        end
        32'hd003044: begin
          resp_o.rdata[31:0] = target_i[16][31:0];
          target_re_o[16] = 1'b1;
        end
        32'hd003048: begin
          resp_o.rdata[31:0] = target_i[17][31:0];
          target_re_o[17] = 1'b1;
        end
        32'hd00304c: begin
          resp_o.rdata[31:0] = target_i[18][31:0];
          target_re_o[18] = 1'b1;
        end
        32'hd003050: begin
          resp_o.rdata[31:0] = target_i[19][31:0];
          target_re_o[19] = 1'b1;
        end
        32'hd003054: begin
          resp_o.rdata[31:0] = target_i[20][31:0];
          target_re_o[20] = 1'b1;
        end
        32'hd003058: begin
          resp_o.rdata[31:0] = target_i[21][31:0];
          target_re_o[21] = 1'b1;
        end
        32'hd00305c: begin
          resp_o.rdata[31:0] = target_i[22][31:0];
          target_re_o[22] = 1'b1;
        end
        32'hd003060: begin
          resp_o.rdata[31:0] = target_i[23][31:0];
          target_re_o[23] = 1'b1;
        end
        32'hd003064: begin
          resp_o.rdata[31:0] = target_i[24][31:0];
          target_re_o[24] = 1'b1;
        end
        32'hd003068: begin
          resp_o.rdata[31:0] = target_i[25][31:0];
          target_re_o[25] = 1'b1;
        end
        32'hd00306c: begin
          resp_o.rdata[31:0] = target_i[26][31:0];
          target_re_o[26] = 1'b1;
        end
        32'hd003070: begin
          resp_o.rdata[31:0] = target_i[27][31:0];
          target_re_o[27] = 1'b1;
        end
        32'hd003074: begin
          resp_o.rdata[31:0] = target_i[28][31:0];
          target_re_o[28] = 1'b1;
        end
        32'hd003078: begin
          resp_o.rdata[31:0] = target_i[29][31:0];
          target_re_o[29] = 1'b1;
        end
        32'hd00307c: begin
          resp_o.rdata[31:0] = target_i[30][31:0];
          target_re_o[30] = 1'b1;
        end
        32'hd004000: begin
          resp_o.rdata[0:0] = idelivery_i[0][0:0];
          idelivery_re_o[0] = 1'b1;
        end
        32'hd004004: begin
          resp_o.rdata[0:0] = iforce_i[0][0:0];
          iforce_re_o[0] = 1'b1;
        end
        32'hd004008: begin
          resp_o.rdata[2:0] = ithreshold_i[0][2:0];
          ithreshold_re_o[0] = 1'b1;
        end
        32'hd004018: begin
          resp_o.rdata[24:0] = topi_i[0][24:0];
          topi_re_o[0] = 1'b1;
        end
        32'hd00401c: begin
          resp_o.rdata[24:0] = claimi_i[0][24:0];
          claimi_re_o[0] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end
  end
end
endmodule

