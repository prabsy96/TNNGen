

module add
(
  input CLK,
  input RST,
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
                  (_tmp_5 == 3)? _saxi_register_3 : 
                  (_tmp_5 == 4)? _saxi_register_4 : 
                  (_tmp_5 == 5)? _saxi_register_5 : 
                  (_tmp_5 == 6)? _saxi_register_6 : 
                  (_tmp_5 == 7)? _saxi_register_7 : 'hx;
  wire _tmp_7;
  assign _tmp_7 = (_tmp_5 == 0)? _saxi_flag_0 : 
                  (_tmp_5 == 1)? _saxi_flag_1 : 
                  (_tmp_5 == 2)? _saxi_flag_2 : 
                  (_tmp_5 == 3)? _saxi_flag_3 : 
                  (_tmp_5 == 4)? _saxi_flag_4 : 
                  (_tmp_5 == 5)? _saxi_flag_5 : 
                  (_tmp_5 == 6)? _saxi_flag_6 : 
                  (_tmp_5 == 7)? _saxi_flag_7 : 'hx;
  wire signed [32-1:0] _tmp_8;
  assign _tmp_8 = (_tmp_5 == 0)? _saxi_resetval_0 : 
                  (_tmp_5 == 1)? _saxi_resetval_1 : 
                  (_tmp_5 == 2)? _saxi_resetval_2 : 
                  (_tmp_5 == 3)? _saxi_resetval_3 : 
                  (_tmp_5 == 4)? _saxi_resetval_4 : 
                  (_tmp_5 == 5)? _saxi_resetval_5 : 
                  (_tmp_5 == 6)? _saxi_resetval_6 : 
                  (_tmp_5 == 7)? _saxi_resetval_7 : 'hx;
  reg _saxi_cond_0_1;
  assign saxi_wready = _saxi_register_fsm == 3;
  reg [32-1:0] th_add;
  localparam th_add_init = 0;
  reg signed [32-1:0] _th_add_a_13;
  reg signed [32-1:0] _th_add_b_14;
  reg signed [32-1:0] _th_add_c_15;

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
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 4)) begin
        _saxi_register_4 <= _tmp_8;
        _saxi_flag_4 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 5)) begin
        _saxi_register_5 <= _tmp_8;
        _saxi_flag_5 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 6)) begin
        _saxi_register_6 <= _tmp_8;
        _saxi_flag_6 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && _tmp_7 && (_tmp_5 == 7)) begin
        _saxi_register_7 <= _tmp_8;
        _saxi_flag_7 <= 0;
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
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 4)) begin
        _saxi_register_4 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 5)) begin
        _saxi_register_5 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 6)) begin
        _saxi_register_6 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 3) && (saxi_wready && saxi_wvalid) && (_tmp_5 == 7)) begin
        _saxi_register_7 <= saxi_wdata;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 1) begin
        _saxi_register_0 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_1 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_2 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_3 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_4 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_5 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_6 <= 0;
      end 
      if((_saxi_register_0 == 1) && (th_add == 2) && 0) begin
        _saxi_register_7 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_0 <= _th_add_c_15;
        _saxi_flag_0 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_1 <= _th_add_c_15;
        _saxi_flag_1 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_2 <= _th_add_c_15;
        _saxi_flag_2 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_3 <= _th_add_c_15;
        _saxi_flag_3 <= 0;
      end 
      if((th_add == 6) && 1) begin
        _saxi_register_4 <= _th_add_c_15;
        _saxi_flag_4 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_5 <= _th_add_c_15;
        _saxi_flag_5 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_6 <= _th_add_c_15;
        _saxi_flag_6 <= 0;
      end 
      if((th_add == 6) && 0) begin
        _saxi_register_7 <= _th_add_c_15;
        _saxi_flag_7 <= 0;
      end 
      if((th_add == 7) && 0) begin
        _saxi_register_0 <= 1;
        _saxi_flag_0 <= 1;
        _saxi_resetval_0 <= 0;
      end 
      if((th_add == 7) && 1) begin
        _saxi_register_1 <= 1;
        _saxi_flag_1 <= 1;
        _saxi_resetval_1 <= 0;
      end 
      if((th_add == 7) && 0) begin
        _saxi_register_2 <= 1;
        _saxi_flag_2 <= 1;
        _saxi_resetval_2 <= 0;
      end 
      if((th_add == 7) && 0) begin
        _saxi_register_3 <= 1;
        _saxi_flag_3 <= 1;
        _saxi_resetval_3 <= 0;
      end 
      if((th_add == 7) && 0) begin
        _saxi_register_4 <= 1;
        _saxi_flag_4 <= 1;
        _saxi_resetval_4 <= 0;
      end 
      if((th_add == 7) && 0) begin
        _saxi_register_5 <= 1;
        _saxi_flag_5 <= 1;
        _saxi_resetval_5 <= 0;
      end 
      if((th_add == 7) && 0) begin
        _saxi_register_6 <= 1;
        _saxi_flag_6 <= 1;
        _saxi_resetval_6 <= 0;
      end 
      if((th_add == 7) && 0) begin
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

  localparam th_add_1 = 1;
  localparam th_add_2 = 2;
  localparam th_add_3 = 3;
  localparam th_add_4 = 4;
  localparam th_add_5 = 5;
  localparam th_add_6 = 6;
  localparam th_add_7 = 7;
  localparam th_add_8 = 8;
  localparam th_add_9 = 9;

  always @(posedge CLK) begin
    if(RST) begin
      th_add <= th_add_init;
      _th_add_a_13 <= 0;
      _th_add_b_14 <= 0;
      _th_add_c_15 <= 0;
    end else begin
      case(th_add)
        th_add_init: begin
          th_add <= th_add_1;
        end
        th_add_1: begin
          if(1) begin
            th_add <= th_add_2;
          end else begin
            th_add <= th_add_9;
          end
        end
        th_add_2: begin
          if(_saxi_register_0 == 1) begin
            th_add <= th_add_3;
          end 
        end
        th_add_3: begin
          _th_add_a_13 <= _saxi_register_2;
          th_add <= th_add_4;
        end
        th_add_4: begin
          _th_add_b_14 <= _saxi_register_3;
          th_add <= th_add_5;
        end
        th_add_5: begin
          _th_add_c_15 <= _th_add_a_13 + _th_add_b_14;
          th_add <= th_add_6;
        end
        th_add_6: begin
          th_add <= th_add_7;
        end
        th_add_7: begin
          th_add <= th_add_8;
        end
        th_add_8: begin
          th_add <= th_add_1;
        end
      endcase
    end
  end


endmodule

