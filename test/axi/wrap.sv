module axi_wrap #(
    parameter int unsigned AXI_ADDR_WIDTH = 64,
    parameter int unsigned AXI_DATA_WIDTH = 64,
    parameter int unsigned AXI_ID_WIDTH   = 4
) (
    input logic                      clk_i      ,
    input logic                      rst_ni     ,
    input logic                      ready_i    ,
    input logic [AXI_ADDR_WIDTH-1:0] addr_i     ,
    input logic [AXI_DATA_WIDTH-1:0] data_i     
);

ariane_axi::req_t       req;
ariane_axi::resp_t      resp;

axi4_lite_master_wraper#(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH    )
)axi4_lite_master_wraper_i(
    // .master_port    (                   ),
    .req            ( req               ),
    .resp           ( resp              )
);

axi_lite_master_write_only#(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH    )
) axi_lite_master_write_only_i (
    .clk_i          ( clk_i             ),
    .rst_ni         ( rst_ni            ),
    .ready_i        ( ready_i           ),
    .addr_i         ( addr_i            ),
    .data_i         ( data_i            ),
    .req_o          ( req               ),
    .resp_i         ( resp              )
);

axi_lite_interface #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH    ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH      )
) axi_lite_interface_i (
    .clk_i          ( clk_i             ),
    .rst_ni         ( rst_ni            ),
    .axi_req_i      ( req               ),
    .axi_resp_o     ( resp              ),
    .address_o      (                   ),
    .en_o           (                   ),
    .we_o           (                   ),
    .be_o           (                   ),
    .data_i         (                   ),
    .data_o         (                   )
);

endmodule