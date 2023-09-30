const std = @import("std");
const sto = @import("std").io.getStdOut().writer();
const gen = @import("gen.zig");
const def = @import("def.zig");

fn nothreadcolor(COLOR: def.COL) void {
    sto.print("{d} {d} {d}\n", .{ COLOR.R, COLOR.G, COLOR.B }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
}

pub var IMAGE_PIXEL: [gen.ImageProperties.WIDTH * gen.ImageProperties.HEIGHT]def.COL = undefined;
const PIXEL = struct {
    var INDEX: usize = 0;
};

pub fn color(COLOR: def.COL) void {
    var PIXEL_INDEX = PIXEL.INDEX;
    IMAGE_PIXEL[PIXEL.INDEX] = COLOR;
    PIXEL_INDEX += 1;
}
