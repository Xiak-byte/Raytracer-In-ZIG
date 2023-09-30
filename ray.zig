const std = @import("std");
const def = @import("def.zig");
const scn = @import("scn.zig");
const pop = @import("pop.zig");

var EYE: def.P3D = pop.Sub(scn.CAMERA.VEC, scn.CAMERA.POS);
