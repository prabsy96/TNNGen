

module test
(

);

  reg CLK;
  reg RST;
  wire [32-1:0] maxi_awaddr;
  wire [8-1:0] maxi_awlen;
  wire [3-1:0] maxi_awsize;
  wire [2-1:0] maxi_awburst;
  wire [1-1:0] maxi_awlock;
  wire [4-1:0] maxi_awcache;
  wire [3-1:0] maxi_awprot;
  wire [4-1:0] maxi_awqos;
  wire [2-1:0] maxi_awuser;
  wire maxi_awvalid;
  reg maxi_awready;
  wire [32-1:0] maxi_wdata;
  wire [4-1:0] maxi_wstrb;
  wire maxi_wlast;
  wire maxi_wvalid;
  reg maxi_wready;
  reg [2-1:0] maxi_bresp;
  reg maxi_bvalid;
  wire maxi_bready;
  wire [32-1:0] maxi_araddr;
  wire [8-1:0] maxi_arlen;
  wire [3-1:0] maxi_arsize;
  wire [2-1:0] maxi_arburst;
  wire [1-1:0] maxi_arlock;
  wire [4-1:0] maxi_arcache;
  wire [3-1:0] maxi_arprot;
  wire [4-1:0] maxi_arqos;
  wire [2-1:0] maxi_aruser;
  wire maxi_arvalid;
  reg maxi_arready;
  reg [32-1:0] maxi_rdata;
  reg [2-1:0] maxi_rresp;
  reg maxi_rlast;
  reg maxi_rvalid;
  wire maxi_rready;
  reg [32-1:0] saxi_awaddr;
  reg [4-1:0] saxi_awcache;
  reg [3-1:0] saxi_awprot;
  reg saxi_awvalid;
  wire saxi_awready;
  reg [32-1:0] saxi_wdata;
  reg [4-1:0] saxi_wstrb;
  reg saxi_wvalid;
  wire saxi_wready;
  wire [2-1:0] saxi_bresp;
  wire saxi_bvalid;
  reg saxi_bready;
  reg [32-1:0] saxi_araddr;
  reg [4-1:0] saxi_arcache;
  reg [3-1:0] saxi_arprot;
  reg saxi_arvalid;
  wire saxi_arready;
  wire [32-1:0] saxi_rdata;
  wire [2-1:0] saxi_rresp;
  wire saxi_rvalid;
  reg saxi_rready;
  wire [32-1:0] memory_awaddr;
  wire [8-1:0] memory_awlen;
  wire [3-1:0] memory_awsize;
  wire [2-1:0] memory_awburst;
  wire [1-1:0] memory_awlock;
  wire [4-1:0] memory_awcache;
  wire [3-1:0] memory_awprot;
  wire [4-1:0] memory_awqos;
  wire [2-1:0] memory_awuser;
  wire memory_awvalid;
  reg memory_awready;
  wire [32-1:0] memory_wdata;
  wire [4-1:0] memory_wstrb;
  wire memory_wlast;
  wire memory_wvalid;
  reg memory_wready;
  wire [2-1:0] memory_bresp;
  reg memory_bvalid;
  wire memory_bready;
  wire [32-1:0] memory_araddr;
  wire [8-1:0] memory_arlen;
  wire [3-1:0] memory_arsize;
  wire [2-1:0] memory_arburst;
  wire [1-1:0] memory_arlock;
  wire [4-1:0] memory_arcache;
  wire [3-1:0] memory_arprot;
  wire [4-1:0] memory_arqos;
  wire [2-1:0] memory_aruser;
  wire memory_arvalid;
  reg memory_arready;
  reg [32-1:0] memory_rdata;
  wire [2-1:0] memory_rresp;
  reg memory_rlast;
  reg memory_rvalid;
  wire memory_rready;
  assign memory_bresp = 0;
  assign memory_rresp = 0;
  reg [32-1:0] _memory_fsm;
  localparam _memory_fsm_init = 0;
  reg [8-1:0] _memory_mem [0:2**20-1];

  initial begin
    $readmemh("memimg_thread_matmul.out", _memory_mem);
  end

  reg [33-1:0] _write_count;
  reg [32-1:0] _write_addr;
  reg [33-1:0] _read_count;
  reg [32-1:0] _read_addr;
  reg [33-1:0] _sleep_count;
  reg [33-1:0] _sub_sleep_count;
  reg [32-1:0] _d1__memory_fsm;
  reg __memory_fsm_cond_100_0_1;
  reg __memory_fsm_cond_200_1_1;
  reg __memory_fsm_cond_211_2_1;
  assign memory_awaddr = maxi_awaddr;
  assign memory_awlen = maxi_awlen;
  assign memory_awsize = maxi_awsize;
  assign memory_awburst = maxi_awburst;
  assign memory_awlock = maxi_awlock;
  assign memory_awcache = maxi_awcache;
  assign memory_awprot = maxi_awprot;
  assign memory_awqos = maxi_awqos;
  assign memory_awuser = maxi_awuser;
  assign memory_awvalid = maxi_awvalid;
  wire _tmp_0;
  assign _tmp_0 = memory_awready;

  always @(*) begin
    maxi_awready = _tmp_0;
  end

  assign memory_wdata = maxi_wdata;
  assign memory_wstrb = maxi_wstrb;
  assign memory_wlast = maxi_wlast;
  assign memory_wvalid = maxi_wvalid;
  wire _tmp_1;
  assign _tmp_1 = memory_wready;

  always @(*) begin
    maxi_wready = _tmp_1;
  end

  wire [2-1:0] _tmp_2;
  assign _tmp_2 = memory_bresp;

  always @(*) begin
    maxi_bresp = _tmp_2;
  end

  wire _tmp_3;
  assign _tmp_3 = memory_bvalid;

  always @(*) begin
    maxi_bvalid = _tmp_3;
  end

  assign memory_bready = maxi_bready;
  assign memory_araddr = maxi_araddr;
  assign memory_arlen = maxi_arlen;
  assign memory_arsize = maxi_arsize;
  assign memory_arburst = maxi_arburst;
  assign memory_arlock = maxi_arlock;
  assign memory_arcache = maxi_arcache;
  assign memory_arprot = maxi_arprot;
  assign memory_arqos = maxi_arqos;
  assign memory_aruser = maxi_aruser;
  assign memory_arvalid = maxi_arvalid;
  wire _tmp_4;
  assign _tmp_4 = memory_arready;

  always @(*) begin
    maxi_arready = _tmp_4;
  end

  wire [32-1:0] _tmp_5;
  assign _tmp_5 = memory_rdata;

  always @(*) begin
    maxi_rdata = _tmp_5;
  end

  wire [2-1:0] _tmp_6;
  assign _tmp_6 = memory_rresp;

  always @(*) begin
    maxi_rresp = _tmp_6;
  end

  wire _tmp_7;
  assign _tmp_7 = memory_rlast;

  always @(*) begin
    maxi_rlast = _tmp_7;
  end

  wire _tmp_8;
  assign _tmp_8 = memory_rvalid;

  always @(*) begin
    maxi_rvalid = _tmp_8;
  end

  assign memory_rready = maxi_rready;
  reg [32-1:0] _saxi_awaddr;
  wire [4-1:0] _saxi_awcache;
  wire [3-1:0] _saxi_awprot;
  reg _saxi_awvalid;
  wire _saxi_awready;
  reg [32-1:0] _saxi_wdata;
  reg [4-1:0] _saxi_wstrb;
  reg _saxi_wvalid;
  wire _saxi_wready;
  wire [2-1:0] _saxi_bresp;
  wire _saxi_bvalid;
  wire _saxi_bready;
  reg [32-1:0] _saxi_araddr;
  wire [4-1:0] _saxi_arcache;
  wire [3-1:0] _saxi_arprot;
  reg _saxi_arvalid;
  wire _saxi_arready;
  wire [32-1:0] _saxi_rdata;
  wire [2-1:0] _saxi_rresp;
  wire _saxi_rvalid;
  wire _saxi_rready;
  assign _saxi_awcache = 3;
  assign _saxi_awprot = 0;
  assign _saxi_bready = 1;
  assign _saxi_arcache = 3;
  assign _saxi_arprot = 0;
  reg [3-1:0] outstanding_wcount_9;
  wire [32-1:0] _tmp_10;
  assign _tmp_10 = _saxi_awaddr;

  always @(*) begin
    saxi_awaddr = _tmp_10;
  end

  wire [4-1:0] _tmp_11;
  assign _tmp_11 = _saxi_awcache;

  always @(*) begin
    saxi_awcache = _tmp_11;
  end

  wire [3-1:0] _tmp_12;
  assign _tmp_12 = _saxi_awprot;

  always @(*) begin
    saxi_awprot = _tmp_12;
  end

  wire _tmp_13;
  assign _tmp_13 = _saxi_awvalid;

  always @(*) begin
    saxi_awvalid = _tmp_13;
  end

  assign _saxi_awready = saxi_awready;
  wire [32-1:0] _tmp_14;
  assign _tmp_14 = _saxi_wdata;

  always @(*) begin
    saxi_wdata = _tmp_14;
  end

  wire [4-1:0] _tmp_15;
  assign _tmp_15 = _saxi_wstrb;

  always @(*) begin
    saxi_wstrb = _tmp_15;
  end

  wire _tmp_16;
  assign _tmp_16 = _saxi_wvalid;

  always @(*) begin
    saxi_wvalid = _tmp_16;
  end

  assign _saxi_wready = saxi_wready;
  assign _saxi_bresp = saxi_bresp;
  assign _saxi_bvalid = saxi_bvalid;
  wire _tmp_17;
  assign _tmp_17 = _saxi_bready;

  always @(*) begin
    saxi_bready = _tmp_17;
  end

  wire [32-1:0] _tmp_18;
  assign _tmp_18 = _saxi_araddr;

  always @(*) begin
    saxi_araddr = _tmp_18;
  end

  wire [4-1:0] _tmp_19;
  assign _tmp_19 = _saxi_arcache;

  always @(*) begin
    saxi_arcache = _tmp_19;
  end

  wire [3-1:0] _tmp_20;
  assign _tmp_20 = _saxi_arprot;

  always @(*) begin
    saxi_arprot = _tmp_20;
  end

  wire _tmp_21;
  assign _tmp_21 = _saxi_arvalid;

  always @(*) begin
    saxi_arvalid = _tmp_21;
  end

  assign _saxi_arready = saxi_arready;
  assign _saxi_rdata = saxi_rdata;
  assign _saxi_rresp = saxi_rresp;
  assign _saxi_rvalid = saxi_rvalid;
  wire _tmp_22;
  assign _tmp_22 = _saxi_rready;

  always @(*) begin
    saxi_rready = _tmp_22;
  end

  reg [32-1:0] counter;
  reg [32-1:0] th_ctrl;
  localparam th_ctrl_init = 0;
  reg signed [32-1:0] _th_ctrl_i_17;
  reg signed [32-1:0] _th_ctrl_awaddr_18;
  reg __saxi_cond_0_1;
  reg __saxi_cond_1_1;
  reg __saxi_cond_2_1;
  reg __saxi_cond_3_1;
  reg __saxi_cond_4_1;
  reg __saxi_cond_5_1;
  reg __saxi_cond_6_1;
  reg __saxi_cond_7_1;
  reg signed [32-1:0] _th_ctrl_start_time_19;
  reg __saxi_cond_8_1;
  reg __saxi_cond_9_1;
  reg signed [32-1:0] _th_ctrl_araddr_20;
  reg __saxi_cond_10_1;
  reg signed [32-1:0] axim_rdata_23;
  reg signed [32-1:0] _th_ctrl_v_21;
  reg __saxi_cond_11_1;
  assign _saxi_rready = (th_ctrl == 27) || (th_ctrl == 31);
  reg signed [32-1:0] axim_rdata_24;
  reg signed [32-1:0] _th_ctrl_end_time_22;
  reg signed [32-1:0] _th_ctrl_time_23;
  reg signed [32-1:0] _th_ctrl_all_ok_24;
  reg signed [32-1:0] _th_ctrl_y_25;
  reg signed [32-1:0] _th_ctrl_x_26;
  reg signed [32-1:0] rdata_25;

  blinkled
  uut
  (
    .CLK(CLK),
    .RST(RST),
    .maxi_awaddr(maxi_awaddr),
    .maxi_awlen(maxi_awlen),
    .maxi_awsize(maxi_awsize),
    .maxi_awburst(maxi_awburst),
    .maxi_awlock(maxi_awlock),
    .maxi_awcache(maxi_awcache),
    .maxi_awprot(maxi_awprot),
    .maxi_awqos(maxi_awqos),
    .maxi_awuser(maxi_awuser),
    .maxi_awvalid(maxi_awvalid),
    .maxi_awready(maxi_awready),
    .maxi_wdata(maxi_wdata),
    .maxi_wstrb(maxi_wstrb),
    .maxi_wlast(maxi_wlast),
    .maxi_wvalid(maxi_wvalid),
    .maxi_wready(maxi_wready),
    .maxi_bresp(maxi_bresp),
    .maxi_bvalid(maxi_bvalid),
    .maxi_bready(maxi_bready),
    .maxi_araddr(maxi_araddr),
    .maxi_arlen(maxi_arlen),
    .maxi_arsize(maxi_arsize),
    .maxi_arburst(maxi_arburst),
    .maxi_arlock(maxi_arlock),
    .maxi_arcache(maxi_arcache),
    .maxi_arprot(maxi_arprot),
    .maxi_arqos(maxi_arqos),
    .maxi_aruser(maxi_aruser),
    .maxi_arvalid(maxi_arvalid),
    .maxi_arready(maxi_arready),
    .maxi_rdata(maxi_rdata),
    .maxi_rresp(maxi_rresp),
    .maxi_rlast(maxi_rlast),
    .maxi_rvalid(maxi_rvalid),
    .maxi_rready(maxi_rready),
    .saxi_awaddr(saxi_awaddr),
    .saxi_awcache(saxi_awcache),
    .saxi_awprot(saxi_awprot),
    .saxi_awvalid(saxi_awvalid),
    .saxi_awready(saxi_awready),
    .saxi_wdata(saxi_wdata),
    .saxi_wstrb(saxi_wstrb),
    .saxi_wvalid(saxi_wvalid),
    .saxi_wready(saxi_wready),
    .saxi_bresp(saxi_bresp),
    .saxi_bvalid(saxi_bvalid),
    .saxi_bready(saxi_bready),
    .saxi_araddr(saxi_araddr),
    .saxi_arcache(saxi_arcache),
    .saxi_arprot(saxi_arprot),
    .saxi_arvalid(saxi_arvalid),
    .saxi_arready(saxi_arready),
    .saxi_rdata(saxi_rdata),
    .saxi_rresp(saxi_rresp),
    .saxi_rvalid(saxi_rvalid),
    .saxi_rready(saxi_rready)
  );


  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, uut);
  end


  initial begin
    CLK = 0;
    forever begin
      #5 CLK = !CLK;
    end
  end


  initial begin
    RST = 0;
    memory_awready = 0;
    memory_wready = 0;
    memory_bvalid = 0;
    memory_arready = 0;
    memory_rdata = 0;
    memory_rlast = 0;
    memory_rvalid = 0;
    _memory_fsm = _memory_fsm_init;
    _write_count = 0;
    _write_addr = 0;
    _read_count = 0;
    _read_addr = 0;
    _sleep_count = 0;
    _sub_sleep_count = 0;
    _d1__memory_fsm = _memory_fsm_init;
    __memory_fsm_cond_100_0_1 = 0;
    __memory_fsm_cond_200_1_1 = 0;
    __memory_fsm_cond_211_2_1 = 0;
    _saxi_awaddr = 0;
    _saxi_awvalid = 0;
    _saxi_wdata = 0;
    _saxi_wstrb = 0;
    _saxi_wvalid = 0;
    _saxi_araddr = 0;
    _saxi_arvalid = 0;
    outstanding_wcount_9 = 0;
    counter = 0;
    th_ctrl = th_ctrl_init;
    _th_ctrl_i_17 = 0;
    _th_ctrl_awaddr_18 = 0;
    __saxi_cond_0_1 = 0;
    __saxi_cond_1_1 = 0;
    __saxi_cond_2_1 = 0;
    __saxi_cond_3_1 = 0;
    __saxi_cond_4_1 = 0;
    __saxi_cond_5_1 = 0;
    __saxi_cond_6_1 = 0;
    __saxi_cond_7_1 = 0;
    _th_ctrl_start_time_19 = 0;
    __saxi_cond_8_1 = 0;
    __saxi_cond_9_1 = 0;
    _th_ctrl_araddr_20 = 0;
    __saxi_cond_10_1 = 0;
    axim_rdata_23 = 0;
    _th_ctrl_v_21 = 0;
    __saxi_cond_11_1 = 0;
    axim_rdata_24 = 0;
    _th_ctrl_end_time_22 = 0;
    _th_ctrl_time_23 = 0;
    _th_ctrl_all_ok_24 = 0;
    _th_ctrl_y_25 = 0;
    _th_ctrl_x_26 = 0;
    rdata_25 = 0;
    #100;
    RST = 1;
    #100;
    RST = 0;
    #1000000;
    $finish;
  end

  localparam _memory_fsm_200 = 200;
  localparam _memory_fsm_201 = 201;
  localparam _memory_fsm_202 = 202;
  localparam _memory_fsm_203 = 203;
  localparam _memory_fsm_204 = 204;
  localparam _memory_fsm_205 = 205;
  localparam _memory_fsm_206 = 206;
  localparam _memory_fsm_207 = 207;
  localparam _memory_fsm_208 = 208;
  localparam _memory_fsm_209 = 209;
  localparam _memory_fsm_210 = 210;
  localparam _memory_fsm_211 = 211;
  localparam _memory_fsm_100 = 100;
  localparam _memory_fsm_101 = 101;
  localparam _memory_fsm_102 = 102;
  localparam _memory_fsm_103 = 103;
  localparam _memory_fsm_104 = 104;
  localparam _memory_fsm_105 = 105;
  localparam _memory_fsm_106 = 106;
  localparam _memory_fsm_107 = 107;
  localparam _memory_fsm_108 = 108;
  localparam _memory_fsm_109 = 109;
  localparam _memory_fsm_110 = 110;
  localparam _memory_fsm_111 = 111;
  localparam _memory_fsm_112 = 112;

  always @(posedge CLK) begin
    if(RST) begin
      _memory_fsm <= _memory_fsm_init;
      _d1__memory_fsm <= _memory_fsm_init;
      memory_awready <= 0;
      _write_addr <= 0;
      _write_count <= 0;
      __memory_fsm_cond_100_0_1 <= 0;
      memory_wready <= 0;
      memory_arready <= 0;
      _read_addr <= 0;
      _read_count <= 0;
      __memory_fsm_cond_200_1_1 <= 0;
      memory_rdata[7:0] <= (0 >> 0) & { 8{ 1'd1 } };
      memory_rdata[15:8] <= (0 >> 8) & { 8{ 1'd1 } };
      memory_rdata[23:16] <= (0 >> 16) & { 8{ 1'd1 } };
      memory_rdata[31:24] <= (0 >> 24) & { 8{ 1'd1 } };
      memory_rvalid <= 0;
      memory_rlast <= 0;
      __memory_fsm_cond_211_2_1 <= 0;
      memory_rdata <= 0;
      memory_bvalid <= 0;
      _sub_sleep_count <= 0;
      _sleep_count <= 0;
    end else begin
      if(memory_bvalid && memory_bready) begin
        memory_bvalid <= 0;
      end 
      if(memory_wvalid && memory_wready && memory_wlast) begin
        memory_bvalid <= 1;
      end 
      if(_sleep_count == 3) begin
        _sub_sleep_count <= _sub_sleep_count + 1;
      end 
      if((_sleep_count == 3) && (_sub_sleep_count == 3)) begin
        _sub_sleep_count <= 0;
      end 
      if(_sleep_count < 3) begin
        _sleep_count <= _sleep_count + 1;
      end 
      if((_sub_sleep_count == 3) && (_sleep_count == 3)) begin
        _sleep_count <= 0;
      end 
      _d1__memory_fsm <= _memory_fsm;
      case(_d1__memory_fsm)
        _memory_fsm_100: begin
          if(__memory_fsm_cond_100_0_1) begin
            memory_awready <= 0;
          end 
        end
        _memory_fsm_200: begin
          if(__memory_fsm_cond_200_1_1) begin
            memory_arready <= 0;
          end 
        end
        _memory_fsm_211: begin
          if(__memory_fsm_cond_211_2_1) begin
            memory_rvalid <= 0;
            memory_rlast <= 0;
          end 
        end
      endcase
      case(_memory_fsm)
        _memory_fsm_init: begin
          if(memory_awvalid) begin
            _memory_fsm <= _memory_fsm_100;
          end 
          if(memory_arvalid) begin
            _memory_fsm <= _memory_fsm_200;
          end 
        end
        _memory_fsm_100: begin
          if(memory_awvalid && !memory_bvalid) begin
            memory_awready <= 1;
            _write_addr <= memory_awaddr;
            _write_count <= memory_awlen + 1;
          end 
          __memory_fsm_cond_100_0_1 <= 1;
          if(!memory_awvalid) begin
            _memory_fsm <= _memory_fsm_init;
          end 
          if(memory_awvalid) begin
            _memory_fsm <= _memory_fsm_101;
          end 
        end
        _memory_fsm_101: begin
          _memory_fsm <= _memory_fsm_102;
        end
        _memory_fsm_102: begin
          _memory_fsm <= _memory_fsm_103;
        end
        _memory_fsm_103: begin
          _memory_fsm <= _memory_fsm_104;
        end
        _memory_fsm_104: begin
          _memory_fsm <= _memory_fsm_105;
        end
        _memory_fsm_105: begin
          _memory_fsm <= _memory_fsm_106;
        end
        _memory_fsm_106: begin
          _memory_fsm <= _memory_fsm_107;
        end
        _memory_fsm_107: begin
          _memory_fsm <= _memory_fsm_108;
        end
        _memory_fsm_108: begin
          _memory_fsm <= _memory_fsm_109;
        end
        _memory_fsm_109: begin
          _memory_fsm <= _memory_fsm_110;
        end
        _memory_fsm_110: begin
          _memory_fsm <= _memory_fsm_111;
        end
        _memory_fsm_111: begin
          memory_wready <= 1;
          _memory_fsm <= _memory_fsm_112;
        end
        _memory_fsm_112: begin
          if(memory_wvalid && memory_wstrb[0]) begin
            _memory_mem[_write_addr + 0] <= memory_wdata[7:0];
          end 
          if(memory_wvalid && memory_wstrb[1]) begin
            _memory_mem[_write_addr + 1] <= memory_wdata[15:8];
          end 
          if(memory_wvalid && memory_wstrb[2]) begin
            _memory_mem[_write_addr + 2] <= memory_wdata[23:16];
          end 
          if(memory_wvalid && memory_wstrb[3]) begin
            _memory_mem[_write_addr + 3] <= memory_wdata[31:24];
          end 
          if(memory_wvalid && memory_wready) begin
            _write_addr <= _write_addr + 4;
            _write_count <= _write_count - 1;
          end 
          if(_sleep_count == 3) begin
            memory_wready <= 0;
          end else begin
            memory_wready <= 1;
          end
          if(memory_wvalid && memory_wready && (_write_count == 1)) begin
            memory_wready <= 0;
          end 
          if(memory_wvalid && memory_wready && (_write_count == 1)) begin
            _memory_fsm <= _memory_fsm_init;
          end 
        end
        _memory_fsm_200: begin
          if(memory_arvalid) begin
            memory_arready <= 1;
            _read_addr <= memory_araddr;
            _read_count <= memory_arlen + 1;
          end 
          __memory_fsm_cond_200_1_1 <= 1;
          if(!memory_arvalid) begin
            _memory_fsm <= _memory_fsm_init;
          end 
          if(memory_arvalid) begin
            _memory_fsm <= _memory_fsm_201;
          end 
        end
        _memory_fsm_201: begin
          _memory_fsm <= _memory_fsm_202;
        end
        _memory_fsm_202: begin
          _memory_fsm <= _memory_fsm_203;
        end
        _memory_fsm_203: begin
          _memory_fsm <= _memory_fsm_204;
        end
        _memory_fsm_204: begin
          _memory_fsm <= _memory_fsm_205;
        end
        _memory_fsm_205: begin
          _memory_fsm <= _memory_fsm_206;
        end
        _memory_fsm_206: begin
          _memory_fsm <= _memory_fsm_207;
        end
        _memory_fsm_207: begin
          _memory_fsm <= _memory_fsm_208;
        end
        _memory_fsm_208: begin
          _memory_fsm <= _memory_fsm_209;
        end
        _memory_fsm_209: begin
          _memory_fsm <= _memory_fsm_210;
        end
        _memory_fsm_210: begin
          _memory_fsm <= _memory_fsm_211;
        end
        _memory_fsm_211: begin
          if(memory_rready | !memory_rvalid) begin
            memory_rdata[7:0] <= _memory_mem[_read_addr + 0];
          end 
          if(memory_rready | !memory_rvalid) begin
            memory_rdata[15:8] <= _memory_mem[_read_addr + 1];
          end 
          if(memory_rready | !memory_rvalid) begin
            memory_rdata[23:16] <= _memory_mem[_read_addr + 2];
          end 
          if(memory_rready | !memory_rvalid) begin
            memory_rdata[31:24] <= _memory_mem[_read_addr + 3];
          end 
          if((_sleep_count < 3) && (_read_count > 0) && memory_rready | !memory_rvalid) begin
            memory_rvalid <= 1;
            _read_addr <= _read_addr + 4;
            _read_count <= _read_count - 1;
          end 
          if((_sleep_count < 3) && (_read_count == 1) && memory_rready | !memory_rvalid) begin
            memory_rlast <= 1;
          end 
          __memory_fsm_cond_211_2_1 <= 1;
          if(memory_rvalid && !memory_rready) begin
            memory_rvalid <= memory_rvalid;
            memory_rdata <= memory_rdata;
            memory_rlast <= memory_rlast;
          end 
          if(memory_rvalid && memory_rready && (_read_count == 0)) begin
            _memory_fsm <= _memory_fsm_init;
          end 
        end
      endcase
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      outstanding_wcount_9 <= 0;
      _saxi_awaddr <= 0;
      _saxi_awvalid <= 0;
      __saxi_cond_0_1 <= 0;
      _saxi_wdata <= 0;
      _saxi_wvalid <= 0;
      _saxi_wstrb <= 0;
      __saxi_cond_1_1 <= 0;
      __saxi_cond_2_1 <= 0;
      __saxi_cond_3_1 <= 0;
      __saxi_cond_4_1 <= 0;
      __saxi_cond_5_1 <= 0;
      __saxi_cond_6_1 <= 0;
      __saxi_cond_7_1 <= 0;
      __saxi_cond_8_1 <= 0;
      __saxi_cond_9_1 <= 0;
      _saxi_araddr <= 0;
      _saxi_arvalid <= 0;
      __saxi_cond_10_1 <= 0;
      __saxi_cond_11_1 <= 0;
    end else begin
      if(__saxi_cond_0_1) begin
        _saxi_awvalid <= 0;
      end 
      if(__saxi_cond_1_1) begin
        _saxi_wvalid <= 0;
      end 
      if(__saxi_cond_2_1) begin
        _saxi_awvalid <= 0;
      end 
      if(__saxi_cond_3_1) begin
        _saxi_wvalid <= 0;
      end 
      if(__saxi_cond_4_1) begin
        _saxi_awvalid <= 0;
      end 
      if(__saxi_cond_5_1) begin
        _saxi_wvalid <= 0;
      end 
      if(__saxi_cond_6_1) begin
        _saxi_awvalid <= 0;
      end 
      if(__saxi_cond_7_1) begin
        _saxi_wvalid <= 0;
      end 
      if(__saxi_cond_8_1) begin
        _saxi_awvalid <= 0;
      end 
      if(__saxi_cond_9_1) begin
        _saxi_wvalid <= 0;
      end 
      if(__saxi_cond_10_1) begin
        _saxi_arvalid <= 0;
      end 
      if(__saxi_cond_11_1) begin
        _saxi_arvalid <= 0;
      end 
      if(_saxi_wvalid && _saxi_wready && !(_saxi_bvalid && _saxi_bready) && (outstanding_wcount_9 < 7)) begin
        outstanding_wcount_9 <= outstanding_wcount_9 + 1;
      end 
      if(!(_saxi_wvalid && _saxi_wready) && (_saxi_bvalid && _saxi_bready) && (outstanding_wcount_9 > 0)) begin
        outstanding_wcount_9 <= outstanding_wcount_9 - 1;
      end 
      if((th_ctrl == 6) && (_saxi_awready || !_saxi_awvalid)) begin
        _saxi_awaddr <= _th_ctrl_awaddr_18;
        _saxi_awvalid <= 1;
      end 
      __saxi_cond_0_1 <= 1;
      if(_saxi_awvalid && !_saxi_awready) begin
        _saxi_awvalid <= _saxi_awvalid;
      end 
      if((th_ctrl == 7) && ((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid))) begin
        _saxi_wdata <= 16;
        _saxi_wvalid <= 1;
        _saxi_wstrb <= { 4{ 1'd1 } };
      end 
      __saxi_cond_1_1 <= 1;
      if(_saxi_wvalid && !_saxi_wready) begin
        _saxi_wvalid <= _saxi_wvalid;
      end 
      if((th_ctrl == 10) && (_saxi_awready || !_saxi_awvalid)) begin
        _saxi_awaddr <= _th_ctrl_awaddr_18;
        _saxi_awvalid <= 1;
      end 
      __saxi_cond_2_1 <= 1;
      if(_saxi_awvalid && !_saxi_awready) begin
        _saxi_awvalid <= _saxi_awvalid;
      end 
      if((th_ctrl == 11) && ((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid))) begin
        _saxi_wdata <= 0;
        _saxi_wvalid <= 1;
        _saxi_wstrb <= { 4{ 1'd1 } };
      end 
      __saxi_cond_3_1 <= 1;
      if(_saxi_wvalid && !_saxi_wready) begin
        _saxi_wvalid <= _saxi_wvalid;
      end 
      if((th_ctrl == 14) && (_saxi_awready || !_saxi_awvalid)) begin
        _saxi_awaddr <= _th_ctrl_awaddr_18;
        _saxi_awvalid <= 1;
      end 
      __saxi_cond_4_1 <= 1;
      if(_saxi_awvalid && !_saxi_awready) begin
        _saxi_awvalid <= _saxi_awvalid;
      end 
      if((th_ctrl == 15) && ((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid))) begin
        _saxi_wdata <= 4096;
        _saxi_wvalid <= 1;
        _saxi_wstrb <= { 4{ 1'd1 } };
      end 
      __saxi_cond_5_1 <= 1;
      if(_saxi_wvalid && !_saxi_wready) begin
        _saxi_wvalid <= _saxi_wvalid;
      end 
      if((th_ctrl == 18) && (_saxi_awready || !_saxi_awvalid)) begin
        _saxi_awaddr <= _th_ctrl_awaddr_18;
        _saxi_awvalid <= 1;
      end 
      __saxi_cond_6_1 <= 1;
      if(_saxi_awvalid && !_saxi_awready) begin
        _saxi_awvalid <= _saxi_awvalid;
      end 
      if((th_ctrl == 19) && ((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid))) begin
        _saxi_wdata <= 8192;
        _saxi_wvalid <= 1;
        _saxi_wstrb <= { 4{ 1'd1 } };
      end 
      __saxi_cond_7_1 <= 1;
      if(_saxi_wvalid && !_saxi_wready) begin
        _saxi_wvalid <= _saxi_wvalid;
      end 
      if((th_ctrl == 23) && (_saxi_awready || !_saxi_awvalid)) begin
        _saxi_awaddr <= _th_ctrl_awaddr_18;
        _saxi_awvalid <= 1;
      end 
      __saxi_cond_8_1 <= 1;
      if(_saxi_awvalid && !_saxi_awready) begin
        _saxi_awvalid <= _saxi_awvalid;
      end 
      if((th_ctrl == 24) && ((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid))) begin
        _saxi_wdata <= 1;
        _saxi_wvalid <= 1;
        _saxi_wstrb <= { 4{ 1'd1 } };
      end 
      __saxi_cond_9_1 <= 1;
      if(_saxi_wvalid && !_saxi_wready) begin
        _saxi_wvalid <= _saxi_wvalid;
      end 
      if((th_ctrl == 26) && (_saxi_arready || !_saxi_arvalid)) begin
        _saxi_araddr <= _th_ctrl_araddr_20;
        _saxi_arvalid <= 1;
      end 
      __saxi_cond_10_1 <= 1;
      if(_saxi_arvalid && !_saxi_arready) begin
        _saxi_arvalid <= _saxi_arvalid;
      end 
      if((th_ctrl == 30) && (_saxi_arready || !_saxi_arvalid)) begin
        _saxi_araddr <= _th_ctrl_araddr_20;
        _saxi_arvalid <= 1;
      end 
      __saxi_cond_11_1 <= 1;
      if(_saxi_arvalid && !_saxi_arready) begin
        _saxi_arvalid <= _saxi_arvalid;
      end 
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      counter <= 0;
    end else begin
      counter <= counter + 1;
    end
  end

  localparam th_ctrl_1 = 1;
  localparam th_ctrl_2 = 2;
  localparam th_ctrl_3 = 3;
  localparam th_ctrl_4 = 4;
  localparam th_ctrl_5 = 5;
  localparam th_ctrl_6 = 6;
  localparam th_ctrl_7 = 7;
  localparam th_ctrl_8 = 8;
  localparam th_ctrl_9 = 9;
  localparam th_ctrl_10 = 10;
  localparam th_ctrl_11 = 11;
  localparam th_ctrl_12 = 12;
  localparam th_ctrl_13 = 13;
  localparam th_ctrl_14 = 14;
  localparam th_ctrl_15 = 15;
  localparam th_ctrl_16 = 16;
  localparam th_ctrl_17 = 17;
  localparam th_ctrl_18 = 18;
  localparam th_ctrl_19 = 19;
  localparam th_ctrl_20 = 20;
  localparam th_ctrl_21 = 21;
  localparam th_ctrl_22 = 22;
  localparam th_ctrl_23 = 23;
  localparam th_ctrl_24 = 24;
  localparam th_ctrl_25 = 25;
  localparam th_ctrl_26 = 26;
  localparam th_ctrl_27 = 27;
  localparam th_ctrl_28 = 28;
  localparam th_ctrl_29 = 29;
  localparam th_ctrl_30 = 30;
  localparam th_ctrl_31 = 31;
  localparam th_ctrl_32 = 32;
  localparam th_ctrl_33 = 33;
  localparam th_ctrl_34 = 34;
  localparam th_ctrl_35 = 35;
  localparam th_ctrl_36 = 36;
  localparam th_ctrl_37 = 37;
  localparam th_ctrl_38 = 38;
  localparam th_ctrl_39 = 39;
  localparam th_ctrl_40 = 40;
  localparam th_ctrl_41 = 41;
  localparam th_ctrl_42 = 42;
  localparam th_ctrl_43 = 43;
  localparam th_ctrl_44 = 44;
  localparam th_ctrl_45 = 45;
  localparam th_ctrl_46 = 46;
  localparam th_ctrl_47 = 47;
  localparam th_ctrl_48 = 48;
  localparam th_ctrl_49 = 49;
  localparam th_ctrl_50 = 50;
  localparam th_ctrl_51 = 51;
  localparam th_ctrl_52 = 52;
  localparam th_ctrl_53 = 53;
  localparam th_ctrl_54 = 54;
  localparam th_ctrl_55 = 55;
  localparam th_ctrl_56 = 56;
  localparam th_ctrl_57 = 57;
  localparam th_ctrl_58 = 58;

  always @(posedge CLK) begin
    if(RST) begin
      th_ctrl <= th_ctrl_init;
      _th_ctrl_i_17 <= 0;
      _th_ctrl_awaddr_18 <= 0;
      _th_ctrl_start_time_19 <= 0;
      _th_ctrl_araddr_20 <= 0;
      axim_rdata_23 <= 0;
      _th_ctrl_v_21 <= 0;
      axim_rdata_24 <= 0;
      _th_ctrl_end_time_22 <= 0;
      _th_ctrl_time_23 <= 0;
      _th_ctrl_all_ok_24 <= 0;
      _th_ctrl_y_25 <= 0;
      _th_ctrl_x_26 <= 0;
      rdata_25 <= 0;
    end else begin
      case(th_ctrl)
        th_ctrl_init: begin
          th_ctrl <= th_ctrl_1;
        end
        th_ctrl_1: begin
          _th_ctrl_i_17 <= 0;
          th_ctrl <= th_ctrl_2;
        end
        th_ctrl_2: begin
          if(_th_ctrl_i_17 < 100) begin
            th_ctrl <= th_ctrl_3;
          end else begin
            th_ctrl <= th_ctrl_4;
          end
        end
        th_ctrl_3: begin
          _th_ctrl_i_17 <= _th_ctrl_i_17 + 1;
          th_ctrl <= th_ctrl_2;
        end
        th_ctrl_4: begin
          _th_ctrl_awaddr_18 <= 4;
          th_ctrl <= th_ctrl_5;
        end
        th_ctrl_5: begin
          $display("# matrix_size = %d", 16);
          th_ctrl <= th_ctrl_6;
        end
        th_ctrl_6: begin
          if(_saxi_awready || !_saxi_awvalid) begin
            th_ctrl <= th_ctrl_7;
          end 
        end
        th_ctrl_7: begin
          if((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid)) begin
            th_ctrl <= th_ctrl_8;
          end 
        end
        th_ctrl_8: begin
          _th_ctrl_awaddr_18 <= 8;
          th_ctrl <= th_ctrl_9;
        end
        th_ctrl_9: begin
          $display("# a_offset = %d", 0);
          th_ctrl <= th_ctrl_10;
        end
        th_ctrl_10: begin
          if(_saxi_awready || !_saxi_awvalid) begin
            th_ctrl <= th_ctrl_11;
          end 
        end
        th_ctrl_11: begin
          if((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid)) begin
            th_ctrl <= th_ctrl_12;
          end 
        end
        th_ctrl_12: begin
          _th_ctrl_awaddr_18 <= 12;
          th_ctrl <= th_ctrl_13;
        end
        th_ctrl_13: begin
          $display("# b_offset = %d", 4096);
          th_ctrl <= th_ctrl_14;
        end
        th_ctrl_14: begin
          if(_saxi_awready || !_saxi_awvalid) begin
            th_ctrl <= th_ctrl_15;
          end 
        end
        th_ctrl_15: begin
          if((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid)) begin
            th_ctrl <= th_ctrl_16;
          end 
        end
        th_ctrl_16: begin
          _th_ctrl_awaddr_18 <= 16;
          th_ctrl <= th_ctrl_17;
        end
        th_ctrl_17: begin
          $display("# c_offset = %d", 8192);
          th_ctrl <= th_ctrl_18;
        end
        th_ctrl_18: begin
          if(_saxi_awready || !_saxi_awvalid) begin
            th_ctrl <= th_ctrl_19;
          end 
        end
        th_ctrl_19: begin
          if((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid)) begin
            th_ctrl <= th_ctrl_20;
          end 
        end
        th_ctrl_20: begin
          _th_ctrl_awaddr_18 <= 0;
          th_ctrl <= th_ctrl_21;
        end
        th_ctrl_21: begin
          _th_ctrl_start_time_19 <= counter;
          th_ctrl <= th_ctrl_22;
        end
        th_ctrl_22: begin
          $display("# start time = %d", _th_ctrl_start_time_19);
          th_ctrl <= th_ctrl_23;
        end
        th_ctrl_23: begin
          if(_saxi_awready || !_saxi_awvalid) begin
            th_ctrl <= th_ctrl_24;
          end 
        end
        th_ctrl_24: begin
          if((outstanding_wcount_9 < 6) && (_saxi_wready || !_saxi_wvalid)) begin
            th_ctrl <= th_ctrl_25;
          end 
        end
        th_ctrl_25: begin
          _th_ctrl_araddr_20 <= 20;
          th_ctrl <= th_ctrl_26;
        end
        th_ctrl_26: begin
          if(_saxi_arready || !_saxi_arvalid) begin
            th_ctrl <= th_ctrl_27;
          end 
        end
        th_ctrl_27: begin
          if(_saxi_rready && _saxi_rvalid) begin
            axim_rdata_23 <= _saxi_rdata;
          end 
          if(_saxi_rready && _saxi_rvalid) begin
            th_ctrl <= th_ctrl_28;
          end 
        end
        th_ctrl_28: begin
          _th_ctrl_v_21 <= axim_rdata_23;
          th_ctrl <= th_ctrl_29;
        end
        th_ctrl_29: begin
          if(_th_ctrl_v_21 == 0) begin
            th_ctrl <= th_ctrl_30;
          end else begin
            th_ctrl <= th_ctrl_34;
          end
        end
        th_ctrl_30: begin
          if(_saxi_arready || !_saxi_arvalid) begin
            th_ctrl <= th_ctrl_31;
          end 
        end
        th_ctrl_31: begin
          if(_saxi_rready && _saxi_rvalid) begin
            axim_rdata_24 <= _saxi_rdata;
          end 
          if(_saxi_rready && _saxi_rvalid) begin
            th_ctrl <= th_ctrl_32;
          end 
        end
        th_ctrl_32: begin
          _th_ctrl_v_21 <= axim_rdata_24;
          th_ctrl <= th_ctrl_33;
        end
        th_ctrl_33: begin
          th_ctrl <= th_ctrl_29;
        end
        th_ctrl_34: begin
          _th_ctrl_end_time_22 <= counter;
          th_ctrl <= th_ctrl_35;
        end
        th_ctrl_35: begin
          $display("# end time = %d", _th_ctrl_end_time_22);
          th_ctrl <= th_ctrl_36;
        end
        th_ctrl_36: begin
          _th_ctrl_time_23 <= _th_ctrl_end_time_22 - _th_ctrl_start_time_19;
          th_ctrl <= th_ctrl_37;
        end
        th_ctrl_37: begin
          $display("# exec time = %d", _th_ctrl_time_23);
          th_ctrl <= th_ctrl_38;
        end
        th_ctrl_38: begin
          _th_ctrl_all_ok_24 <= 1;
          th_ctrl <= th_ctrl_39;
        end
        th_ctrl_39: begin
          _th_ctrl_y_25 <= 0;
          th_ctrl <= th_ctrl_40;
        end
        th_ctrl_40: begin
          if(_th_ctrl_y_25 < 16) begin
            th_ctrl <= th_ctrl_41;
          end else begin
            th_ctrl <= th_ctrl_53;
          end
        end
        th_ctrl_41: begin
          _th_ctrl_x_26 <= 0;
          th_ctrl <= th_ctrl_42;
        end
        th_ctrl_42: begin
          if(_th_ctrl_x_26 < 16) begin
            th_ctrl <= th_ctrl_43;
          end else begin
            th_ctrl <= th_ctrl_52;
          end
        end
        th_ctrl_43: begin
          if(th_ctrl == 43) begin
            rdata_25 <= { _memory_mem[8192 + (((_th_ctrl_y_25 << 4) + _th_ctrl_x_26 << 5) >>> 3) + 3], _memory_mem[8192 + (((_th_ctrl_y_25 << 4) + _th_ctrl_x_26 << 5) >>> 3) + 2], _memory_mem[8192 + (((_th_ctrl_y_25 << 4) + _th_ctrl_x_26 << 5) >>> 3) + 1], _memory_mem[8192 + (((_th_ctrl_y_25 << 4) + _th_ctrl_x_26 << 5) >>> 3) + 0] };
          end 
          th_ctrl <= th_ctrl_44;
        end
        th_ctrl_44: begin
          _th_ctrl_v_21 <= rdata_25;
          th_ctrl <= th_ctrl_45;
        end
        th_ctrl_45: begin
          if((_th_ctrl_y_25 == _th_ctrl_x_26) && (_th_ctrl_v_21 !== (_th_ctrl_y_25 + 1 << 1))) begin
            th_ctrl <= th_ctrl_46;
          end else begin
            th_ctrl <= th_ctrl_48;
          end
        end
        th_ctrl_46: begin
          _th_ctrl_all_ok_24 <= 0;
          th_ctrl <= th_ctrl_47;
        end
        th_ctrl_47: begin
          $display("NG [%d,%d] = %d", _th_ctrl_y_25, _th_ctrl_x_26, _th_ctrl_v_21);
          th_ctrl <= th_ctrl_48;
        end
        th_ctrl_48: begin
          if((_th_ctrl_y_25 != _th_ctrl_x_26) && (_th_ctrl_v_21 !== 0)) begin
            th_ctrl <= th_ctrl_49;
          end else begin
            th_ctrl <= th_ctrl_51;
          end
        end
        th_ctrl_49: begin
          _th_ctrl_all_ok_24 <= 0;
          th_ctrl <= th_ctrl_50;
        end
        th_ctrl_50: begin
          $display("NG [%d,%d] = %d", _th_ctrl_y_25, _th_ctrl_x_26, _th_ctrl_v_21);
          th_ctrl <= th_ctrl_51;
        end
        th_ctrl_51: begin
          _th_ctrl_x_26 <= _th_ctrl_x_26 + 1;
          th_ctrl <= th_ctrl_42;
        end
        th_ctrl_52: begin
          _th_ctrl_y_25 <= _th_ctrl_y_25 + 1;
          th_ctrl <= th_ctrl_40;
        end
        th_ctrl_53: begin
          if(_th_ctrl_all_ok_24) begin
            th_ctrl <= th_ctrl_54;
          end else begin
            th_ctrl <= th_ctrl_56;
          end
        end
        th_ctrl_54: begin
          $display("# verify: PASSED");
          th_ctrl <= th_ctrl_55;
        end
        th_ctrl_55: begin
          th_ctrl <= th_ctrl_57;
        end
        th_ctrl_56: begin
          $display("# verify: FAILED");
          th_ctrl <= th_ctrl_57;
        end
        th_ctrl_57: begin
          $finish;
          th_ctrl <= th_ctrl_58;
        end
      endcase
    end
  end


endmodule



module blinkled
(
  input CLK,
  input RST,
  output reg [32-1:0] maxi_awaddr,
  output reg [8-1:0] maxi_awlen,
  output [3-1:0] maxi_awsize,
  output [2-1:0] maxi_awburst,
  output [1-1:0] maxi_awlock,
  output [4-1:0] maxi_awcache,
  output [3-1:0] maxi_awprot,
  output [4-1:0] maxi_awqos,
  output [2-1:0] maxi_awuser,
  output reg maxi_awvalid,
  input maxi_awready,
  output reg [32-1:0] maxi_wdata,
  output reg [4-1:0] maxi_wstrb,
  output reg maxi_wlast,
  output reg maxi_wvalid,
  input maxi_wready,
  input [2-1:0] maxi_bresp,
  input maxi_bvalid,
  output maxi_bready,
  output reg [32-1:0] maxi_araddr,
  output reg [8-1:0] maxi_arlen,
  output [3-1:0] maxi_arsize,
  output [2-1:0] maxi_arburst,
  output [1-1:0] maxi_arlock,
  output [4-1:0] maxi_arcache,
  output [3-1:0] maxi_arprot,
  output [4-1:0] maxi_arqos,
  output [2-1:0] maxi_aruser,
  output reg maxi_arvalid,
  input maxi_arready,
  input [32-1:0] maxi_rdata,
  input [2-1:0] maxi_rresp,
  input maxi_rlast,
  input maxi_rvalid,
  output maxi_rready,
  input [32-1:0] saxi_awaddr,
  input [4-1:0] saxi_awcache,
  input [3-1:0] saxi_awprot,
  input saxi_awvalid,
  output saxi_awready,
  input [32-1:0] saxi_wdata,
  input [4-1:0] saxi_wstrb,
  input saxi_wvalid,
  output saxi_wready,
  output [2-1:0] saxi_bresp,
  output reg saxi_bvalid,
  input saxi_bready,
  input [32-1:0] saxi_araddr,
  input [4-1:0] saxi_arcache,
  input [3-1:0] saxi_arprot,
  input saxi_arvalid,
  output saxi_arready,
  output reg [32-1:0] saxi_rdata,
  output [2-1:0] saxi_rresp,
  output reg saxi_rvalid,
  input saxi_rready
);

  wire [10-1:0] ram_a_0_addr;
  wire [32-1:0] ram_a_0_rdata;
  wire [32-1:0] ram_a_0_wdata;
  wire ram_a_0_wenable;
  wire ram_a_0_enable;

  ram_a
  inst_ram_a
  (
    .CLK(CLK),
    .ram_a_0_addr(ram_a_0_addr),
    .ram_a_0_rdata(ram_a_0_rdata),
    .ram_a_0_wdata(ram_a_0_wdata),
    .ram_a_0_wenable(ram_a_0_wenable),
    .ram_a_0_enable(ram_a_0_enable)
  );

  wire [10-1:0] ram_b_0_addr;
  wire [32-1:0] ram_b_0_rdata;
  wire [32-1:0] ram_b_0_wdata;
  wire ram_b_0_wenable;
  wire ram_b_0_enable;

  ram_b
  inst_ram_b
  (
    .CLK(CLK),
    .ram_b_0_addr(ram_b_0_addr),
    .ram_b_0_rdata(ram_b_0_rdata),
    .ram_b_0_wdata(ram_b_0_wdata),
    .ram_b_0_wenable(ram_b_0_wenable),
    .ram_b_0_enable(ram_b_0_enable)
  );

  wire [10-1:0] ram_c_0_addr;
  wire [32-1:0] ram_c_0_rdata;
  wire [32-1:0] ram_c_0_wdata;
  wire ram_c_0_wenable;
  wire ram_c_0_enable;

  ram_c
  inst_ram_c
  (
    .CLK(CLK),
    .ram_c_0_addr(ram_c_0_addr),
    .ram_c_0_rdata(ram_c_0_rdata),
    .ram_c_0_wdata(ram_c_0_wdata),
    .ram_c_0_wenable(ram_c_0_wenable),
    .ram_c_0_enable(ram_c_0_enable)
  );

  assign maxi_awsize = 2;
  assign maxi_awburst = 1;
  assign maxi_awlock = 0;
  assign maxi_awcache = 3;
  assign maxi_awprot = 0;
  assign maxi_awqos = 0;
  assign maxi_awuser = 0;
  assign maxi_bready = 1;
  assign maxi_arsize = 2;
  assign maxi_arburst = 1;
  assign maxi_arlock = 0;
  assign maxi_arcache = 3;
  assign maxi_arprot = 0;
  assign maxi_arqos = 0;
  assign maxi_aruser = 0;
  reg [3-1:0] outstanding_wcount_0;
  reg _maxi_read_start;
  reg [8-1:0] _maxi_read_op_sel;
  reg [32-1:0] _maxi_read_local_addr;
  reg [32-1:0] _maxi_read_global_addr;
  reg [33-1:0] _maxi_read_size;
  reg [32-1:0] _maxi_read_local_stride;
  reg _maxi_read_idle;
  reg _maxi_write_start;
  reg [8-1:0] _maxi_write_op_sel;
  reg [32-1:0] _maxi_write_local_addr;
  reg [32-1:0] _maxi_write_global_addr;
  reg [33-1:0] _maxi_write_size;
  reg [32-1:0] _maxi_write_local_stride;
  reg _maxi_write_idle;
  wire _maxi_write_data_done;
  assign saxi_bresp = 0;
  assign saxi_rresp = 0;
  reg signed [32-1:0] _saxi_register_0;
  reg signed [32-1:0] _saxi_register_1;
  reg signed [32-1:0] _saxi_register_2;
  reg signed [32-1:0] _saxi_register_3;
  reg signed [32-1:0] _saxi_register_4;
  reg signed [32-1:0] _saxi_register_5;
  reg signed [32-1:0] _saxi_register_6;
  reg signed [32-1:0] _saxi_register_7;
  reg _saxi_flag_0;
  reg _saxi_flag_1;
  reg _saxi_flag_2;
  reg _saxi_flag_3;
  reg _saxi_flag_4;
  reg _saxi_flag_5;
  reg _saxi_flag_6;
  reg _saxi_flag_7;
  reg signed [32-1:0] _saxi_resetval_0;
  reg signed [32-1:0] _saxi_resetval_1;
  reg signed [32-1:0] _saxi_resetval_2;
  reg signed [32-1:0] _saxi_resetval_3;
  reg signed [32-1:0] _saxi_resetval_4;
  reg signed [32-1:0] _saxi_resetval_5;
  reg signed [32-1:0] _saxi_resetval_6;
  reg signed [32-1:0] _saxi_resetval_7;
  localparam _saxi_maskwidth = 3;
  localparam _saxi_mask = { _saxi_maskwidth{ 1'd1 } };
  localparam _saxi_shift = 2;
  reg [32-1:0] _saxi_register_fsm;
  localparam _saxi_register_fsm_init = 0;
  reg [32-1:0] addr_1;
  reg writevalid_2;
  reg readvalid_3;
  reg prev_awvalid_4;
  reg prev_arvalid_5;
  assign saxi_awready = (_saxi_register_fsm == 0) && (!writevalid_2 && !readvalid_3 && !saxi_bvalid && prev_awvalid_4);
  assign saxi_arready = (_saxi_register_fsm == 0) && (!readvalid_3 && !writevalid_2 && prev_arvalid_5 && !prev_awvalid_4);
  reg [_saxi_maskwidth-1:0] _tmp_6;
  wire signed [32-1:0] _tmp_7;
  assign _tmp_7 = (_tmp_6 == 0)? _saxi_register_0 : 
                  (_tmp_6 == 1)? _saxi_register_1 : 
                  (_tmp_6 == 2)? _saxi_register_2 : 
                  (_tmp_6 == 3)? _saxi_register_3 : 
                  (_tmp_6 == 4)? _saxi_register_4 : 
                  (_tmp_6 == 5)? _saxi_register_5 : 
                  (_tmp_6 == 6)? _saxi_register_6 : 
                  (_tmp_6 == 7)? _saxi_register_7 : 'hx;
  wire _tmp_8;
  assign _tmp_8 = (_tmp_6 == 0)? _saxi_flag_0 : 
                  (_tmp_6 == 1)? _saxi_flag_1 : 
                  (_tmp_6 == 2)? _saxi_flag_2 : 
                  (_tmp_6 == 3)? _saxi_flag_3 : 
                  (_tmp_6 == 4)? _saxi_flag_4 : 
                  (_tmp_6 == 5)? _saxi_flag_5 : 
                  (_tmp_6 == 6)? _saxi_flag_6 : 
                  (_tmp_6 == 7)? _saxi_flag_7 : 'hx;
  wire signed [32-1:0] _tmp_9;
  assign _tmp_9 = (_tmp_6 == 0)? _saxi_resetval_0 : 
                  (_tmp_6 == 1)? _saxi_resetval_1 : 
                  (_tmp_6 == 2)? _saxi_resetval_2 : 
                  (_tmp_6 == 3)? _saxi_resetval_3 : 
                  (_tmp_6 == 4)? _saxi_resetval_4 : 
                  (_tmp_6 == 5)? _saxi_resetval_5 : 
                  (_tmp_6 == 6)? _saxi_resetval_6 : 
                  (_tmp_6 == 7)? _saxi_resetval_7 : 'hx;
  reg _saxi_cond_0_1;
  assign saxi_wready = _saxi_register_fsm == 3;
  reg [32-1:0] th_matmul;
  localparam th_matmul_init = 0;
  reg signed [32-1:0] _th_matmul_matrix_size_0;
  reg signed [32-1:0] _th_matmul_a_offset_1;
  reg signed [32-1:0] _th_matmul_b_offset_2;
  reg signed [32-1:0] _th_matmul_c_offset_3;
  reg signed [32-1:0] _th_matmul_matrix_size_4;
  reg signed [32-1:0] _th_matmul_a_offset_5;
  reg signed [32-1:0] _th_matmul_b_offset_6;
  reg signed [32-1:0] _th_matmul_c_offset_7;
  reg signed [32-1:0] _th_matmul_a_addr_8;
  reg signed [32-1:0] _th_matmul_c_addr_9;
  reg signed [32-1:0] _th_matmul_i_10;
  reg axim_flag_10;
  reg [32-1:0] _d1_th_matmul;
  reg _th_matmul_cond_11_0_1;
  reg _maxi_ram_a_0_read_start;
  reg [8-1:0] _maxi_ram_a_0_read_op_sel;
  reg [32-1:0] _maxi_ram_a_0_read_local_addr;
  reg [32-1:0] _maxi_ram_a_0_read_global_addr;
  reg [33-1:0] _maxi_ram_a_0_read_size;
  reg [32-1:0] _maxi_ram_a_0_read_local_stride;
  reg [32-1:0] _maxi_read_fsm;
  localparam _maxi_read_fsm_init = 0;
  reg [32-1:0] _maxi_read_cur_global_addr;
  reg [33-1:0] _maxi_read_cur_size;
  reg [33-1:0] _maxi_read_rest_size;
  reg [32-1:0] _wdata_11;
  reg _wvalid_12;
  reg [33-1:0] _tmp_13;
  reg _tmp_14;
  wire [32-1:0] _dataflow__variable_odata_0;
  wire _dataflow__variable_ovalid_0;
  wire _dataflow__variable_oready_0;
  assign _dataflow__variable_oready_0 = (_tmp_13 > 0) && !_tmp_14;
  reg [10-1:0] _tmp_15;
  reg [32-1:0] _tmp_16;
  reg _tmp_17;
  assign ram_a_0_wdata = (_tmp_17)? _tmp_16 : 'hx;
  assign ram_a_0_wenable = (_tmp_17)? 1'd1 : 0;
  reg _ram_a_cond_0_1;
  reg [9-1:0] counter_18;
  reg _maxi_cond_0_1;
  assign maxi_rready = _maxi_read_fsm == 3;
  reg [32-1:0] _d1__maxi_read_fsm;
  reg __maxi_read_fsm_cond_3_0_1;
  reg axim_flag_19;
  reg __maxi_read_fsm_cond_4_1_1;
  reg signed [32-1:0] _th_matmul_b_addr_11;
  reg signed [32-1:0] _th_matmul_j_12;
  reg axim_flag_20;
  reg _th_matmul_cond_18_1_1;
  reg _maxi_ram_b_0_read_start;
  reg [8-1:0] _maxi_ram_b_0_read_op_sel;
  reg [32-1:0] _maxi_ram_b_0_read_local_addr;
  reg [32-1:0] _maxi_ram_b_0_read_global_addr;
  reg [33-1:0] _maxi_ram_b_0_read_size;
  reg [32-1:0] _maxi_ram_b_0_read_local_stride;
  reg [32-1:0] _wdata_21;
  reg _wvalid_22;
  reg [33-1:0] _tmp_23;
  reg _tmp_24;
  wire [32-1:0] _dataflow__variable_odata_1;
  wire _dataflow__variable_ovalid_1;
  wire _dataflow__variable_oready_1;
  assign _dataflow__variable_oready_1 = (_tmp_23 > 0) && !_tmp_24;
  reg [10-1:0] _tmp_25;
  reg [32-1:0] _tmp_26;
  reg _tmp_27;
  assign ram_b_0_wdata = (_tmp_27)? _tmp_26 : 'hx;
  assign ram_b_0_wenable = (_tmp_27)? 1'd1 : 0;
  reg _ram_b_cond_0_1;
  reg __maxi_read_fsm_cond_3_2_1;
  reg signed [32-1:0] _th_matmul_sum_13;
  reg signed [32-1:0] _th_matmul_k_14;
  assign ram_a_0_addr = (th_matmul == 25)? _th_matmul_k_14 : 
                        (_tmp_17)? _tmp_15 : 'hx;
  assign ram_a_0_enable = (th_matmul == 25)? 1'd1 : 
                          (_tmp_17)? 1'd1 : 0;
  localparam _tmp_28 = 1;
  wire [_tmp_28-1:0] _tmp_29;
  assign _tmp_29 = th_matmul == 25;
  reg [_tmp_28-1:0] __tmp_29_1;
  reg signed [32-1:0] _tmp_30;
  reg signed [32-1:0] _th_matmul_x_15;
  assign ram_b_0_addr = (th_matmul == 27)? _th_matmul_k_14 : 
                        (_tmp_27)? _tmp_25 : 'hx;
  assign ram_b_0_enable = (th_matmul == 27)? 1'd1 : 
                          (_tmp_27)? 1'd1 : 0;
  localparam _tmp_31 = 1;
  wire [_tmp_31-1:0] _tmp_32;
  assign _tmp_32 = th_matmul == 27;
  reg [_tmp_31-1:0] __tmp_32_1;
  reg signed [32-1:0] _tmp_33;
  reg signed [32-1:0] _th_matmul_y_16;
  assign ram_c_0_wdata = (th_matmul == 31)? _th_matmul_sum_13 : 'hx;
  assign ram_c_0_wenable = (th_matmul == 31)? 1'd1 : 0;
  reg axim_flag_34;
  reg _th_matmul_cond_34_2_1;
  reg _maxi_ram_c_0_write_start;
  reg [8-1:0] _maxi_ram_c_0_write_op_sel;
  reg [32-1:0] _maxi_ram_c_0_write_local_addr;
  reg [32-1:0] _maxi_ram_c_0_write_global_addr;
  reg [33-1:0] _maxi_ram_c_0_write_size;
  reg [32-1:0] _maxi_ram_c_0_write_local_stride;
  reg [32-1:0] _maxi_write_fsm;
  localparam _maxi_write_fsm_init = 0;
  reg [32-1:0] _maxi_write_cur_global_addr;
  reg [33-1:0] _maxi_write_cur_size;
  reg [33-1:0] _maxi_write_rest_size;
  reg _tmp_35;
  reg _tmp_36;
  wire _tmp_37;
  wire _tmp_38;
  assign _tmp_38 = 1;
  wire signed [32-1:0] _tmp_39;
  assign _tmp_39 = ram_c_0_rdata;
  reg _tmp_40;
  reg _tmp_41;
  reg _tmp_42;
  reg _tmp_43;
  reg [33-1:0] _tmp_44;
  reg [10-1:0] _tmp_45;
  assign ram_c_0_addr = (_tmp_40)? _tmp_45 : 
                        (th_matmul == 31)? _th_matmul_j_12 : 'hx;
  assign ram_c_0_enable = ((_tmp_37 || !_tmp_35) && (_tmp_38 || !_tmp_36) && _tmp_40)? 1'd1 : 
                          (th_matmul == 31)? 1'd1 : 0;
  reg [9-1:0] counter_46;
  reg _maxi_cond_1_1;
  reg last_47;
  wire [32-1:0] _dataflow__variable_odata_2;
  wire _dataflow__variable_ovalid_2;
  wire _dataflow__variable_oready_2;
  assign _dataflow__variable_oready_2 = (_maxi_write_fsm == 3) && (_maxi_write_op_sel == 1) && ((counter_46 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid));
  reg _maxi_cond_2_1;
  assign _maxi_write_data_done = (last_47 && maxi_wvalid && maxi_wready)? 1 : 0;
  reg axim_flag_48;
  reg [32-1:0] _d1__maxi_write_fsm;
  reg __maxi_write_fsm_cond_4_0_1;

  always @(posedge CLK) begin
    if(RST) begin
      _tmp_15 <= 0;
      _tmp_13 <= 0;
      _tmp_16 <= 0;
      _tmp_17 <= 0;
      _tmp_14 <= 0;
      _ram_a_cond_0_1 <= 0;
      __tmp_29_1 <= 0;
    end else begin
      if(_ram_a_cond_0_1) begin
        _tmp_17 <= 0;
        _tmp_14 <= 0;
      end 
      if(_maxi_read_start && (_maxi_read_op_sel == 1) && (_tmp_13 == 0)) begin
        _tmp_15 <= _maxi_read_local_addr - _maxi_read_local_stride;
        _tmp_13 <= _maxi_read_size;
      end 
      if(_dataflow__variable_ovalid_0 && ((_tmp_13 > 0) && !_tmp_14) && (_tmp_13 > 0)) begin
        _tmp_15 <= _tmp_15 + _maxi_read_local_stride;
        _tmp_16 <= _dataflow__variable_odata_0;
        _tmp_17 <= 1;
        _tmp_13 <= _tmp_13 - 1;
      end 
      if(_dataflow__variable_ovalid_0 && ((_tmp_13 > 0) && !_tmp_14) && (_tmp_13 == 1)) begin
        _tmp_14 <= 1;
      end 
      _ram_a_cond_0_1 <= 1;
      __tmp_29_1 <= _tmp_29;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      _tmp_25 <= 0;
      _tmp_23 <= 0;
      _tmp_26 <= 0;
      _tmp_27 <= 0;
      _tmp_24 <= 0;
      _ram_b_cond_0_1 <= 0;
      __tmp_32_1 <= 0;
    end else begin
      if(_ram_b_cond_0_1) begin
        _tmp_27 <= 0;
        _tmp_24 <= 0;
      end 
      if(_maxi_read_start && (_maxi_read_op_sel == 2) && (_tmp_23 == 0)) begin
        _tmp_25 <= _maxi_read_local_addr - _maxi_read_local_stride;
        _tmp_23 <= _maxi_read_size;
      end 
      if(_dataflow__variable_ovalid_1 && ((_tmp_23 > 0) && !_tmp_24) && (_tmp_23 > 0)) begin
        _tmp_25 <= _tmp_25 + _maxi_read_local_stride;
        _tmp_26 <= _dataflow__variable_odata_1;
        _tmp_27 <= 1;
        _tmp_23 <= _tmp_23 - 1;
      end 
      if(_dataflow__variable_ovalid_1 && ((_tmp_23 > 0) && !_tmp_24) && (_tmp_23 == 1)) begin
        _tmp_24 <= 1;
      end 
      _ram_b_cond_0_1 <= 1;
      __tmp_32_1 <= _tmp_32;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      _tmp_43 <= 0;
      _tmp_35 <= 0;
      _tmp_36 <= 0;
      _tmp_41 <= 0;
      _tmp_42 <= 0;
      _tmp_40 <= 0;
      _tmp_45 <= 0;
      _tmp_44 <= 0;
    end else begin
      if((_tmp_37 || !_tmp_35) && (_tmp_38 || !_tmp_36) && _tmp_41) begin
        _tmp_43 <= 0;
        _tmp_35 <= 0;
        _tmp_36 <= 0;
        _tmp_41 <= 0;
      end 
      if((_tmp_37 || !_tmp_35) && (_tmp_38 || !_tmp_36) && _tmp_40) begin
        _tmp_35 <= 1;
        _tmp_36 <= 1;
        _tmp_43 <= _tmp_42;
        _tmp_42 <= 0;
        _tmp_40 <= 0;
        _tmp_41 <= 1;
      end 
      if(_maxi_write_start && (_maxi_write_op_sel == 1) && (_tmp_44 == 0) && !_tmp_42 && !_tmp_43) begin
        _tmp_45 <= _maxi_write_local_addr;
        _tmp_44 <= _maxi_write_size - 1;
        _tmp_40 <= 1;
        _tmp_42 <= _maxi_write_size == 1;
      end 
      if((_tmp_37 || !_tmp_35) && (_tmp_38 || !_tmp_36) && (_tmp_44 > 0)) begin
        _tmp_45 <= _tmp_45 + _maxi_write_local_stride;
        _tmp_44 <= _tmp_44 - 1;
        _tmp_40 <= 1;
        _tmp_42 <= 0;
      end 
      if((_tmp_37 || !_tmp_35) && (_tmp_38 || !_tmp_36) && (_tmp_44 == 1)) begin
        _tmp_42 <= 1;
      end 
    end
  end

  assign _dataflow__variable_odata_2 = _tmp_39;
  assign _dataflow__variable_ovalid_2 = _tmp_35;
  assign _tmp_37 = 1 && _dataflow__variable_oready_2;

  always @(posedge CLK) begin
    if(RST) begin
      outstanding_wcount_0 <= 0;
      _maxi_read_start <= 0;
      _maxi_write_start <= 0;
      _maxi_ram_a_0_read_start <= 0;
      _maxi_ram_a_0_read_op_sel <= 0;
      _maxi_ram_a_0_read_local_addr <= 0;
      _maxi_ram_a_0_read_global_addr <= 0;
      _maxi_ram_a_0_read_size <= 0;
      _maxi_ram_a_0_read_local_stride <= 0;
      _maxi_read_idle <= 1;
      _maxi_read_op_sel <= 0;
      _maxi_read_local_addr <= 0;
      _maxi_read_global_addr <= 0;
      _maxi_read_size <= 0;
      _maxi_read_local_stride <= 0;
      maxi_araddr <= 0;
      maxi_arlen <= 0;
      maxi_arvalid <= 0;
      counter_18 <= 0;
      _maxi_cond_0_1 <= 0;
      _maxi_ram_b_0_read_start <= 0;
      _maxi_ram_b_0_read_op_sel <= 0;
      _maxi_ram_b_0_read_local_addr <= 0;
      _maxi_ram_b_0_read_global_addr <= 0;
      _maxi_ram_b_0_read_size <= 0;
      _maxi_ram_b_0_read_local_stride <= 0;
      _maxi_ram_c_0_write_start <= 0;
      _maxi_ram_c_0_write_op_sel <= 0;
      _maxi_ram_c_0_write_local_addr <= 0;
      _maxi_ram_c_0_write_global_addr <= 0;
      _maxi_ram_c_0_write_size <= 0;
      _maxi_ram_c_0_write_local_stride <= 0;
      _maxi_write_idle <= 1;
      _maxi_write_op_sel <= 0;
      _maxi_write_local_addr <= 0;
      _maxi_write_global_addr <= 0;
      _maxi_write_size <= 0;
      _maxi_write_local_stride <= 0;
      maxi_awaddr <= 0;
      maxi_awlen <= 0;
      maxi_awvalid <= 0;
      counter_46 <= 0;
      _maxi_cond_1_1 <= 0;
      maxi_wdata <= 0;
      maxi_wvalid <= 0;
      maxi_wlast <= 0;
      maxi_wstrb <= 0;
      last_47 <= 0;
      _maxi_cond_2_1 <= 0;
    end else begin
      if(_maxi_cond_0_1) begin
        maxi_arvalid <= 0;
      end 
      if(_maxi_cond_1_1) begin
        maxi_awvalid <= 0;
      end 
      if(_maxi_cond_2_1) begin
        maxi_wvalid <= 0;
        maxi_wlast <= 0;
        last_47 <= 0;
      end 
      if(maxi_wlast && maxi_wvalid && maxi_wready && !(maxi_bvalid && maxi_bready) && (outstanding_wcount_0 < 7)) begin
        outstanding_wcount_0 <= outstanding_wcount_0 + 1;
      end 
      if(!(maxi_wlast && maxi_wvalid && maxi_wready) && (maxi_bvalid && maxi_bready) && (outstanding_wcount_0 > 0)) begin
        outstanding_wcount_0 <= outstanding_wcount_0 - 1;
      end 
      _maxi_read_start <= 0;
      _maxi_write_start <= 0;
      _maxi_ram_a_0_read_start <= 0;
      if(axim_flag_10) begin
        _maxi_ram_a_0_read_start <= 1;
        _maxi_ram_a_0_read_op_sel <= 1;
        _maxi_ram_a_0_read_local_addr <= 0;
        _maxi_ram_a_0_read_global_addr <= _th_matmul_a_addr_8;
        _maxi_ram_a_0_read_size <= _th_matmul_matrix_size_4;
        _maxi_ram_a_0_read_local_stride <= 1;
      end 
      if(_maxi_ram_a_0_read_start) begin
        _maxi_read_idle <= 0;
      end 
      if(_maxi_ram_a_0_read_start) begin
        _maxi_read_start <= 1;
        _maxi_read_op_sel <= _maxi_ram_a_0_read_op_sel;
        _maxi_read_local_addr <= _maxi_ram_a_0_read_local_addr;
        _maxi_read_global_addr <= _maxi_ram_a_0_read_global_addr;
        _maxi_read_size <= _maxi_ram_a_0_read_size;
        _maxi_read_local_stride <= _maxi_ram_a_0_read_local_stride;
      end 
      if((_maxi_read_fsm == 2) && ((maxi_arready || !maxi_arvalid) && (counter_18 == 0))) begin
        maxi_araddr <= _maxi_read_cur_global_addr;
        maxi_arlen <= _maxi_read_cur_size - 1;
        maxi_arvalid <= 1;
        counter_18 <= _maxi_read_cur_size;
      end 
      _maxi_cond_0_1 <= 1;
      if(maxi_arvalid && !maxi_arready) begin
        maxi_arvalid <= maxi_arvalid;
      end 
      if(maxi_rready && maxi_rvalid && (counter_18 > 0)) begin
        counter_18 <= counter_18 - 1;
      end 
      if(axim_flag_19) begin
        _maxi_read_idle <= 1;
      end 
      _maxi_ram_b_0_read_start <= 0;
      if(axim_flag_20) begin
        _maxi_ram_b_0_read_start <= 1;
        _maxi_ram_b_0_read_op_sel <= 2;
        _maxi_ram_b_0_read_local_addr <= 0;
        _maxi_ram_b_0_read_global_addr <= _th_matmul_b_addr_11;
        _maxi_ram_b_0_read_size <= _th_matmul_matrix_size_4;
        _maxi_ram_b_0_read_local_stride <= 1;
      end 
      if(_maxi_ram_b_0_read_start) begin
        _maxi_read_idle <= 0;
      end 
      if(_maxi_ram_b_0_read_start) begin
        _maxi_read_start <= 1;
        _maxi_read_op_sel <= _maxi_ram_b_0_read_op_sel;
        _maxi_read_local_addr <= _maxi_ram_b_0_read_local_addr;
        _maxi_read_global_addr <= _maxi_ram_b_0_read_global_addr;
        _maxi_read_size <= _maxi_ram_b_0_read_size;
        _maxi_read_local_stride <= _maxi_ram_b_0_read_local_stride;
      end 
      _maxi_ram_c_0_write_start <= 0;
      if(axim_flag_34) begin
        _maxi_ram_c_0_write_start <= 1;
        _maxi_ram_c_0_write_op_sel <= 1;
        _maxi_ram_c_0_write_local_addr <= 0;
        _maxi_ram_c_0_write_global_addr <= _th_matmul_c_addr_9;
        _maxi_ram_c_0_write_size <= _th_matmul_matrix_size_4;
        _maxi_ram_c_0_write_local_stride <= 1;
      end 
      if(_maxi_ram_c_0_write_start) begin
        _maxi_write_idle <= 0;
      end 
      if(_maxi_ram_c_0_write_start) begin
        _maxi_write_start <= 1;
        _maxi_write_op_sel <= _maxi_ram_c_0_write_op_sel;
        _maxi_write_local_addr <= _maxi_ram_c_0_write_local_addr;
        _maxi_write_global_addr <= _maxi_ram_c_0_write_global_addr;
        _maxi_write_size <= _maxi_ram_c_0_write_size;
        _maxi_write_local_stride <= _maxi_ram_c_0_write_local_stride;
      end 
      if((_maxi_write_fsm == 2) && ((maxi_awready || !maxi_awvalid) && (counter_46 == 0))) begin
        maxi_awaddr <= _maxi_write_cur_global_addr;
        maxi_awlen <= _maxi_write_cur_size - 1;
        maxi_awvalid <= 1;
        counter_46 <= _maxi_write_cur_size;
      end 
      if((_maxi_write_fsm == 2) && ((maxi_awready || !maxi_awvalid) && (counter_46 == 0)) && (_maxi_write_cur_size == 0)) begin
        maxi_awvalid <= 0;
      end 
      _maxi_cond_1_1 <= 1;
      if(maxi_awvalid && !maxi_awready) begin
        maxi_awvalid <= maxi_awvalid;
      end 
      if(_dataflow__variable_ovalid_2 && ((_maxi_write_fsm == 3) && (_maxi_write_op_sel == 1) && ((counter_46 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid))) && ((counter_46 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid) && (counter_46 > 0))) begin
        maxi_wdata <= _dataflow__variable_odata_2;
        maxi_wvalid <= 1;
        maxi_wlast <= 0;
        maxi_wstrb <= { 4{ 1'd1 } };
        counter_46 <= counter_46 - 1;
      end 
      if(_dataflow__variable_ovalid_2 && ((_maxi_write_fsm == 3) && (_maxi_write_op_sel == 1) && ((counter_46 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid))) && ((counter_46 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid) && (counter_46 > 0)) && (counter_46 == 1)) begin
        maxi_wlast <= 1;
        last_47 <= 1;
      end 
      _maxi_cond_2_1 <= 1;
      if(maxi_wvalid && !maxi_wready) begin
        maxi_wvalid <= maxi_wvalid;
        maxi_wlast <= maxi_wlast;
        last_47 <= last_47;
      end 
      if(axim_flag_48) begin
        _maxi_write_idle <= 1;
      end 
    end
  end

  assign _dataflow__variable_odata_0 = _wdata_11;
  assign _dataflow__variable_ovalid_0 = _wvalid_12;
  assign _dataflow__variable_odata_1 = _wdata_21;
  assign _dataflow__variable_ovalid_1 = _wvalid_22;

  always @(posedge CLK) begin
    if(RST) begin
      saxi_bvalid <= 0;
      prev_awvalid_4 <= 0;
      prev_arvalid_5 <= 0;
      writevalid_2 <= 0;
      readvalid_3 <= 0;
      addr_1 <= 0;
      saxi_rdata <= 0;
      saxi_rvalid <= 0;
      _saxi_cond_0_1 <= 0;
      _saxi_register_0 <= 0;
      _saxi_flag_0 <= 0;
      _saxi_register_1 <= 0;
      _saxi_flag_1 <= 0;
      _saxi_register_2 <= 0;
      _saxi_flag_2 <= 0;
      _saxi_register_3 <= 0;
      _saxi_flag_3 <= 0;
      _saxi_register_4 <= 0;
      _saxi_flag_4 <= 0;
      _saxi_register_5 <= 0;
      _saxi_flag_5 <= 0;
      _saxi_register_6 <= 0;
      _saxi_flag_6 <= 0;
      _saxi_register_7 <= 0;
      _saxi_flag_7 <= 0;
      _saxi_resetval_0 <= 0;
      _saxi_resetval_1 <= 0;
      _saxi_resetval_2 <= 0;
      _saxi_resetval_3 <= 0;
      _saxi_resetval_4 <= 0;
      _saxi_resetval_5 <= 0;
      _saxi_resetval_6 <= 0;
      _saxi_resetval_7 <= 0;
    end else begin
      if(_saxi_cond_0_1) begin
        saxi_rvalid <= 0;
      end 
      if(saxi_bvalid && saxi_bready) begin
        saxi_bvalid <= 0;
      end 
      if(saxi_wvalid && saxi_wready) begin
        saxi_bvalid <= 1;
      end 
      prev_awvalid_4 <= saxi_awvalid;
      prev_arvalid_5 <= saxi_arvalid;
      writevalid_2 <= 0;
      readvalid_3 <= 0;
      if(saxi_awready && saxi_awvalid && !saxi_bvalid) begin
        addr_1 <= saxi_awaddr;
        writevalid_2 <= 1;
      end else if(saxi_arready && saxi_arvalid) begin
        addr_1 <= saxi_araddr;
        readvalid_3 <= 1;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid)) begin
        saxi_rdata <= _tmp_7;
        saxi_rvalid <= 1;
      end 
      _saxi_cond_0_1 <= 1;
      if(saxi_rvalid && !saxi_rready) begin
        saxi_rvalid <= saxi_rvalid;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 0)) begin
        _saxi_register_0 <= _tmp_9;
        _saxi_flag_0 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 1)) begin
        _saxi_register_1 <= _tmp_9;
        _saxi_flag_1 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 2)) begin
        _saxi_register_2 <= _tmp_9;
        _saxi_flag_2 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 3)) begin
        _saxi_register_3 <= _tmp_9;
        _saxi_flag_3 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 4)) begin
        _saxi_register_4 <= _tmp_9;
        _saxi_flag_4 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 5)) begin
        _saxi_register_5 <= _tmp_9;
        _saxi_flag_5 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 6)) begin
        _saxi_register_6 <= _tmp_9;
        _saxi_flag_6 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_8 && (_tmp_6 == 7)) begin
        _saxi_register_7 <= _tmp_9;
        _saxi_flag_7 <= 0;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 0)) begin
        _saxi_register_0 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 1)) begin
        _saxi_register_1 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 2)) begin
        _saxi_register_2 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 3)) begin
        _saxi_register_3 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 4)) begin
        _saxi_register_4 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 5)) begin
        _saxi_register_5 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 6)) begin
        _saxi_register_6 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_6 == 7)) begin
        _saxi_register_7 <= saxi_wdata;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 1) begin
        _saxi_register_0 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_1 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_2 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_3 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_4 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_5 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_6 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_matmul == 2) && 0) begin
        _saxi_register_7 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_0 <= 1;
        _saxi_flag_0 <= 1;
        _saxi_resetval_0 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_1 <= 1;
        _saxi_flag_1 <= 1;
        _saxi_resetval_1 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_2 <= 1;
        _saxi_flag_2 <= 1;
        _saxi_resetval_2 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_3 <= 1;
        _saxi_flag_3 <= 1;
        _saxi_resetval_3 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_4 <= 1;
        _saxi_flag_4 <= 1;
        _saxi_resetval_4 <= 0;
      end 
      if((th_matmul == 41) && 1) begin
        _saxi_register_5 <= 1;
        _saxi_flag_5 <= 1;
        _saxi_resetval_5 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_6 <= 1;
        _saxi_flag_6 <= 1;
        _saxi_resetval_6 <= 0;
      end 
      if((th_matmul == 41) && 0) begin
        _saxi_register_7 <= 1;
        _saxi_flag_7 <= 1;
        _saxi_resetval_7 <= 0;
      end 
    end
  end

  localparam _saxi_register_fsm_1 = 1;
  localparam _saxi_register_fsm_2 = 2;
  localparam _saxi_register_fsm_3 = 3;

  always @(posedge CLK) begin
    if(RST) begin
      _saxi_register_fsm <= _saxi_register_fsm_init;
    end else begin
      case(_saxi_register_fsm)
        _saxi_register_fsm_init: begin
          if(readvalid_3 || writevalid_2) begin
            _tmp_6 <= (addr_1 >> _saxi_shift) & _saxi_mask;
          end 
          if(readvalid_3) begin
            _saxi_register_fsm <= _saxi_register_fsm_1;
          end 
          if(writevalid_2) begin
            _saxi_register_fsm <= _saxi_register_fsm_3;
          end 
        end
        _saxi_register_fsm_1: begin
          if(saxi_rready && saxi_rvalid) begin
            _saxi_register_fsm <= _saxi_register_fsm_init;
          end 
          if((saxi_rready || !saxi_rvalid) && !(saxi_rready && saxi_rvalid)) begin
            _saxi_register_fsm <= _saxi_register_fsm_2;
          end 
        end
        _saxi_register_fsm_2: begin
          if(saxi_rready && saxi_rvalid) begin
            _saxi_register_fsm <= _saxi_register_fsm_init;
          end 
        end
        _saxi_register_fsm_3: begin
          if(saxi_wready && saxi_wvalid) begin
            _saxi_register_fsm <= _saxi_register_fsm_init;
          end 
        end
      endcase
    end
  end

  localparam th_matmul_1 = 1;
  localparam th_matmul_2 = 2;
  localparam th_matmul_3 = 3;
  localparam th_matmul_4 = 4;
  localparam th_matmul_5 = 5;
  localparam th_matmul_6 = 6;
  localparam th_matmul_7 = 7;
  localparam th_matmul_8 = 8;
  localparam th_matmul_9 = 9;
  localparam th_matmul_10 = 10;
  localparam th_matmul_11 = 11;
  localparam th_matmul_12 = 12;
  localparam th_matmul_13 = 13;
  localparam th_matmul_14 = 14;
  localparam th_matmul_15 = 15;
  localparam th_matmul_16 = 16;
  localparam th_matmul_17 = 17;
  localparam th_matmul_18 = 18;
  localparam th_matmul_19 = 19;
  localparam th_matmul_20 = 20;
  localparam th_matmul_21 = 21;
  localparam th_matmul_22 = 22;
  localparam th_matmul_23 = 23;
  localparam th_matmul_24 = 24;
  localparam th_matmul_25 = 25;
  localparam th_matmul_26 = 26;
  localparam th_matmul_27 = 27;
  localparam th_matmul_28 = 28;
  localparam th_matmul_29 = 29;
  localparam th_matmul_30 = 30;
  localparam th_matmul_31 = 31;
  localparam th_matmul_32 = 32;
  localparam th_matmul_33 = 33;
  localparam th_matmul_34 = 34;
  localparam th_matmul_35 = 35;
  localparam th_matmul_36 = 36;
  localparam th_matmul_37 = 37;
  localparam th_matmul_38 = 38;
  localparam th_matmul_39 = 39;
  localparam th_matmul_40 = 40;
  localparam th_matmul_41 = 41;
  localparam th_matmul_42 = 42;
  localparam th_matmul_43 = 43;

  always @(posedge CLK) begin
    if(RST) begin
      th_matmul <= th_matmul_init;
      _d1_th_matmul <= th_matmul_init;
      _th_matmul_matrix_size_0 <= 0;
      _th_matmul_a_offset_1 <= 0;
      _th_matmul_b_offset_2 <= 0;
      _th_matmul_c_offset_3 <= 0;
      _th_matmul_matrix_size_4 <= 0;
      _th_matmul_a_offset_5 <= 0;
      _th_matmul_b_offset_6 <= 0;
      _th_matmul_c_offset_7 <= 0;
      _th_matmul_a_addr_8 <= 0;
      _th_matmul_c_addr_9 <= 0;
      _th_matmul_i_10 <= 0;
      axim_flag_10 <= 0;
      _th_matmul_cond_11_0_1 <= 0;
      _th_matmul_b_addr_11 <= 0;
      _th_matmul_j_12 <= 0;
      axim_flag_20 <= 0;
      _th_matmul_cond_18_1_1 <= 0;
      _th_matmul_sum_13 <= 0;
      _th_matmul_k_14 <= 0;
      _tmp_30 <= 0;
      _th_matmul_x_15 <= 0;
      _tmp_33 <= 0;
      _th_matmul_y_16 <= 0;
      axim_flag_34 <= 0;
      _th_matmul_cond_34_2_1 <= 0;
    end else begin
      _d1_th_matmul <= th_matmul;
      case(_d1_th_matmul)
        th_matmul_11: begin
          if(_th_matmul_cond_11_0_1) begin
            axim_flag_10 <= 0;
          end 
        end
        th_matmul_18: begin
          if(_th_matmul_cond_18_1_1) begin
            axim_flag_20 <= 0;
          end 
        end
        th_matmul_34: begin
          if(_th_matmul_cond_34_2_1) begin
            axim_flag_34 <= 0;
          end 
        end
      endcase
      case(th_matmul)
        th_matmul_init: begin
          th_matmul <= th_matmul_1;
        end
        th_matmul_1: begin
          if(1) begin
            th_matmul <= th_matmul_2;
          end else begin
            th_matmul <= th_matmul_43;
          end
        end
        th_matmul_2: begin
          if(_saxi_register_0 == 1) begin
            th_matmul <= th_matmul_3;
          end 
        end
        th_matmul_3: begin
          _th_matmul_matrix_size_0 <= _saxi_register_1;
          th_matmul <= th_matmul_4;
        end
        th_matmul_4: begin
          _th_matmul_a_offset_1 <= _saxi_register_2;
          th_matmul <= th_matmul_5;
        end
        th_matmul_5: begin
          _th_matmul_b_offset_2 <= _saxi_register_3;
          th_matmul <= th_matmul_6;
        end
        th_matmul_6: begin
          _th_matmul_c_offset_3 <= _saxi_register_4;
          th_matmul <= th_matmul_7;
        end
        th_matmul_7: begin
          _th_matmul_matrix_size_4 <= _th_matmul_matrix_size_0;
          _th_matmul_a_offset_5 <= _th_matmul_a_offset_1;
          _th_matmul_b_offset_6 <= _th_matmul_b_offset_2;
          _th_matmul_c_offset_7 <= _th_matmul_c_offset_3;
          th_matmul <= th_matmul_8;
        end
        th_matmul_8: begin
          _th_matmul_a_addr_8 <= _th_matmul_a_offset_5;
          _th_matmul_c_addr_9 <= _th_matmul_c_offset_7;
          th_matmul <= th_matmul_9;
        end
        th_matmul_9: begin
          _th_matmul_i_10 <= 0;
          th_matmul <= th_matmul_10;
        end
        th_matmul_10: begin
          if(_th_matmul_i_10 < _th_matmul_matrix_size_4) begin
            th_matmul <= th_matmul_11;
          end else begin
            th_matmul <= th_matmul_41;
          end
        end
        th_matmul_11: begin
          axim_flag_10 <= 1;
          _th_matmul_cond_11_0_1 <= 1;
          th_matmul <= th_matmul_12;
        end
        th_matmul_12: begin
          th_matmul <= th_matmul_13;
        end
        th_matmul_13: begin
          th_matmul <= th_matmul_14;
        end
        th_matmul_14: begin
          if(_maxi_read_idle) begin
            th_matmul <= th_matmul_15;
          end 
        end
        th_matmul_15: begin
          _th_matmul_b_addr_11 <= _th_matmul_b_offset_6;
          th_matmul <= th_matmul_16;
        end
        th_matmul_16: begin
          _th_matmul_j_12 <= 0;
          th_matmul <= th_matmul_17;
        end
        th_matmul_17: begin
          if(_th_matmul_j_12 < _th_matmul_matrix_size_4) begin
            th_matmul <= th_matmul_18;
          end else begin
            th_matmul <= th_matmul_34;
          end
        end
        th_matmul_18: begin
          axim_flag_20 <= 1;
          _th_matmul_cond_18_1_1 <= 1;
          th_matmul <= th_matmul_19;
        end
        th_matmul_19: begin
          th_matmul <= th_matmul_20;
        end
        th_matmul_20: begin
          th_matmul <= th_matmul_21;
        end
        th_matmul_21: begin
          if(_maxi_read_idle) begin
            th_matmul <= th_matmul_22;
          end 
        end
        th_matmul_22: begin
          _th_matmul_sum_13 <= 0;
          th_matmul <= th_matmul_23;
        end
        th_matmul_23: begin
          _th_matmul_k_14 <= 0;
          th_matmul <= th_matmul_24;
        end
        th_matmul_24: begin
          if(_th_matmul_k_14 < _th_matmul_matrix_size_4) begin
            th_matmul <= th_matmul_25;
          end else begin
            th_matmul <= th_matmul_31;
          end
        end
        th_matmul_25: begin
          if(__tmp_29_1) begin
            _tmp_30 <= ram_a_0_rdata;
          end 
          if(__tmp_29_1) begin
            th_matmul <= th_matmul_26;
          end 
        end
        th_matmul_26: begin
          _th_matmul_x_15 <= _tmp_30;
          th_matmul <= th_matmul_27;
        end
        th_matmul_27: begin
          if(__tmp_32_1) begin
            _tmp_33 <= ram_b_0_rdata;
          end 
          if(__tmp_32_1) begin
            th_matmul <= th_matmul_28;
          end 
        end
        th_matmul_28: begin
          _th_matmul_y_16 <= _tmp_33;
          th_matmul <= th_matmul_29;
        end
        th_matmul_29: begin
          _th_matmul_sum_13 <= _th_matmul_sum_13 + _th_matmul_x_15 * _th_matmul_y_16;
          th_matmul <= th_matmul_30;
        end
        th_matmul_30: begin
          _th_matmul_k_14 <= _th_matmul_k_14 + 1;
          th_matmul <= th_matmul_24;
        end
        th_matmul_31: begin
          th_matmul <= th_matmul_32;
        end
        th_matmul_32: begin
          _th_matmul_b_addr_11 <= _th_matmul_b_addr_11 + (_th_matmul_matrix_size_4 << 2);
          th_matmul <= th_matmul_33;
        end
        th_matmul_33: begin
          _th_matmul_j_12 <= _th_matmul_j_12 + 1;
          th_matmul <= th_matmul_17;
        end
        th_matmul_34: begin
          axim_flag_34 <= 1;
          _th_matmul_cond_34_2_1 <= 1;
          th_matmul <= th_matmul_35;
        end
        th_matmul_35: begin
          th_matmul <= th_matmul_36;
        end
        th_matmul_36: begin
          th_matmul <= th_matmul_37;
        end
        th_matmul_37: begin
          if(_maxi_write_idle && (outstanding_wcount_0 == 0)) begin
            th_matmul <= th_matmul_38;
          end 
        end
        th_matmul_38: begin
          _th_matmul_a_addr_8 <= _th_matmul_a_addr_8 + (_th_matmul_matrix_size_4 << 2);
          th_matmul <= th_matmul_39;
        end
        th_matmul_39: begin
          _th_matmul_c_addr_9 <= _th_matmul_c_addr_9 + (_th_matmul_matrix_size_4 << 2);
          th_matmul <= th_matmul_40;
        end
        th_matmul_40: begin
          _th_matmul_i_10 <= _th_matmul_i_10 + 1;
          th_matmul <= th_matmul_10;
        end
        th_matmul_41: begin
          th_matmul <= th_matmul_42;
        end
        th_matmul_42: begin
          th_matmul <= th_matmul_1;
        end
      endcase
    end
  end

  localparam _maxi_read_fsm_1 = 1;
  localparam _maxi_read_fsm_2 = 2;
  localparam _maxi_read_fsm_3 = 3;
  localparam _maxi_read_fsm_4 = 4;
  localparam _maxi_read_fsm_5 = 5;

  always @(posedge CLK) begin
    if(RST) begin
      _maxi_read_fsm <= _maxi_read_fsm_init;
      _d1__maxi_read_fsm <= _maxi_read_fsm_init;
      _maxi_read_cur_global_addr <= 0;
      _maxi_read_rest_size <= 0;
      _maxi_read_cur_size <= 0;
      __maxi_read_fsm_cond_3_0_1 <= 0;
      _wvalid_12 <= 0;
      _wdata_11 <= 0;
      axim_flag_19 <= 0;
      __maxi_read_fsm_cond_4_1_1 <= 0;
      __maxi_read_fsm_cond_3_2_1 <= 0;
      _wvalid_22 <= 0;
      _wdata_21 <= 0;
    end else begin
      _d1__maxi_read_fsm <= _maxi_read_fsm;
      case(_d1__maxi_read_fsm)
        _maxi_read_fsm_3: begin
          if(__maxi_read_fsm_cond_3_0_1) begin
            _wvalid_12 <= 0;
          end 
          if(__maxi_read_fsm_cond_3_2_1) begin
            _wvalid_22 <= 0;
          end 
        end
        _maxi_read_fsm_4: begin
          if(__maxi_read_fsm_cond_4_1_1) begin
            axim_flag_19 <= 0;
          end 
        end
      endcase
      case(_maxi_read_fsm)
        _maxi_read_fsm_init: begin
          if(_maxi_read_start) begin
            _maxi_read_cur_global_addr <= (_maxi_read_global_addr >> 2) << 2;
            _maxi_read_rest_size <= _maxi_read_size;
          end 
          if(_maxi_read_start && (_maxi_read_op_sel == 1)) begin
            _maxi_read_fsm <= _maxi_read_fsm_1;
          end 
          if(_maxi_read_start && (_maxi_read_op_sel == 2)) begin
            _maxi_read_fsm <= _maxi_read_fsm_1;
          end 
        end
        _maxi_read_fsm_1: begin
          if((_maxi_read_rest_size <= 256) && ((_maxi_read_cur_global_addr & 4095) + (_maxi_read_rest_size << 2) >= 4096)) begin
            _maxi_read_cur_size <= 4096 - (_maxi_read_cur_global_addr & 4095) >> 2;
            _maxi_read_rest_size <= _maxi_read_rest_size - (4096 - (_maxi_read_cur_global_addr & 4095) >> 2);
          end else if(_maxi_read_rest_size <= 256) begin
            _maxi_read_cur_size <= _maxi_read_rest_size;
            _maxi_read_rest_size <= 0;
          end else if((_maxi_read_cur_global_addr & 4095) + 1024 >= 4096) begin
            _maxi_read_cur_size <= 4096 - (_maxi_read_cur_global_addr & 4095) >> 2;
            _maxi_read_rest_size <= _maxi_read_rest_size - (4096 - (_maxi_read_cur_global_addr & 4095) >> 2);
          end else begin
            _maxi_read_cur_size <= 256;
            _maxi_read_rest_size <= _maxi_read_rest_size - 256;
          end
          _maxi_read_fsm <= _maxi_read_fsm_2;
        end
        _maxi_read_fsm_2: begin
          if(maxi_arready || !maxi_arvalid) begin
            _maxi_read_fsm <= _maxi_read_fsm_3;
          end 
        end
        _maxi_read_fsm_3: begin
          __maxi_read_fsm_cond_3_0_1 <= 1;
          if(maxi_rready && maxi_rvalid && (_maxi_read_op_sel == 1)) begin
            _wdata_11 <= maxi_rdata;
            _wvalid_12 <= 1;
          end 
          if(maxi_rready && maxi_rvalid && maxi_rlast) begin
            _maxi_read_cur_global_addr <= _maxi_read_cur_global_addr + (_maxi_read_cur_size << 2);
          end 
          __maxi_read_fsm_cond_3_2_1 <= 1;
          if(maxi_rready && maxi_rvalid && (_maxi_read_op_sel == 2)) begin
            _wdata_21 <= maxi_rdata;
            _wvalid_22 <= 1;
          end 
          if(maxi_rready && maxi_rvalid && maxi_rlast && (_maxi_read_rest_size > 0)) begin
            _maxi_read_fsm <= _maxi_read_fsm_1;
          end 
          if(maxi_rready && maxi_rvalid && maxi_rlast && (_maxi_read_rest_size == 0)) begin
            _maxi_read_fsm <= _maxi_read_fsm_4;
          end 
        end
        _maxi_read_fsm_4: begin
          axim_flag_19 <= 1;
          __maxi_read_fsm_cond_4_1_1 <= 1;
          _maxi_read_fsm <= _maxi_read_fsm_5;
        end
        _maxi_read_fsm_5: begin
          _maxi_read_fsm <= _maxi_read_fsm_init;
        end
      endcase
    end
  end

  localparam _maxi_write_fsm_1 = 1;
  localparam _maxi_write_fsm_2 = 2;
  localparam _maxi_write_fsm_3 = 3;
  localparam _maxi_write_fsm_4 = 4;
  localparam _maxi_write_fsm_5 = 5;

  always @(posedge CLK) begin
    if(RST) begin
      _maxi_write_fsm <= _maxi_write_fsm_init;
      _d1__maxi_write_fsm <= _maxi_write_fsm_init;
      _maxi_write_cur_global_addr <= 0;
      _maxi_write_rest_size <= 0;
      _maxi_write_cur_size <= 0;
      axim_flag_48 <= 0;
      __maxi_write_fsm_cond_4_0_1 <= 0;
    end else begin
      _d1__maxi_write_fsm <= _maxi_write_fsm;
      case(_d1__maxi_write_fsm)
        _maxi_write_fsm_4: begin
          if(__maxi_write_fsm_cond_4_0_1) begin
            axim_flag_48 <= 0;
          end 
        end
      endcase
      case(_maxi_write_fsm)
        _maxi_write_fsm_init: begin
          if(_maxi_write_start) begin
            _maxi_write_cur_global_addr <= (_maxi_write_global_addr >> 2) << 2;
            _maxi_write_rest_size <= _maxi_write_size;
          end 
          if(_maxi_write_start && (_maxi_write_op_sel == 1)) begin
            _maxi_write_fsm <= _maxi_write_fsm_1;
          end 
        end
        _maxi_write_fsm_1: begin
          if((_maxi_write_rest_size <= 256) && ((_maxi_write_cur_global_addr & 4095) + (_maxi_write_rest_size << 2) >= 4096)) begin
            _maxi_write_cur_size <= 4096 - (_maxi_write_cur_global_addr & 4095) >> 2;
            _maxi_write_rest_size <= _maxi_write_rest_size - (4096 - (_maxi_write_cur_global_addr & 4095) >> 2);
          end else if(_maxi_write_rest_size <= 256) begin
            _maxi_write_cur_size <= _maxi_write_rest_size;
            _maxi_write_rest_size <= 0;
          end else if((_maxi_write_cur_global_addr & 4095) + 1024 >= 4096) begin
            _maxi_write_cur_size <= 4096 - (_maxi_write_cur_global_addr & 4095) >> 2;
            _maxi_write_rest_size <= _maxi_write_rest_size - (4096 - (_maxi_write_cur_global_addr & 4095) >> 2);
          end else begin
            _maxi_write_cur_size <= 256;
            _maxi_write_rest_size <= _maxi_write_rest_size - 256;
          end
          _maxi_write_fsm <= _maxi_write_fsm_2;
        end
        _maxi_write_fsm_2: begin
          if(maxi_awready || !maxi_awvalid) begin
            _maxi_write_fsm <= _maxi_write_fsm_3;
          end 
        end
        _maxi_write_fsm_3: begin
          if(_maxi_write_data_done) begin
            _maxi_write_cur_global_addr <= _maxi_write_cur_global_addr + (_maxi_write_cur_size << 2);
          end 
          if(_maxi_write_data_done && (_maxi_write_rest_size > 0)) begin
            _maxi_write_fsm <= _maxi_write_fsm_1;
          end 
          if(_maxi_write_data_done && (_maxi_write_rest_size == 0)) begin
            _maxi_write_fsm <= _maxi_write_fsm_4;
          end 
        end
        _maxi_write_fsm_4: begin
          axim_flag_48 <= 1;
          __maxi_write_fsm_cond_4_0_1 <= 1;
          _maxi_write_fsm <= _maxi_write_fsm_5;
        end
        _maxi_write_fsm_5: begin
          _maxi_write_fsm <= _maxi_write_fsm_init;
        end
      endcase
    end
  end


endmodule



module ram_a
(
  input CLK,
  input [10-1:0] ram_a_0_addr,
  output [32-1:0] ram_a_0_rdata,
  input [32-1:0] ram_a_0_wdata,
  input ram_a_0_wenable,
  input ram_a_0_enable
);

  reg [32-1:0] ram_a_0_rdata_out;
  assign ram_a_0_rdata = ram_a_0_rdata_out;
  reg [32-1:0] mem [0:1024-1];

  always @(posedge CLK) begin
    if(ram_a_0_enable) begin
      if(ram_a_0_wenable) begin
        mem[ram_a_0_addr] <= ram_a_0_wdata;
        ram_a_0_rdata_out <= ram_a_0_wdata;
      end else begin
        ram_a_0_rdata_out <= mem[ram_a_0_addr];
      end
    end 
  end


endmodule



module ram_b
(
  input CLK,
  input [10-1:0] ram_b_0_addr,
  output [32-1:0] ram_b_0_rdata,
  input [32-1:0] ram_b_0_wdata,
  input ram_b_0_wenable,
  input ram_b_0_enable
);

  reg [32-1:0] ram_b_0_rdata_out;
  assign ram_b_0_rdata = ram_b_0_rdata_out;
  reg [32-1:0] mem [0:1024-1];

  always @(posedge CLK) begin
    if(ram_b_0_enable) begin
      if(ram_b_0_wenable) begin
        mem[ram_b_0_addr] <= ram_b_0_wdata;
        ram_b_0_rdata_out <= ram_b_0_wdata;
      end else begin
        ram_b_0_rdata_out <= mem[ram_b_0_addr];
      end
    end 
  end


endmodule



module ram_c
(
  input CLK,
  input [10-1:0] ram_c_0_addr,
  output [32-1:0] ram_c_0_rdata,
  input [32-1:0] ram_c_0_wdata,
  input ram_c_0_wenable,
  input ram_c_0_enable
);

  reg [32-1:0] ram_c_0_rdata_out;
  assign ram_c_0_rdata = ram_c_0_rdata_out;
  reg [32-1:0] mem [0:1024-1];

  always @(posedge CLK) begin
    if(ram_c_0_enable) begin
      if(ram_c_0_wenable) begin
        mem[ram_c_0_addr] <= ram_c_0_wdata;
        ram_c_0_rdata_out <= ram_c_0_wdata;
      end else begin
        ram_c_0_rdata_out <= mem[ram_c_0_addr];
      end
    end 
  end


endmodule

