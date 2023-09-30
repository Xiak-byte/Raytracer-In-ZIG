const std = @import("std");
const gen = @import("gen.zig");
const pop = @import("pop.zig");
const def = @import("def.zig");

pub fn main() !void {
    gen.render();
}
