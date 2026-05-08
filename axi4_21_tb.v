`timescale 1ns / 1ps

module tb_ai_dispatcher();

    // =========================================================================
    // 1. KHAI BÁO CÁC TÍN HIỆU (SIGNALS DECLARATION)
    // =========================================================================
    
    // System Signals
    reg        ACLK_i;
    reg        ARESETn_i; // Active LOW reset

    // --------------------------------------------------------
    // Tín hiệu Input (Đi vào DUT) - Khai báo là 'reg'
    // --------------------------------------------------------
    // Master Interface Inputs
    reg  [0:0] m_ARVALID_i;
    reg  [0:0] m_AWVALID_i;
    reg  [0:0] m_BREADY_i;
    reg  [0:0] m_RREADY_i;
    reg  [0:0] m_WLAST_i;
    reg  [0:0] m_WVALID_i;
    
    reg  [4:0] m_AWID_i;
    reg [31:0] m_AWADDR_i;
    reg  [1:0] m_AWBURST_i;
    reg  [2:0] m_AWLEN_i;
    reg  [2:0] m_AWSIZE_i;
    reg [31:0] m_WDATA_i;
    
    reg  [4:0] m_ARID_i;
    reg [31:0] m_ARADDR_i;
    reg  [1:0] m_ARBURST_i;
    reg  [2:0] m_ARLEN_i;
    reg  [2:0] m_ARSIZE_i;

    // Slave Interface Inputs
    reg  [1:0] s_AWREADY_i;
    reg  [1:0] s_WREADY_i;
    reg  [9:0] s_BID_i;
    reg  [3:0] s_BRESP_i;
    reg  [1:0] s_BVALID_i;
    
    reg  [1:0] s_ARREADY_i;
    reg  [9:0] s_RID_i;
    reg [63:0] s_RDATA_i;
    reg  [3:0] s_RRESP_i;
    reg  [1:0] s_RLAST_i;
    reg  [1:0] s_RVALID_i;

    // --------------------------------------------------------
    // Tín hiệu Output (Đi ra từ DUT) - Khai báo là 'wire'
    // --------------------------------------------------------
    // Master Interface Outputs
    wire [0:0] m_ARREADY_o;
    wire [0:0] m_AWREADY_o;
    wire [0:0] m_BVALID_o;
    wire [0:0] m_RLAST_o;
    wire [0:0] m_RVALID_o;
    wire [0:0] m_WREADY_o;
    
    wire [4:0] m_BID_o;
    wire [1:0] m_BRESP_o;
    wire [4:0] m_RID_o;
    wire [31:0] m_RDATA_o;
    wire [1:0] m_RRESP_o;

    // Slave Interface Outputs
    wire [9:0] s_AWID_o;
    wire [63:0] s_AWADDR_o;
    wire [3:0] s_AWBURST_o;
    wire [5:0] s_AWLEN_o;
    wire [5:0] s_AWSIZE_o;
    wire [1:0] s_AWVALID_o;
    
    wire [63:0] s_WDATA_o;
    wire [1:0] s_WLAST_o;
    wire [1:0] s_WVALID_o;
    wire [1:0] s_BREADY_o;
    
    wire [9:0] s_ARID_o;
    wire [63:0] s_ARADDR_o;
    wire [3:0] s_ARBURST_o;
    wire [5:0] s_ARLEN_o;
    wire [5:0] s_ARSIZE_o;
    wire [1:0] s_ARVALID_o;
    wire [1:0] s_RREADY_o;

    // =========================================================================
    // 2. KHỞI TẠO KHỐI DUT (DEVICE UNDER TEST)
    // =========================================================================
    // Thay đổi ai_dispatcher thành tên module chính xác của bạn
    ai_dispatcher dut (
        // System
        .ACLK_i          (ACLK_i),
        .ARESETn_i       (ARESETn_i),
        
        // Master inputs
        .m_ARVALID_i     (m_ARVALID_i),
        .m_AWVALID_i     (m_AWVALID_i),
        .m_BREADY_i      (m_BREADY_i),
        .m_RREADY_i      (m_RREADY_i),
        .m_WLAST_i       (m_WLAST_i),
        .m_WVALID_i      (m_WVALID_i),
        .m_AWID_i        (m_AWID_i),
        .m_AWADDR_i      (m_AWADDR_i),
        .m_AWBURST_i     (m_AWBURST_i),
        .m_AWLEN_i       (m_AWLEN_i),
        .m_AWSIZE_i      (m_AWSIZE_i),
        .m_WDATA_i       (m_WDATA_i),
        .m_ARID_i        (m_ARID_i),
        .m_ARADDR_i      (m_ARADDR_i),
        .m_ARBURST_i     (m_ARBURST_i),
        .m_ARLEN_i       (m_ARLEN_i),
        .m_ARSIZE_i      (m_ARSIZE_i),
        
        // Slave inputs
        .s_AWREADY_i     (s_AWREADY_i),
        .s_WREADY_i      (s_WREADY_i),
        .s_BID_i         (s_BID_i),
        .s_BRESP_i       (s_BRESP_i),
        .s_BVALID_i      (s_BVALID_i),
        .s_ARREADY_i     (s_ARREADY_i),
        .s_RID_i         (s_RID_i),
        .s_RDATA_i       (s_RDATA_i),
        .s_RRESP_i       (s_RRESP_i),
        .s_RLAST_i       (s_RLAST_i),
        .s_RVALID_i      (s_RVALID_i),

        // Master outputs
        .m_ARREADY_o     (m_ARREADY_o),
        .m_AWREADY_o     (m_AWREADY_o),
        .m_BVALID_o      (m_BVALID_o),
        .m_RLAST_o       (m_RLAST_o),
        .m_RVALID_o      (m_RVALID_o),
        .m_WREADY_o      (m_WREADY_o),
        .m_BID_o         (m_BID_o),
        .m_BRESP_o       (m_BRESP_o),
        .m_RID_o         (m_RID_o),
        .m_RDATA_o       (m_RDATA_o),
        .m_RRESP_o       (m_RRESP_o),

        // Slave outputs
        .s_AWID_o        (s_AWID_o),
        .s_AWADDR_o      (s_AWADDR_o),
        .s_AWBURST_o     (s_AWBURST_o),
        .s_AWLEN_o       (s_AWLEN_o),
        .s_AWSIZE_o      (s_AWSIZE_o),
        .s_AWVALID_o     (s_AWVALID_o),
        .s_WDATA_o       (s_WDATA_o),
        .s_WLAST_o       (s_WLAST_o),
        .s_WVALID_o      (s_WVALID_o),
        .s_BREADY_o      (s_BREADY_o),
        .s_ARID_o        (s_ARID_o),
        .s_ARADDR_o      (s_ARADDR_o),
        .s_ARBURST_o     (s_ARBURST_o),
        .s_ARLEN_o       (s_ARLEN_o),
        .s_ARSIZE_o      (s_ARSIZE_o),
        .s_ARVALID_o     (s_ARVALID_o),
        .s_RREADY_o      (s_RREADY_o)
    );

    // =========================================================================
    // 3. TẠO XUNG CLOCK (CLOCK GENERATION)
    // =========================================================================
    initial begin
        ACLK_i = 0;
        forever #5 ACLK_i = ~ACLK_i; // Chu kỳ 10ns
    end

    // =========================================================================
    // 4. KỊCH BẢN MÔ PHỎNG (MAIN TEST STIMULUS)
    // =========================================================================
    initial begin
        // 4.1 Khởi tạo toàn bộ tín hiệu đầu vào bằng 0
        ARESETn_i   = 0;
        m_ARVALID_i = 0; m_AWVALID_i = 0; m_BREADY_i  = 0; m_RREADY_i  = 0;
        m_WLAST_i   = 0; m_WVALID_i  = 0;
        m_AWID_i    = 0; m_AWADDR_i  = 0; m_AWBURST_i = 0; m_AWLEN_i   = 0; m_AWSIZE_i = 0;
        m_WDATA_i   = 0;
        m_ARID_i    = 0; m_ARADDR_i  = 0; m_ARBURST_i = 0; m_ARLEN_i   = 0; m_ARSIZE_i = 0;

        s_AWREADY_i = 0; s_WREADY_i  = 0; s_BID_i     = 0; s_BRESP_i   = 0; s_BVALID_i = 0;
        s_ARREADY_i = 0; s_RID_i     = 0; s_RDATA_i   = 0; s_RRESP_i   = 0; s_RLAST_i  = 0; s_RVALID_i = 0;

        // 4.2 Cấp Reset
        repeat(5) @(posedge ACLK_i);
        ARESETn_i = 1;
        $display("System Reset De-asserted.");

        // 4.3 Test case cơ bản tại đây
        @(posedge ACLK_i);
        
        // ... Thêm code điều khiển các tín hiệu reg vào đây ...

        // 4.4 Dừng mô phỏng
        #1000;
        $display("Testbench Finished.");
        $finish;
    end

endmodule