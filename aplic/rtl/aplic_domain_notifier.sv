// This module only implements direct mode (04/10/2022)
module aplic_domain_notifier #(
    parameter int   NR_SRC          = 32,
    parameter int   NR_BITS_SRC     = (NR_SRC > 31)? 32:NR_SRC,
    parameter int   NR_REG          = (NR_SRC-1)/32,
    parameter int   NR_IDC          = 1,
    parameter int   MIN_PRIO        = 7,
    parameter int   IPRIOLEN        = (MIN_PRIO == 1) ? 1 : $clog2(MIN_PRIO),   
    parameter       MODE            = "DIRECT"
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
    input   logic [NR_IDC-1:0][IPRIOLEN-1:0]        i_ithreshold,
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

localparam DOMAINCFG_IE     = 8;
localparam TARGET_HART_IDX  = 18;
localparam NR_IDC_W         = (NR_IDC == 1) ? 1 : $clog2(NR_IDC);

logic [NR_IDC-1:0]          has_valid_intp_i;
logic [NR_IDC_W-1:0]        hart_index_i;
logic [IPRIOLEN-1:0]        prev_higher_i;

if(MODE == "DIRECT") begin
    /** Detect highest pending-enabled interrut and discover hart index*/
    always_comb begin
        prev_higher_i = 3'b111;
        for (int i = NR_SRC-1 ; i > 0 ; i--) begin
            hart_index_i = i_target_q[i][TARGET_HART_IDX +: NR_IDC_W];
            /** If the interrupt is pending and enabled*/
            if (i_setip_q[i/32][i%32] && i_setie_q[i/32][i%32]) begin
                /** Is the interrupt able to contribute to IDC interrupt? */
                /** "interrupt sources with priority numbers P and higher DO NOT
                *   contribute to signaling interrupts to the hart" 
                *   If threshold is 0 all insterrupt can contribute 
                *   Finally check if the current pend/en intp has a higher (smaller number)
                *   priority than the previous pend/en intp. */
                if(((i_target_q[i][2:0] < i_ithreshold[i_target_q[i][TARGET_HART_IDX +: NR_IDC_W]]) || 
                    (i_ithreshold[i_target_q[i][TARGET_HART_IDX +: NR_IDC_W]] == 0)) &&
                    (i_target_q[i][IPRIOLEN-1:0] < prev_higher_i[IPRIOLEN-1:0])) begin
                    has_valid_intp_i[hart_index_i] = 1'b1;
                    prev_higher_i                  = i_target_q[i][IPRIOLEN-1:0];
                    o_topi_sugg[hart_index_i]      = {i[9:0], 8'b0, i_target_q[i][7:0]};
                end
            end
        end 
    end

    /** Update outputs with IDC validation */
    for (genvar i = 0; i < NR_IDC; i++) begin
        assign o_Xeip_targets[i] = i_domaincfgIE & i_idelivery[i] & 
                                   (has_valid_intp_i[i] | i_iforce[i]);
        assign o_topi_update = has_valid_intp_i[i];
    end
end

endmodule