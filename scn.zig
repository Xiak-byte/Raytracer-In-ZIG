const std = @import("std");
const def = @import("def.zig");
const gen = @import("gen.zig");
const pop = @import("pop.zig");

pub var CAMERA = gen.CAMERA;
pub var LIGHT = def.P3D{ .X = -30, .Y = -10, .Z = 20 };
pub var SPHERE = def.SPR{
    .RAD = 0.3,
    .POS = def.P3D{ .X = 0.7, .Y = 0.7, .Z = 10 },
    .COL = def.P3D{ .X = 255, .Y = 255, .Z = 0 },
};

pub fn IntersectSphere(ray: def.RAY, sphere: def.SPR) bool {
    const sphereToRay = pop.Sub(ray.POS, sphere.POS);
    const a = pop.Dot(ray.DIR, ray.DIR);
    const b = 2.0 * pop.Dot(sphereToRay, ray.DIR);
    const c = pop.Dot(sphereToRay, sphereToRay) - sphere.RAD * sphere.RAD;
    const discriminant = b * b - 4 * a * c;

    if (discriminant > 0) {
        return true;
    } else {
        return false;
    }
}
