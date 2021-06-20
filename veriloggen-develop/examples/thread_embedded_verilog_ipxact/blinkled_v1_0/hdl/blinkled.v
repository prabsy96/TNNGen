

module blinkled
(
  input CLK,
  input RST,
  output reg [8-1:0] led,
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

  reg [31:0] sum;
  always @(posedge CLK) begin
    if(RST) begin
      sum <= 0;
      led <= 0;
    end else begin
      if(ram_a_0_wenable) begin
        sum <= sum + ram_a_0_wdata;
      end
      led <= sum;
    end 
  end

  reg [32-1:0] th_memcpy;
  localparam th_memcpy_init = 0;
  reg signed [32-1:0] _th_memcpy_copy_bytes_20;
  reg signed [32-1:0] _th_memcpy_src_offset_21;
  reg signed [32-1:0] _th_memcpy_dst_offset_22;
  reg signed [32-1:0] _th_memcpy_copy_bytes_23;
  reg signed [32-1:0] _th_memcpy_src_offset_24;
  reg signed [32-1:0] _th_memcpy_dst_offset_25;
  reg signed [32-1:0] _th_memcpy_rest_words_26;
  reg signed [32-1:0] _th_memcpy_src_global_addr_27;
  reg signed [32-1:0] _th_memcpy_dst_global_addr_28;
  reg signed [32-1:0] _th_memcpy_local_addr_29;
  reg signed [32-1:0] _th_memcpy_dma_size_30;
  reg axim_flag_10;
  reg [32-1:0] _d1_th_memcpy;
  reg _th_memcpy_cond_16_0_1;
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
  wire [32-1:0] _dataflow__variable_odata_3;
  wire _dataflow__variable_ovalid_3;
  wire _dataflow__variable_oready_3;
  assign _dataflow__variable_oready_3 = (_tmp_13 > 0) && !_tmp_14;
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
  reg axim_flag_20;
  reg _th_memcpy_cond_20_1_1;
  reg _maxi_ram_a_0_write_start;
  reg [8-1:0] _maxi_ram_a_0_write_op_sel;
  reg [32-1:0] _maxi_ram_a_0_write_local_addr;
  reg [32-1:0] _maxi_ram_a_0_write_global_addr;
  reg [33-1:0] _maxi_ram_a_0_write_size;
  reg [32-1:0] _maxi_ram_a_0_write_local_stride;
  reg [32-1:0] _maxi_write_fsm;
  localparam _maxi_write_fsm_init = 0;
  reg [32-1:0] _maxi_write_cur_global_addr;
  reg [33-1:0] _maxi_write_cur_size;
  reg [33-1:0] _maxi_write_rest_size;
  reg _tmp_21;
  reg _tmp_22;
  wire _tmp_23;
  wire _tmp_24;
  assign _tmp_24 = 1;
  wire signed [32-1:0] _tmp_25;
  assign _tmp_25 = ram_a_0_rdata;
  reg _tmp_26;
  reg _tmp_27;
  reg _tmp_28;
  reg _tmp_29;
  reg [33-1:0] _tmp_30;
  reg [10-1:0] _tmp_31;
  assign ram_a_0_addr = (_tmp_26)? _tmp_31 : 
                        (_tmp_17)? _tmp_15 : 'hx;
  assign ram_a_0_enable = ((_tmp_23 || !_tmp_21) && (_tmp_24 || !_tmp_22) && _tmp_26)? 1'd1 : 
                          (_tmp_17)? 1'd1 : 0;
  reg [9-1:0] counter_32;
  reg _maxi_cond_1_1;
  reg last_33;
  wire [32-1:0] _dataflow__variable_odata_4;
  wire _dataflow__variable_ovalid_4;
  wire _dataflow__variable_oready_4;
  assign _dataflow__variable_oready_4 = (_maxi_write_fsm == 3) && (_maxi_write_op_sel == 1) && ((counter_32 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid));
  reg _maxi_cond_2_1;
  assign _maxi_write_data_done = (last_33 && maxi_wvalid && maxi_wready)? 1 : 0;
  reg axim_flag_34;
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
      _tmp_29 <= 0;
      _tmp_21 <= 0;
      _tmp_22 <= 0;
      _tmp_27 <= 0;
      _tmp_28 <= 0;
      _tmp_26 <= 0;
      _tmp_31 <= 0;
      _tmp_30 <= 0;
    end else begin
      if(_ram_a_cond_0_1) begin
        _tmp_17 <= 0;
        _tmp_14 <= 0;
      end 
      if(_maxi_read_start && (_maxi_read_op_sel == 1) && (_tmp_13 == 0)) begin
        _tmp_15 <= _maxi_read_local_addr - _maxi_read_local_stride;
        _tmp_13 <= _maxi_read_size;
      end 
      if(_dataflow__variable_ovalid_3 && ((_tmp_13 > 0) && !_tmp_14) && (_tmp_13 > 0)) begin
        _tmp_15 <= _tmp_15 + _maxi_read_local_stride;
        _tmp_16 <= _dataflow__variable_odata_3;
        _tmp_17 <= 1;
        _tmp_13 <= _tmp_13 - 1;
      end 
      if(_dataflow__variable_ovalid_3 && ((_tmp_13 > 0) && !_tmp_14) && (_tmp_13 == 1)) begin
        _tmp_14 <= 1;
      end 
      _ram_a_cond_0_1 <= 1;
      if((_tmp_23 || !_tmp_21) && (_tmp_24 || !_tmp_22) && _tmp_27) begin
        _tmp_29 <= 0;
        _tmp_21 <= 0;
        _tmp_22 <= 0;
        _tmp_27 <= 0;
      end 
      if((_tmp_23 || !_tmp_21) && (_tmp_24 || !_tmp_22) && _tmp_26) begin
        _tmp_21 <= 1;
        _tmp_22 <= 1;
        _tmp_29 <= _tmp_28;
        _tmp_28 <= 0;
        _tmp_26 <= 0;
        _tmp_27 <= 1;
      end 
      if(_maxi_write_start && (_maxi_write_op_sel == 1) && (_tmp_30 == 0) && !_tmp_28 && !_tmp_29) begin
        _tmp_31 <= _maxi_write_local_addr;
        _tmp_30 <= _maxi_write_size - 1;
        _tmp_26 <= 1;
        _tmp_28 <= _maxi_write_size == 1;
      end 
      if((_tmp_23 || !_tmp_21) && (_tmp_24 || !_tmp_22) && (_tmp_30 > 0)) begin
        _tmp_31 <= _tmp_31 + _maxi_write_local_stride;
        _tmp_30 <= _tmp_30 - 1;
        _tmp_26 <= 1;
        _tmp_28 <= 0;
      end 
      if((_tmp_23 || !_tmp_21) && (_tmp_24 || !_tmp_22) && (_tmp_30 == 1)) begin
        _tmp_28 <= 1;
      end 
    end
  end

  assign _dataflow__variable_odata_4 = _tmp_25;
  assign _dataflow__variable_ovalid_4 = _tmp_21;
  assign _tmp_23 = 1 && _dataflow__variable_oready_4;

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
      _maxi_ram_a_0_write_start <= 0;
      _maxi_ram_a_0_write_op_sel <= 0;
      _maxi_ram_a_0_write_local_addr <= 0;
      _maxi_ram_a_0_write_global_addr <= 0;
      _maxi_ram_a_0_write_size <= 0;
      _maxi_ram_a_0_write_local_stride <= 0;
      _maxi_write_idle <= 1;
      _maxi_write_op_sel <= 0;
      _maxi_write_local_addr <= 0;
      _maxi_write_global_addr <= 0;
      _maxi_write_size <= 0;
      _maxi_write_local_stride <= 0;
      maxi_awaddr <= 0;
      maxi_awlen <= 0;
      maxi_awvalid <= 0;
      counter_32 <= 0;
      _maxi_cond_1_1 <= 0;
      maxi_wdata <= 0;
      maxi_wvalid <= 0;
      maxi_wlast <= 0;
      maxi_wstrb <= 0;
      last_33 <= 0;
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
        last_33 <= 0;
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
        _maxi_ram_a_0_read_local_addr <= _th_memcpy_local_addr_29;
        _maxi_ram_a_0_read_global_addr <= _th_memcpy_src_global_addr_27;
        _maxi_ram_a_0_read_size <= _th_memcpy_dma_size_30;
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
      _maxi_ram_a_0_write_start <= 0;
      if(axim_flag_20) begin
        _maxi_ram_a_0_write_start <= 1;
        _maxi_ram_a_0_write_op_sel <= 1;
        _maxi_ram_a_0_write_local_addr <= _th_memcpy_local_addr_29;
        _maxi_ram_a_0_write_global_addr <= _th_memcpy_dst_global_addr_28;
        _maxi_ram_a_0_write_size <= _th_memcpy_dma_size_30;
        _maxi_ram_a_0_write_local_stride <= 1;
      end 
      if(_maxi_ram_a_0_write_start) begin
        _maxi_write_idle <= 0;
      end 
      if(_maxi_ram_a_0_write_start) begin
        _maxi_write_start <= 1;
        _maxi_write_op_sel <= _maxi_ram_a_0_write_op_sel;
        _maxi_write_local_addr <= _maxi_ram_a_0_write_local_addr;
        _maxi_write_global_addr <= _maxi_ram_a_0_write_global_addr;
        _maxi_write_size <= _maxi_ram_a_0_write_size;
        _maxi_write_local_stride <= _maxi_ram_a_0_write_local_stride;
      end 
      if((_maxi_write_fsm == 2) && ((maxi_awready || !maxi_awvalid) && (counter_32 == 0))) begin
        maxi_awaddr <= _maxi_write_cur_global_addr;
        maxi_awlen <= _maxi_write_cur_size - 1;
        maxi_awvalid <= 1;
        counter_32 <= _maxi_write_cur_size;
      end 
      if((_maxi_write_fsm == 2) && ((maxi_awready || !maxi_awvalid) && (counter_32 == 0)) && (_maxi_write_cur_size == 0)) begin
        maxi_awvalid <= 0;
      end 
      _maxi_cond_1_1 <= 1;
      if(maxi_awvalid && !maxi_awready) begin
        maxi_awvalid <= maxi_awvalid;
      end 
      if(_dataflow__variable_ovalid_4 && ((_maxi_write_fsm == 3) && (_maxi_write_op_sel == 1) && ((counter_32 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid))) && ((counter_32 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid) && (counter_32 > 0))) begin
        maxi_wdata <= _dataflow__variable_odata_4;
        maxi_wvalid <= 1;
        maxi_wlast <= 0;
        maxi_wstrb <= { 4{ 1'd1 } };
        counter_32 <= counter_32 - 1;
      end 
      if(_dataflow__variable_ovalid_4 && ((_maxi_write_fsm == 3) && (_maxi_write_op_sel == 1) && ((counter_32 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid))) && ((counter_32 > 0) && (outstanding_wcount_0 < 6) && (maxi_wready || !maxi_wvalid) && (counter_32 > 0)) && (counter_32 == 1)) begin
        maxi_wlast <= 1;
        last_33 <= 1;
      end 
      _maxi_cond_2_1 <= 1;
      if(maxi_wvalid && !maxi_wready) begin
        maxi_wvalid <= maxi_wvalid;
        maxi_wlast <= maxi_wlast;
        last_33 <= last_33;
      end 
      if(axim_flag_34) begin
        _maxi_write_idle <= 1;
      end 
    end
  end

  assign _dataflow__variable_odata_3 = _wdata_11;
  assign _dataflow__variable_ovalid_3 = _wvalid_12;

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
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 1) begin
        _saxi_register_0 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_1 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_2 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_3 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_4 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_5 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_6 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_memcpy == 2) && 0) begin
        _saxi_register_7 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
        _saxi_register_0 <= 1;
        _saxi_flag_0 <= 1;
        _saxi_resetval_0 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
        _saxi_register_1 <= 1;
        _saxi_flag_1 <= 1;
        _saxi_resetval_1 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
        _saxi_register_2 <= 1;
        _saxi_flag_2 <= 1;
        _saxi_resetval_2 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
        _saxi_register_3 <= 1;
        _saxi_flag_3 <= 1;
        _saxi_resetval_3 <= 0;
      end 
      if((th_memcpy == 28) && 1) begin
        _saxi_register_4 <= 1;
        _saxi_flag_4 <= 1;
        _saxi_resetval_4 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
        _saxi_register_5 <= 1;
        _saxi_flag_5 <= 1;
        _saxi_resetval_5 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
        _saxi_register_6 <= 1;
        _saxi_flag_6 <= 1;
        _saxi_resetval_6 <= 0;
      end 
      if((th_memcpy == 28) && 0) begin
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

  localparam th_memcpy_1 = 1;
  localparam th_memcpy_2 = 2;
  localparam th_memcpy_3 = 3;
  localparam th_memcpy_4 = 4;
  localparam th_memcpy_5 = 5;
  localparam th_memcpy_6 = 6;
  localparam th_memcpy_7 = 7;
  localparam th_memcpy_8 = 8;
  localparam th_memcpy_9 = 9;
  localparam th_memcpy_10 = 10;
  localparam th_memcpy_11 = 11;
  localparam th_memcpy_12 = 12;
  localparam th_memcpy_13 = 13;
  localparam th_memcpy_14 = 14;
  localparam th_memcpy_15 = 15;
  localparam th_memcpy_16 = 16;
  localparam th_memcpy_17 = 17;
  localparam th_memcpy_18 = 18;
  localparam th_memcpy_19 = 19;
  localparam th_memcpy_20 = 20;
  localparam th_memcpy_21 = 21;
  localparam th_memcpy_22 = 22;
  localparam th_memcpy_23 = 23;
  localparam th_memcpy_24 = 24;
  localparam th_memcpy_25 = 25;
  localparam th_memcpy_26 = 26;
  localparam th_memcpy_27 = 27;
  localparam th_memcpy_28 = 28;
  localparam th_memcpy_29 = 29;
  localparam th_memcpy_30 = 30;

  always @(posedge CLK) begin
    if(RST) begin
      th_memcpy <= th_memcpy_init;
      _d1_th_memcpy <= th_memcpy_init;
      _th_memcpy_copy_bytes_20 <= 0;
      _th_memcpy_src_offset_21 <= 0;
      _th_memcpy_dst_offset_22 <= 0;
      _th_memcpy_copy_bytes_23 <= 0;
      _th_memcpy_src_offset_24 <= 0;
      _th_memcpy_dst_offset_25 <= 0;
      _th_memcpy_rest_words_26 <= 0;
      _th_memcpy_src_global_addr_27 <= 0;
      _th_memcpy_dst_global_addr_28 <= 0;
      _th_memcpy_local_addr_29 <= 0;
      _th_memcpy_dma_size_30 <= 0;
      axim_flag_10 <= 0;
      _th_memcpy_cond_16_0_1 <= 0;
      axim_flag_20 <= 0;
      _th_memcpy_cond_20_1_1 <= 0;
    end else begin
      _d1_th_memcpy <= th_memcpy;
      case(_d1_th_memcpy)
        th_memcpy_16: begin
          if(_th_memcpy_cond_16_0_1) begin
            axim_flag_10 <= 0;
          end 
        end
        th_memcpy_20: begin
          if(_th_memcpy_cond_20_1_1) begin
            axim_flag_20 <= 0;
          end 
        end
      endcase
      case(th_memcpy)
        th_memcpy_init: begin
          th_memcpy <= th_memcpy_1;
        end
        th_memcpy_1: begin
          if(1) begin
            th_memcpy <= th_memcpy_2;
          end else begin
            th_memcpy <= th_memcpy_30;
          end
        end
        th_memcpy_2: begin
          if(_saxi_register_0 == 1) begin
            th_memcpy <= th_memcpy_3;
          end 
        end
        th_memcpy_3: begin
          _th_memcpy_copy_bytes_20 <= _saxi_register_1;
          th_memcpy <= th_memcpy_4;
        end
        th_memcpy_4: begin
          _th_memcpy_src_offset_21 <= _saxi_register_2;
          th_memcpy <= th_memcpy_5;
        end
        th_memcpy_5: begin
          _th_memcpy_dst_offset_22 <= _saxi_register_3;
          th_memcpy <= th_memcpy_6;
        end
        th_memcpy_6: begin
          _th_memcpy_copy_bytes_23 <= _th_memcpy_copy_bytes_20;
          _th_memcpy_src_offset_24 <= _th_memcpy_src_offset_21;
          _th_memcpy_dst_offset_25 <= _th_memcpy_dst_offset_22;
          th_memcpy <= th_memcpy_7;
        end
        th_memcpy_7: begin
          _th_memcpy_rest_words_26 <= _th_memcpy_copy_bytes_23 >>> 2;
          th_memcpy <= th_memcpy_8;
        end
        th_memcpy_8: begin
          _th_memcpy_src_global_addr_27 <= _th_memcpy_src_offset_24;
          th_memcpy <= th_memcpy_9;
        end
        th_memcpy_9: begin
          _th_memcpy_dst_global_addr_28 <= _th_memcpy_dst_offset_25;
          th_memcpy <= th_memcpy_10;
        end
        th_memcpy_10: begin
          _th_memcpy_local_addr_29 <= 0;
          th_memcpy <= th_memcpy_11;
        end
        th_memcpy_11: begin
          if(_th_memcpy_rest_words_26 > 0) begin
            th_memcpy <= th_memcpy_12;
          end else begin
            th_memcpy <= th_memcpy_28;
          end
        end
        th_memcpy_12: begin
          if(_th_memcpy_rest_words_26 > 256) begin
            th_memcpy <= th_memcpy_13;
          end else begin
            th_memcpy <= th_memcpy_15;
          end
        end
        th_memcpy_13: begin
          _th_memcpy_dma_size_30 <= 256;
          th_memcpy <= th_memcpy_14;
        end
        th_memcpy_14: begin
          th_memcpy <= th_memcpy_16;
        end
        th_memcpy_15: begin
          _th_memcpy_dma_size_30 <= _th_memcpy_rest_words_26;
          th_memcpy <= th_memcpy_16;
        end
        th_memcpy_16: begin
          axim_flag_10 <= 1;
          _th_memcpy_cond_16_0_1 <= 1;
          th_memcpy <= th_memcpy_17;
        end
        th_memcpy_17: begin
          th_memcpy <= th_memcpy_18;
        end
        th_memcpy_18: begin
          th_memcpy <= th_memcpy_19;
        end
        th_memcpy_19: begin
          if(_maxi_read_idle) begin
            th_memcpy <= th_memcpy_20;
          end 
        end
        th_memcpy_20: begin
          axim_flag_20 <= 1;
          _th_memcpy_cond_20_1_1 <= 1;
          th_memcpy <= th_memcpy_21;
        end
        th_memcpy_21: begin
          th_memcpy <= th_memcpy_22;
        end
        th_memcpy_22: begin
          th_memcpy <= th_memcpy_23;
        end
        th_memcpy_23: begin
          if(_maxi_write_idle && (outstanding_wcount_0 == 0)) begin
            th_memcpy <= th_memcpy_24;
          end 
        end
        th_memcpy_24: begin
          _th_memcpy_src_global_addr_27 <= _th_memcpy_src_global_addr_27 + (_th_memcpy_dma_size_30 << 2);
          th_memcpy <= th_memcpy_25;
        end
        th_memcpy_25: begin
          _th_memcpy_dst_global_addr_28 <= _th_memcpy_dst_global_addr_28 + (_th_memcpy_dma_size_30 << 2);
          th_memcpy <= th_memcpy_26;
        end
        th_memcpy_26: begin
          _th_memcpy_rest_words_26 <= _th_memcpy_rest_words_26 - _th_memcpy_dma_size_30;
          th_memcpy <= th_memcpy_27;
        end
        th_memcpy_27: begin
          th_memcpy <= th_memcpy_11;
        end
        th_memcpy_28: begin
          th_memcpy <= th_memcpy_29;
        end
        th_memcpy_29: begin
          th_memcpy <= th_memcpy_1;
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
    end else begin
      _d1__maxi_read_fsm <= _maxi_read_fsm;
      case(_d1__maxi_read_fsm)
        _maxi_read_fsm_3: begin
          if(__maxi_read_fsm_cond_3_0_1) begin
            _wvalid_12 <= 0;
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
      axim_flag_34 <= 0;
      __maxi_write_fsm_cond_4_0_1 <= 0;
    end else begin
      _d1__maxi_write_fsm <= _maxi_write_fsm;
      case(_d1__maxi_write_fsm)
        _maxi_write_fsm_4: begin
          if(__maxi_write_fsm_cond_4_0_1) begin
            axim_flag_34 <= 0;
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
          axim_flag_34 <= 1;
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

