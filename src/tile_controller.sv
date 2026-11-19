module tile_controller (
    input  logic [10:0] pixel_row,
    input  logic [10:0] pixel_col,

    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

    localparam int SCREEN_W = 800;    // screen width
    localparam int SCREEN_H = 600;    // screen height

    localparam int COL1_END = 266;    // first column boundary
    localparam int COL2_END = 533;    // second column boundary

    localparam int TILE_H = 100;      // tile height
    localparam int TILE_MARGIN = 14;  // spacing from column edges

    localparam int HIT_ZONE_Y = 500;  // start of hit zone

    logic [10:0] tile_y = 11'd120;   // current tile position

    logic tile_on;
    logic divider_on;

    //------------------------------------------------------------------
    // process to draw tile
    // set tile_on if current pixel is within the tile boundaries
    //------------------------------------------------------------------
    always_comb begin : tiledraw

        tile_on = ((pixel_col >= TILE_MARGIN) &&
                   (pixel_col < COL1_END - TILE_MARGIN) &&
                   (pixel_row >= tile_y) &&
                   (pixel_row < tile_y + TILE_H));

    end

    //------------------------------------------------------------------
    // process to draw column dividers
    //------------------------------------------------------------------
    always_comb begin : dividerdraw

        divider_on = (((pixel_col >= COL1_END - 2) &&
                       (pixel_col < COL1_END + 2)) ||
                      ((pixel_col >= COL2_END - 2) &&
                       (pixel_col < COL2_END + 2)));

    end

    //------------------------------------------------------------------
    // color setup for tiles, dividers and background
    //------------------------------------------------------------------
    always_comb begin : colors

        // white background
        red   = 4'hF;
        green = 4'hF;
        blue  = 4'hF;


        // gray column dividers
        if (divider_on) begin
            red   = 4'h8;
            green = 4'h8;
            blue  = 4'h8;
        end

        // black tile
        if (tile_on) begin
            red   = 4'h0;
            green = 4'h0;
            blue  = 4'h0;
        end

    end

endmodule
