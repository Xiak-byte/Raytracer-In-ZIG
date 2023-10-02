const std = @import("std");
const def = @import("def.zig");
const gen = @import("gen.zig");

pub var CAMERA = gen.CAMERA;
pub var LIGHT = def.P3D{ .X = -30, .Y = -10, .Z = 20 };

var PosSphere = def.P3D{ .X = -10, .Y = 0, .Z = 1 };
var ColSphere = def.COL{ .R = 255, .G = 255, .B = 0 };

pub var SPHERE = def.SPR{
    .RAD = 3,
    .POS = PosSphere,
    .COL = ColSphere,
};
