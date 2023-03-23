/** 
*   Name: APLIC domain register map (generic)
*   Date: 2022-10-18 18:08:30.001661
*   Author: F.Marques <fmarques_00@protonmail.com>
* 
*   Description: Top module for APLIC IP. Connects the three modules 
                 that comprise the IP - Notifier, gateway and register controller.
*/ 
module aplic_top #(
   parameter                               MODE          = "DIRECT",
   /** Number of external interrupts */
   parameter int                           NR_SRC = 32,
   parameter int                           MIN_PRIO = 6,
   /** There is one IDC per hart index connected to the APLIC */
   parameter int                           NR_IDCs = 1
) (
   input  logic                            i_clk,
   input  logic                            ni_rst,
   input  logic [NR_SRC-1:0]               i_irq_sources,
   /** APLIC domain interface */
   input  reg_intf::reg_intf_req_a32_d32   i_req_cfg,
   output reg_intf::reg_intf_resp_d32      o_resp_cfg,
   /**  interface for direct mode */
   `ifdef DIRECT_MODE
   /** Interrupt Notification to Targets. One per priv. level. */
   output logic [(NR_IDCs*2)-1:0]          o_Xeip_targets
   /** interface for MSI mode */
   `elsif MSI_MODE
   /**! TODO: change names to axi_msi_req/resp_aplic*/
   output  ariane_axi::req_t               o_req,
   input   ariane_axi::resp_t              i_resp
   `endif
); /** End of APLIC top interface */

logic [NR_SRC-1:0] irq_del_sources_i;
reg_intf::reg_intf_req_a32_d32              i_req_cfg_m;
reg_intf::reg_intf_resp_d32                 o_resp_cfg_m;
reg_intf::reg_intf_req_a32_d32              i_req_cfg_s;
reg_intf::reg_intf_resp_d32                 o_resp_cfg_s;

always_comb begin
   if(i_req_cfg.addr >= 32'hd000000) begin
   
      i_req_cfg_s.addr   = i_req_cfg.addr;
      i_req_cfg_s.write  = i_req_cfg.write;
      i_req_cfg_s.wdata  = i_req_cfg.wdata;
      i_req_cfg_s.wstrb  = i_req_cfg.wstrb;
      i_req_cfg_s.valid  = i_req_cfg.valid;

      o_resp_cfg.rdata = o_resp_cfg_s.rdata;
      o_resp_cfg.error = o_resp_cfg_s.error;
      o_resp_cfg.ready = o_resp_cfg_s.ready;

      i_req_cfg_m.valid  = '0;

   end else begin

      i_req_cfg_m.addr   = i_req_cfg.addr;
      i_req_cfg_m.write  = i_req_cfg.write;
      i_req_cfg_m.wdata  = i_req_cfg.wdata;
      i_req_cfg_m.wstrb  = i_req_cfg.wstrb;
      i_req_cfg_m.valid  = i_req_cfg.valid;

      o_resp_cfg.rdata = o_resp_cfg_m.rdata;
      o_resp_cfg.error = o_resp_cfg_m.error;
      o_resp_cfg.ready = o_resp_cfg_m.ready;

      i_req_cfg_s.valid  = '0;
   end
end

`ifdef MSI_MODE
ariane_axi::req_t               axi_req_m_domain;
ariane_axi::resp_t              axi_resp_m_domain;
ariane_axi::req_t               axi_req_s_domain;
ariane_axi::resp_t              axi_resp_s_domain;
logic                           axi_1_busy, axi_1_busy_q;

always_ff @( posedge i_clk or negedge ni_rst) begin
   if(!ni_rst)begin
      axi_1_busy_q <= '0;
   end else begin
      axi_1_busy_q <= axi_1_busy;
   end
end
always_comb begin : basic_interconnect
   if (~(axi_1_busy_q || axi_1_busy ) ) begin
      o_req.aw   = axi_req_s_domain.aw ;
      o_req.aw_valid  = axi_req_s_domain.aw_valid;
      o_req.w    = axi_req_s_domain.w  ;
      o_req.w_valid   = axi_req_s_domain.w_valid ;
      o_req.b_ready   = axi_req_s_domain.b_ready ;

      axi_resp_s_domain.w_ready  = i_resp.w_ready;
   end else begin
      o_req.aw          = axi_req_m_domain.aw ;
      o_req.aw_valid  = axi_req_m_domain.aw_valid;
      o_req.w    = axi_req_m_domain.w  ;
      o_req.w_valid   = axi_req_m_domain.w_valid ;
      o_req.b_ready   = axi_req_m_domain.b_ready ;
      axi_resp_m_domain.w_ready  = i_resp.w_ready;
   end
end
`endif

/** Insert Code Here */
aplic_domain_top #(
   .DOMAIN_ADDR(32'hc000000),
   .NR_SRC(NR_SRC),
   .NR_IDCs(NR_IDCs),
   .MIN_PRIO(MIN_PRIO),
   .APLIC("NON-LEAF"),
   .MODE(MODE)
) i_aplic_m_domain_top(
   .i_clk(i_clk),
   .ni_rst(ni_rst),
   .i_req(i_req_cfg_m),
   .o_resp(o_resp_cfg_m),
   .i_irq_sources(i_irq_sources),
   .o_irq_del_sources(irq_del_sources_i),
   `ifdef DIRECT_MODE
   .o_Xeip_targets(o_Xeip_targets[NR_IDCs-1:0])
   `elsif MSI_MODE
   .o_busy(axi_1_busy),
   .o_req(axi_req_m_domain),
   .i_resp(axi_resp_m_domain)
   `endif
);

aplic_domain_top #(
   .DOMAIN_ADDR(32'hd000000),
   .NR_SRC(NR_SRC),
   .NR_IDCs(NR_IDCs),
   .MIN_PRIO(MIN_PRIO),
   .APLIC("LEAF"),
   .MODE(MODE)
) i_aplic_s_domain_top(
   .i_clk(i_clk),
   .ni_rst(ni_rst),
   .i_req(i_req_cfg_s),
   .o_resp(o_resp_cfg_s),
   .i_irq_sources(irq_del_sources_i),
   .o_irq_del_sources(),
   `ifdef DIRECT_MODE
   .o_Xeip_targets(o_Xeip_targets[(NR_IDCs*2)-1:NR_IDCs])
   `elsif MSI_MODE
   .o_busy( ),
   .o_req(axi_req_s_domain),
   .i_resp(axi_resp_s_domain)
   `endif
);

endmodule