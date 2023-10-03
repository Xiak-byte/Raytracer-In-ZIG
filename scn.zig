const std = @import("std");
const def = @import("def.zig");
const gen = @import("gen.zig");
const pop = @import("pop.zig");

pub var CAMERA = gen.CAMERA;
pub var LIGHT = def.P3D{ .X = -30, .Y = -10, .Z = 20 };
pub var SPHERE = def.SPR{
    .RAD = 2,
    .POS = def.P3D{ .X = 0, .Y = 10, .Z = 5 },
    .COL = def.P3D{ .X = 255, .Y = 255, .Z = 0 },
};

pub fn IntersectSphere(ray: def.RAY, sphere: def.SPR) bool {
    const oc: def.P3D = pop.Sub(ray.POS, sphere.POS);
    var a: f32 = pop.Dot(ray.DIR, ray.DIR);
    var b: f32 = 2.0 * pop.Dot(oc, ray.DIR);
    var c: f32 = pop.Dot(oc, oc) - sphere.RAD * sphere.RAD;
    const discriminant = b * b - 4 * a * c;

    if (discriminant > 0) {
        return true;
    } else {
        return false;
    }
}
