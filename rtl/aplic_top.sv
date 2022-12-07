//
module aplic_top #(
   /** Number of external interrupts */
   parameter int                           NR_SRC = 32,
   parameter int                           MIN_PRIO = 6,
   /** There is one IDC per hart index connected to the APLIC */
   parameter int                           NR_IDCs = 1
) (
   input  logic                            i_clk,
   input  logic                            ni_rst,
   input  logic [NR_SRC-1:0]               i_irq_sources,
   /** APLIC domain interface 1*/
   input  reg_intf::reg_intf_req_a32_d32   i_req_1,
   output reg_intf::reg_intf_resp_d32      o_resp_1,
   /** APLIC domain interface 2*/
   input  reg_intf::reg_intf_req_a32_d32   i_req_2,
   output reg_intf::reg_intf_resp_d32      o_resp_2,
   /** Interrupt Notification to Targets. One per priv. level. */
   output logic [(NR_IDCs*2)-1:0]           o_Xeip_targets
); /** End of APLIC top interface */

logic [NR_SRC-1:0] irq_del_sources_i;

/** Insert Code Here */
aplic_domain_top #(
   .DOMAIN_ADDR(32'hc000000),
   .NR_SRC(NR_SRC),
   .NR_IDCs(NR_IDCs),
   .MIN_PRIO(MIN_PRIO),
   .APLIC("NON-LEAF"),
   .MODE("DIRECT")
) i_aplic_m_domain_top(
   .i_clk(i_clk),
   .ni_rst(ni_rst),
   .i_req(i_req_1),
   .o_resp(o_resp_1),
   .i_irq_sources(i_irq_sources),
   .o_irq_del_sources(irq_del_sources_i),
   .o_Xeip_targets(o_Xeip_targets[NR_IDCs-1:0])
);

aplic_domain_top #(
   .DOMAIN_ADDR(32'hd000000),
   .NR_SRC(NR_SRC),
   .NR_IDCs(NR_IDCs),
   .MIN_PRIO(MIN_PRIO),
   .APLIC("LEAF"),
   .MODE("DIRECT")
) i_aplic_s_domain_top(
   .i_clk(i_clk),
   .ni_rst(ni_rst),
   .i_req(i_req_2),
   .o_resp(o_resp_2),
   .i_irq_sources(irq_del_sources_i),
   .o_irq_del_sources(),
   .o_Xeip_targets(o_Xeip_targets[(NR_IDCs*2)-1:NR_IDCs])
);

endmodule