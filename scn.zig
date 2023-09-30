const std = @import("std");
const def = @import("def.zig");

var PosCam = def.P3D{ .X = 0, .Y = 1, .Z = 10 };
var VecCam = def.P3D{ .X = 0, .Y = 3, .Z = 0 };

pub var CAMERA = def.CAM{
    .POS = PosCam,
    .VEC = VecCam,
};

pub var LIGHT = def.P3D{ .X = -30, .Y = -10, .Z = 20 };

var PosSphere = def.P3D{ .X = -10, .Y = 0, .Z = 1 };
var ColSphere = def.COL{ .R = 255, .G = 255, .B = 0 };

pub var SPHERE = def.SPR{
    .RAD = 3,
    .POS = PosSphere,
    .COL = ColSphere,
};
