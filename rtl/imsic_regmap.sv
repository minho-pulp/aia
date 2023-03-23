/** 
*   Name: IMSIC register map (generic)
*   Date: 2023-03-23
*   Author: F.Marques <fmarques_00@protonmail.com>
* 
*   Description: Implements a generic IMSIC register file
*               
*   Notes: under tests.
*/ 
module imsic_regmap #(
    parameter int                         NR_SRC_LEN        = 32,
    parameter int unsigned                AXI_ADDR_WIDTH    = 64,
    parameter int unsigned                AXI_DATA_WIDTH    = 64,
    parameter int unsigned                AXI_ID_WIDTH      = 10,
    parameter int                         NR_INTP_FILES     = 2
) (
    input  logic                                        i_clk            ,
    input  logic                                        ni_rst           ,
    input  logic [NR_INTP_FILES-1:0][NR_SRC_LEN-1:0]    i_setipnum       ,
    output logic [NR_INTP_FILES-1:0][NR_SRC_LEN-1:0]    o_setipnum       ,
    output logic [NR_INTP_FILES-1:0]                    o_setipnum_we    ,
    output logic [NR_INTP_FILES-1:0]                    o_setipnum_re    ,
    // Bus Interface
    input  ariane_axi::req_t                            i_req            ,
    output ariane_axi::resp_t                           o_resp            
);
    // signals from AXI 4 Lite
    logic [AXI_ADDR_WIDTH-1:0]            address;
    logic                                 en;
    logic                                 we;
    logic [7:0]                           be;
    logic [AXI_DATA_WIDTH-1:0]            wdata;
    logic [AXI_DATA_WIDTH-1:0]            rdata;

    logic [31:0]                          register_address;
    assign register_address               = address[31:0];

    // -----------------------------
    // AXI Interface Logic
    // -----------------------------
    axi_lite_interface #(
        .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
        .AXI_ID_WIDTH   ( AXI_ID_WIDTH    )
    ) axi_lite_interface_i (
        .clk_i      ( i_clk      ),
        .rst_ni     ( ni_rst     ),
        .axi_req_i  ( i_req      ),
        .axi_resp_o ( o_resp     ),
        .address_o  ( address    ),
        .en_o       ( en         ),
        .we_o       ( we         ),
        .be_o       ( be         ),
        .data_i     ( rdata      ),
        .data_o     ( wdata      )
    );

    // -----------------------------
    // Register Update Logic
    // -----------------------------
    /** Process a write request */
    always_comb begin
        o_setipnum                  = '0;
        o_setipnum_we               = '0;

        if (en && we) begin
            unique case (register_address) inside
                32'h24000000: begin
                    o_setipnum[0][NR_SRC_LEN-1:0]  = wdata[NR_SRC_LEN-1:0];
                    o_setipnum_we[0]               = 1'b1;
                end

                [32'h28000000 : 32'h28000000 + ((NR_INTP_FILES-2)*'h1000)]: begin
                    o_setipnum[register_address[13:12]+1][NR_SRC_LEN-1:0]  = wdata[NR_SRC_LEN-1:0];
                    o_setipnum_we[register_address[13:12] + 1]             = 1'b1;
                end            
                default:;
            endcase
        end
    end

    /** Process a read request */
    always_comb begin
        rdata = 'b0;
        if (en && !we) begin
            unique case (register_address) inside
                32'h24000000: begin
                    rdata                   = {{AXI_DATA_WIDTH-NR_SRC_LEN{1'b0}}, 
                                                i_setipnum[0]};
                    o_setipnum_re[0]        = 1'b1;
                end

                [32'h28000000 : 32'h28000000 + ((NR_INTP_FILES-2)*'h1000)]: begin
                    rdata                   = {{AXI_DATA_WIDTH-NR_SRC_LEN{1'b0}}, 
                                                i_setipnum[register_address[13:12]+1]};;
                    o_setipnum_re[register_address[13:12]+1]        = 1'b1;
                end           
                default:;
            endcase
        end
    end
    
endmodule

