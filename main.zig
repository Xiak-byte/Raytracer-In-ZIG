const std = @import("std");
const gen = @import("gen.zig");

pub fn main() !void {
    gen.render();
}
