`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 05:25:31 PM
// Design Name: 
// Module Name: wallace
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Wallace Tree Multiplier
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module FA (
    input [63:0] x,
    input [63:0] y,
    input [63:0] z,
    output [63:0] u,
    output [63:0] v
);

    assign u = x ^ y ^ z;
    assign v[0] = 0;
    assign v[63:1] = (x & y) | (y & z) | (z & x);

endmodule

module cla(s, cout, a, b, cin);
    parameter n = 32;
    input [n-1:0] a, b;
    input cin;
    output [n-1:0] s;
    output cout;
    wire [n-1:0] g;
    wire [n-1:0] p;
    wire [n:0] c;

    assign g = a & b;
    assign p = a ^ b;

    assign c[0] = cin;
    genvar i;
    generate
    for (i = 0; i < n; i = i + 1) begin
        assign c[i + 1] = g[i] | (p[i] & c[i]);
    end
    endgenerate
    assign s = p ^ c[n-1:0];
    assign cout = c[n];

endmodule

module wallace (
    input [31:0] a,
    input [31:0] b,
    output [63:0] out
);

    reg [63:0] p_prods [31:0];
    integer i;

    // Generate partial products
    always @(a or b) begin
        for (i = 0; i < 32; i = i + 1) begin
            if (b[i] == 1) begin
                p_prods[i] <= a << i;
            end else begin
                p_prods[i] <= 64'h00000000;
            end
        end
    end

    // The following is for level 1 of wallace tree
    wire [63:0] u_l11, v_l11, u_l12, v_l12, u_l13, v_l13, u_l14, v_l14, u_l15, v_l15, u_l16, v_l16, u_l17, v_l17, u_l18, v_l18, u_l19, v_l19, u_l110, v_l110;

    FA l11 (p_prods[0], p_prods[1], p_prods[2], u_l11, v_l11);
    FA l12 (p_prods[3], p_prods[4], p_prods[5], u_l12, v_l12);
    FA l13 (p_prods[6], p_prods[7], p_prods[8], u_l13, v_l13);
    FA l14 (p_prods[9], p_prods[10], p_prods[11], u_l14, v_l14);
    FA l15 (p_prods[12], p_prods[13], p_prods[14], u_l15, v_l15);
    FA l16 (p_prods[15], p_prods[16], p_prods[17], u_l16, v_l16);
    FA l17 (p_prods[18], p_prods[19], p_prods[20], u_l17, v_l17);
    FA l18 (p_prods[21], p_prods[22], p_prods[23], u_l18, v_l18);
    FA l19 (p_prods[24], p_prods[25], p_prods[26], u_l19, v_l19);
    FA l110 (p_prods[27], p_prods[28], p_prods[29], u_l110, v_l110);
    
    // The following is for level 2 of wallace tree
    wire [63:0] u_l21, v_l21, u_l22, v_l22, u_l23, v_l23, u_l24, v_l24, u_l25, v_l25, u_l26, v_l26, u_l27, v_l27;

    FA l21 (u_l11, v_l11, u_l12, u_l21, v_l21);
    FA l22 (v_l12, u_l13, v_l13, u_l22, v_l22);
    FA l23 (u_l14, v_l14, u_l15, u_l23, v_l23);
    FA l24 (v_l15, u_l16, v_l16, u_l24, v_l24);
    FA l25 (u_l17, v_l17, u_l18, u_l25, v_l25);
    FA l26 (v_l18, u_l19, v_l19, u_l26, v_l26);
    FA l27 (u_l110, v_l110, p_prods[30], u_l27, v_l27);
    
    // The following is for level 3 of wallace tree
    wire [63:0] u_l31, v_l31, u_l32, v_l32, u_l33, v_l33, u_l34, v_l34, u_l35, v_l35;

    FA l31 (u_l21, v_l21, u_l22, u_l31, v_l31);
    FA l32 (v_l22, u_l23, v_l23, u_l32, v_l32);
    FA l33 (u_l24, v_l24, u_l25, u_l33, v_l33);
    FA l34 (v_l25, u_l26, v_l26, u_l34, v_l34);
    FA l35 (u_l27, v_l27, p_prods[31], u_l35, v_l35);

    // The following is for level 4 of wallace tree
    wire [63:0] u_l41, v_l41, u_l42, v_l42, u_l43, v_l43;

    FA l41 (u_l31, v_l31, u_l32, u_l41, v_l41);
    FA l42 (v_l32, u_l33, v_l33, u_l42, v_l42);
    FA l43 (u_l34, v_l34, u_l35, u_l43, v_l43);
    
    // The following is for level 5 of wallace tree
    wire [63:0] u_l51, v_l51, u_l52, v_l52;

    FA l51 (u_l41, v_l41, u_l42, u_l51, v_l51);
    FA l52 (v_l42, u_l43, v_l43, u_l52, v_l52);

    // The following is for level 6 of wallace tree
    wire [63:0] u_l61, v_l61;

    FA l61 (u_l51, v_l51, u_l52, u_l61, v_l61);
    
    // The following is for level 7 of wallace tree
    wire [63:0] u_l71, v_l71;

    FA l71 (u_l61, v_l61, v_l52, u_l71, v_l71);

    // The following is for level 8 of wallace tree
    wire [63:0] u_l81, v_l81;

    FA l81 (u_l71, v_l71, v_l35, u_l81, v_l81);

    // The following is for level 9 of wallace tree
    wire c1,c;
    cla l91 (out[31:0], c1, u_l81[31:0], v_l81[31:0], 1'b0);
    cla l92 (out[63:32], c, u_l81[63:32], v_l81[63:32], c1);

endmodule

