const std = @import("std");
const sto = @import("std").io.getStdOut().writer();
const gen = @import("gen.zig");
const def = @import("def.zig");

pub fn color(COLOR: def.P3D) void {
    sto.print("{d} {d} {d}\n", .{ COLOR.X, COLOR.Y, COLOR.Z }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
}
