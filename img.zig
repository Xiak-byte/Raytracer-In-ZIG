const std = @import("std");
const def = @import("def.zig");

pub fn PropIMG(WIDTH: u32, AspectRatio: f32) def.IMG {
    var HEIGHT: u32 = @intFromFloat(@as(f32, WIDTH) / AspectRatio);
    var ImgPropreties = def.IMG{ .WIDTH = WIDTH, .HEIGHT = HEIGHT };
    return ImgPropreties;
}
