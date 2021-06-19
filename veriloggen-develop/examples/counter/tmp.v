

module blinkled
(
  input CLK,
  input RST,
  output [8-1:0] LED
);

  reg [11-1:0] _tmp_0;

  always @(posedge CLK) begin
    if(RST) begin
      _tmp_0 <= 0;
    end else begin
      if(_tmp_0 == 1023) begin
        _tmp_0 <= 0;
      end else begin
        _tmp_0 <= _tmp_0 + 1;
      end
    end
  end

  reg [8-1:0] _tmp_1;

  always @(posedge CLK) begin
    if(RST) begin
      _tmp_1 <= 0;
    end else begin
      if(_tmp_0 == 1023) begin
        if(_tmp_1 == 2 ** 8 - 1) begin
          _tmp_1 <= 0;
        end else begin
          _tmp_1 <= _tmp_1 + 1;
        end
      end 
    end
  end

  assign LED = _tmp_1;

endmodule

