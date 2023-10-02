const std = @import("std");
const sto = @import("std").io.getStdOut().writer();
const gen = @import("gen.zig");
const def = @import("def.zig");

pub fn color(COLOR: def.P3D) void {
    var R: usize = @intFromFloat(COLOR.X);
    var G: usize = @intFromFloat(COLOR.Y);
    var B: usize = @intFromFloat(COLOR.Z);
    sto.print("{d} {d} {d}\n", .{ R, G, B }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
}
