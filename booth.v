module booth(out, in1, in2);

parameter width = 6;

input   [width-1:0] in1;   //multiplicand
input   [width-1:0] in2;   //multiplier
output reg [2*width-1:0] out; //product

reg [width-1:0] accumulator;
reg [width:0] multiplier_reg;
reg q_res;
integer i;
always @(in1, in2) begin
    accumulator = 0;
    multiplier_reg = in2;
    q_res = 0;

    for(i=0; i<width; i=i+1) begin
    case ({multiplier_reg[0], q_res})
        2'b01:  accumulator = (accumulator + in1);
        2'b10:  accumulator = (accumulator - in1);
        default: ; // No operation
    endcase

    // 邏輯右移一位元
    {accumulator, multiplier_reg, q_res} = ($signed({accumulator, multiplier_reg, q_res}) >>> 1);   
    end
    {accumulator, multiplier_reg, q_res} = ($signed({accumulator, multiplier_reg, q_res}) >>> 1);
    out = {accumulator, multiplier_reg};
end

endmodule
