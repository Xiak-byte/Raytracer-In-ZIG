const std = @import("std");
const def = @import("def.zig");
const pop = @import("pop.zig");

pub fn SphereIntersectionRay(sphere: def.SPR, R: def.RAY) bool {
    const a: f32 = pop.Dot(R.DIR, R.DIR);
    const v: def.P3D = pop.Sub(sphere.POS, R.POS);
    const b: f32 = 2.0 * pop.Dot(v, R.DIR);
    const c: f32 = pop.Dot(v, v) - sphere.RAD * sphere.RAD;

    const discriminant: f32 = b * b - 4.0 * a * c;
    if (discriminant > 0) {
        return true;
    } else {
        return false;
    }
}
