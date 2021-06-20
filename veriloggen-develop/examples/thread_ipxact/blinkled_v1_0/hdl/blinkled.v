

module blinkled
(
  input CLK,
  input RST,
  output reg [8-1:0] led,
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

  assign saxi_bresp = 0;
  assign saxi_rresp = 0;
  reg signed [32-1:0] _saxi_register_0;
  reg signed [32-1:0] _saxi_register_1;
  reg signed [32-1:0] _saxi_register_2;
  reg signed [32-1:0] _saxi_register_3;
  reg _saxi_flag_0;
  reg _saxi_flag_1;
  reg _saxi_flag_2;
  reg _saxi_flag_3;
  reg signed [32-1:0] _saxi_resetval_0;
  reg signed [32-1:0] _saxi_resetval_1;
  reg signed [32-1:0] _saxi_resetval_2;
  reg signed [32-1:0] _saxi_resetval_3;
  localparam _saxi_maskwidth = 2;
  localparam _saxi_mask = { _saxi_maskwidth{ 1'd1 } };
  localparam _saxi_shift = 2;
  reg [32-1:0] _saxi_register_fsm;
  localparam _saxi_register_fsm_init = 0;
  reg [32-1:0] addr_0;
  reg writevalid_1;
  reg readvalid_2;
  reg prev_awvalid_3;
  reg prev_arvalid_4;
  assign saxi_awready = (_saxi_register_fsm == 0) && (!writevalid_1 && !readvalid_2 && !saxi_bvalid && prev_awvalid_3);
  assign saxi_arready = (_saxi_register_fsm == 0) && (!readvalid_2 && !writevalid_1 && prev_arvalid_4 && !prev_awvalid_3);
  reg [_saxi_maskwidth-1:0] _tmp_5;
  wire signed [32-1:0] _tmp_6;
  assign _tmp_6 = (_tmp_5 == 0)? _saxi_register_0 : 
                  (_tmp_5 == 1)? _saxi_register_1 : 
                  (_tmp_5 == 2)? _saxi_register_2 : 
                  (_tmp_5 == 3)? _saxi_register_3 : 'hx;
  wire _tmp_7;
  assign _tmp_7 = (_tmp_5 == 0)? _saxi_flag_0 : 
                  (_tmp_5 == 1)? _saxi_flag_1 : 
                  (_tmp_5 == 2)? _saxi_flag_2 : 
                  (_tmp_5 == 3)? _saxi_flag_3 : 'hx;
  wire signed [32-1:0] _tmp_8;
  assign _tmp_8 = (_tmp_5 == 0)? _saxi_resetval_0 : 
                  (_tmp_5 == 1)? _saxi_resetval_1 : 
                  (_tmp_5 == 2)? _saxi_resetval_2 : 
                  (_tmp_5 == 3)? _saxi_resetval_3 : 'hx;
  reg _saxi_cond_0_1;
  assign saxi_wready = _saxi_register_fsm == 3;
  reg [32-1:0] th_blink;
  localparam th_blink_init = 0;
  reg signed [32-1:0] _th_blink_size_12;
  reg signed [32-1:0] _th_blink_sleep_13;
  reg signed [32-1:0] _th_blink_i_14;
  reg [32-1:0] _tmp_9;

  always @(posedge CLK) begin
    if(RST) begin
      saxi_bvalid <= 0;
      prev_awvalid_3 <= 0;
      prev_arvalid_4 <= 0;
      writevalid_1 <= 0;
      readvalid_2 <= 0;
      addr_0 <= 0;
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
      _saxi_resetval_0 <= 0;
      _saxi_resetval_1 <= 0;
      _saxi_resetval_2 <= 0;
      _saxi_resetval_3 <= 0;
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
      prev_awvalid_3 <= saxi_awvalid;
      prev_arvalid_4 <= saxi_arvalid;
      writevalid_1 <= 0;
      readvalid_2 <= 0;
      if(saxi_awready && saxi_awvalid && !saxi_bvalid) begin
        addr_0 <= saxi_awaddr;
        writevalid_1 <= 1;
      end else if(saxi_arready && saxi_arvalid) begin
        addr_0 <= saxi_araddr;
        readvalid_2 <= 1;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid)) begin
        saxi_rdata <= _tmp_6;
        saxi_rvalid <= 1;
      end 
      _saxi_cond_0_1 <= 1;
      if(saxi_rvalid && !saxi_rready) begin
        saxi_rvalid <= saxi_rvalid;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 0)) begin
        _saxi_register_0 <= _tmp_8;
        _saxi_flag_0 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 1)) begin
        _saxi_register_1 <= _tmp_8;
        _saxi_flag_1 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 2)) begin
        _saxi_register_2 <= _tmp_8;
        _saxi_flag_2 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 3)) begin
        _saxi_register_3 <= _tmp_8;
        _saxi_flag_3 <= 0;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 0)) begin
        _saxi_register_0 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 1)) begin
        _saxi_register_1 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 2)) begin
        _saxi_register_2 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 3)) begin
        _saxi_register_3 <= saxi_wdata;
      end 
      if((_saxi_register_0 == 1) && (th_blink == 2) && 1) begin
        _saxi_register_0 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_blink == 2) && 0) begin
        _saxi_register_1 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_blink == 2) && 0) begin
        _saxi_register_2 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_blink == 2) && 0) begin
        _saxi_register_3 <= 0;
      end 
      if((th_blink == 3) && 0) begin
        _saxi_register_0 <= 0;
        _saxi_flag_0 <= 0;
      end 
      if((th_blink == 3) && 0) begin
        _saxi_register_1 <= 0;
        _saxi_flag_1 <= 0;
      end 
      if((th_blink == 3) && 0) begin
        _saxi_register_2 <= 0;
        _saxi_flag_2 <= 0;
      end 
      if((th_blink == 3) && 1) begin
        _saxi_register_3 <= 0;
        _saxi_flag_3 <= 0;
      end 
      if((th_blink == 11) && 0) begin
        _saxi_register_0 <= 1;
        _saxi_flag_0 <= 1;
        _saxi_resetval_0 <= 0;
      end 
      if((th_blink == 11) && 0) begin
        _saxi_register_1 <= 1;
        _saxi_flag_1 <= 1;
        _saxi_resetval_1 <= 0;
      end 
      if((th_blink == 11) && 0) begin
        _saxi_register_2 <= 1;
        _saxi_flag_2 <= 1;
        _saxi_resetval_2 <= 0;
      end 
      if((th_blink == 11) && 1) begin
        _saxi_register_3 <= 1;
        _saxi_flag_3 <= 1;
        _saxi_resetval_3 <= 0;
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
          if(readvalid_2 || writevalid_1) begin
            _tmp_5 <= (addr_0 >> _saxi_shift) & _saxi_mask;
          end 
          if(readvalid_2) begin
            _saxi_register_fsm <= _saxi_register_fsm_1;
          end 
          if(writevalid_1) begin
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

  localparam th_blink_1 = 1;
  localparam th_blink_2 = 2;
  localparam th_blink_3 = 3;
  localparam th_blink_4 = 4;
  localparam th_blink_5 = 5;
  localparam th_blink_6 = 6;
  localparam th_blink_7 = 7;
  localparam th_blink_8 = 8;
  localparam th_blink_9 = 9;
  localparam th_blink_10 = 10;
  localparam th_blink_11 = 11;
  localparam th_blink_12 = 12;
  localparam th_blink_13 = 13;

  always @(posedge CLK) begin
    if(RST) begin
      th_blink <= th_blink_init;
      _th_blink_size_12 <= 0;
      _th_blink_sleep_13 <= 0;
      _th_blink_i_14 <= 0;
      _tmp_9 <= 0;
      led <= 0;
    end else begin
      case(th_blink)
        th_blink_init: begin
          _th_blink_size_12 <= 16;
          th_blink <= th_blink_1;
        end
        th_blink_1: begin
          if(1) begin
            th_blink <= th_blink_2;
          end else begin
            th_blink <= th_blink_13;
          end
        end
        th_blink_2: begin
          if(_saxi_register_0 == 1) begin
            th_blink <= th_blink_3;
          end 
        end
        th_blink_3: begin
          th_blink <= th_blink_4;
        end
        th_blink_4: begin
          _th_blink_sleep_13 <= _saxi_register_1;
          th_blink <= th_blink_5;
        end
        th_blink_5: begin
          _th_blink_size_12 <= _saxi_register_2;
          th_blink <= th_blink_6;
        end
        th_blink_6: begin
          _th_blink_i_14 <= 0;
          th_blink <= th_blink_7;
        end
        th_blink_7: begin
          if(_th_blink_i_14 < _th_blink_size_12) begin
            th_blink <= th_blink_8;
          end else begin
            th_blink <= th_blink_11;
          end
        end
        th_blink_8: begin
          if(_tmp_9 < _th_blink_sleep_13) begin
            _tmp_9 <= _tmp_9 + 1;
          end 
          if(_tmp_9 >= _th_blink_sleep_13) begin
            _tmp_9 <= 0;
          end 
          if(_tmp_9 >= _th_blink_sleep_13) begin
            th_blink <= th_blink_9;
          end 
        end
        th_blink_9: begin
          led <= led + 1;
          th_blink <= th_blink_10;
        end
        th_blink_10: begin
          _th_blink_i_14 <= _th_blink_i_14 + 1;
          th_blink <= th_blink_7;
        end
        th_blink_11: begin
          th_blink <= th_blink_12;
        end
        th_blink_12: begin
          th_blink <= th_blink_1;
        end
      endcase
    end
  end


endmodule

