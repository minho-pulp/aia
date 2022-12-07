module aplic_top_wrapper #(
   parameter int                            NR_SRC        = 32,          // Interrupt 0 is always 0
   parameter int                            MIN_PRIO      = 6,
   parameter int                            NR_IDCs       = 1
) (
    input  logic                            i_clk,
    input  logic                            ni_rst,
    /** Register config: AXI interface From/To system bus for M domain*/
    input   logic [31:0]                    reg_intf_req_a32_d32_addr_1,
    input   logic                           reg_intf_req_a32_d32_write_1,
    input   logic [31:0]                    reg_intf_req_a32_d32_wdata_1,
    input   logic [3:0]                     reg_intf_req_a32_d32_wstrb_1,
    input   logic                           reg_intf_req_a32_d32_valid_1,
    output  logic [31:0]                    reg_intf_resp_d32_rdata_1,
    output  logic                           reg_intf_resp_d32_error_1,
    output  logic                           reg_intf_resp_d32_ready_1,
    /** Register config: AXI interface From/To system bus for S domain*/
    input   logic [31:0]                    reg_intf_req_a32_d32_addr_2,
    input   logic                           reg_intf_req_a32_d32_write_2,
    input   logic [31:0]                    reg_intf_req_a32_d32_wdata_2,
    input   logic [3:0]                     reg_intf_req_a32_d32_wstrb_2,
    input   logic                           reg_intf_req_a32_d32_valid_2,
    output  logic [31:0]                    reg_intf_resp_d32_rdata_2,
    output  logic                           reg_intf_resp_d32_error_2,
    output  logic                           reg_intf_resp_d32_ready_2,
    input   logic [NR_SRC-1:0]              i_irq_sources,
    output  logic [(NR_IDCs*2)-1:0]         o_Xeip_targets
);

logic                                       clk_i;
logic                                       rst_ni;
reg_intf::reg_intf_req_a32_d32              i_req_1;
reg_intf::reg_intf_resp_d32                 o_resp_1;
reg_intf::reg_intf_req_a32_d32              i_req_2;
reg_intf::reg_intf_resp_d32                 o_resp_2;
logic [NR_SRC-1:0]                          irq_sources_i;
logic [(NR_IDCs*2)-1:0]                         Xeip_targets_o;

assign clk_i            = i_clk;
assign rst_ni           = ni_rst;

assign i_req_1.addr   = reg_intf_req_a32_d32_addr_1;
assign i_req_1.write  = reg_intf_req_a32_d32_write_1;
assign i_req_1.wdata  = reg_intf_req_a32_d32_wdata_1;
assign i_req_1.wstrb  = reg_intf_req_a32_d32_wstrb_1;
assign i_req_1.valid  = reg_intf_req_a32_d32_valid_1;

assign reg_intf_resp_d32_rdata_1 = o_resp_1.rdata;
assign reg_intf_resp_d32_error_1 = o_resp_1.error;
assign reg_intf_resp_d32_ready_1 = o_resp_1.ready;

assign i_req_2.addr   = reg_intf_req_a32_d32_addr_2;
assign i_req_2.write  = reg_intf_req_a32_d32_write_2;
assign i_req_2.wdata  = reg_intf_req_a32_d32_wdata_2;
assign i_req_2.wstrb  = reg_intf_req_a32_d32_wstrb_2;
assign i_req_2.valid  = reg_intf_req_a32_d32_valid_2;

assign reg_intf_resp_d32_rdata_2 = o_resp_2.rdata;
assign reg_intf_resp_d32_error_2 = o_resp_2.error;
assign reg_intf_resp_d32_ready_2 = o_resp_2.ready;

assign irq_sources_i = i_irq_sources;
assign o_Xeip_targets = Xeip_targets_o;

aplic_top #(
    .NR_SRC(NR_SRC),
    .MIN_PRIO(MIN_PRIO),
    .NR_IDCs(NR_IDCs)
) i_aplic_top (
    .i_clk(clk_i),
    .ni_rst(rst_ni),
    .i_req_1(i_req_1),
    .o_resp_1(o_resp_1),
    .i_req_2(i_req_2),
    .o_resp_2(o_resp_2),
    .i_irq_sources(irq_sources_i),
    .o_Xeip_targets(Xeip_targets_o)
);

endmodule