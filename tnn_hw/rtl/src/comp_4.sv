module comp4 (
    input [7:0] dist_in1,
    input [7:0] dist_in2,
    output [7:0] dist_out 
);

bit replace;

if (dist_in1>dist_in2)
    replace = 1;
else
    replace = 0;

assign dist_out = replace? dist_in1:dist_in2;
endmodule

