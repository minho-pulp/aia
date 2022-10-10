// This module only implements direct mode (04/10/2022)
module aplic_domain_notifier #(
    parameter int   NR_SRC      = 32,
    parameter int   NR_BITS_SRC = (NR_SRC > 31)? 32:NR_SRC,
    parameter int   NR_REG = (NR_SRC-1)/32,
    parameter int   NR_IDC      = 1,
    parameter       MODE        = "DIRECT"
) (
    input   logic                                   i_clk,
    input   logic                                   ni_rst,
    input   logic                                   i_domaincfgIE,
    input   logic [NR_REG:0][NR_BITS_SRC-1:0]       i_setip_q,
    input   logic [NR_REG:0][NR_BITS_SRC-1:0]       i_setie_q,
    input   logic [NR_SRC-1:0][31:0]                i_target_q,
    /**  interface for direct mode */
    input   logic [NR_IDC-1:0][0:0]                 i_idelivery,
    input   logic [NR_IDC-1:0][0:0]                 i_iforce,
    input   logic [NR_IDC-1:0][2:0]                 i_ithreshold,
    input   logic [NR_IDC-1:0][25:0]                i_topi,
    input   logic [NR_IDC-1:0][25:0]                i_claimi,
    output  logic [NR_IDC-1:0][25:0]                o_topi_sugg,
    output  logic                                   o_topi_update,
    output  logic [NR_IDC-1:0]                      o_Xeip_targets //,
    /** interface for MSI mode */
    // input   logic [31:0]                            i_mmsiaddrcfg,
    // input   logic [31:0]                            i_mmsiaddrcfgh,
    // input   logic [31:0]                            i_smsiaddrcfg,
    // input   logic [31:0]                            i_smsiaddrcfgh
    // Outputs for MSI interface here
);

localparam DOMAINCFG_IE = 8;
localparam NR_IDC_W     = (NR_IDC == 1) ? 1 : $clog2(NR_IDC);

logic [NR_IDC-1:0]      has_valid_intp_i;
logic [NR_IDC_W-1:0]    hart_index_i;

if(MODE == "DIRECT") begin
    /** Detect highest pending-enabled interrut and discover hart index*/
    always_comb begin
        for (int i = NR_SRC-1 ; i >= 0 ; i--) begin
            has_valid_intp_i[hart_index_i] = 1'b0;
            /** If the interrupt is pending and enabled*/
            if ((i_setip_q[i/32][i%32] & i_setie_q[i/32][i%32]) == 1'b1) begin
                hart_index_i = target[i][31:18];
                if(i_target_q[i][7:0] < i_ithreshold[target[i][31:18]]) begin
                    has_valid_intp_i[hart_index_i] = 1'b1;
                    o_topi_sugg[25:16]  = i;
                    o_topi_sugg[7:0]    = i_target[i][7:0];
                end
            end
        end 
    end

    /** Update outputs with IDC validation */
        assign o_Xeip_targets[i] = i_domaincfgIE & i_idelivery[i] & 
    end
end

endmodule