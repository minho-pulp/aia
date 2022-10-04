//
module aplic_top #(
   /** Number of external interrupts */
   parameter int                           N_SOURCE = 30,
   /** There is one IDC per hart index connected to the APLIC */
   parameter int                           N_IDCs = 1
) (
   input  logic                            i_clk,
   input  logic                            ni_rst,
   input  logic [N_SOURCE:0]               i_sources,
   /** APLIC domain interface 1*/
   input  reg_intf::reg_intf_req_a32_d32   i_req_1,
   output reg_intf::reg_intf_resp_d32      o_resp_1,
   /** APLIC domain interface 2*/
   input  reg_intf::reg_intf_req_a32_d32   i_req_2,
   output reg_intf::reg_intf_resp_d32      o_resp_2,
   /** Interrupt Notification to Targets. One per priv. level. */
   output logic [(N_IDCs*2)-1:0]           o_Xeip_targets
); /** End of APLIC top interface */

/** Insert Code Here */

endmodule

