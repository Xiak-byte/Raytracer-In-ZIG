const std = @import("std");
const def = @import("def.zig");
const pop = @import("pop.zig");

pub fn SphereIntersectionRay(sphere: def.SPR, R: def.RAY) f32 {
    const a: f32 = pop.Dot(R.DIR, R.DIR);
    const v: def.P3D = pop.Sub(R.POS, sphere.POS);
    const b: f32 = 2.0 * pop.Dot(v, R.DIR);
    const c: f32 = pop.Dot(v, v) - sphere.RAD * sphere.RAD;

    const discriminant: f32 = b * b - 4.0 * a * c;
    if (discriminant < 0) {
        return -1.0;
    } else {
        return (-b - std.math.sqrt(discriminant)) / (2.0 * a);
    }
}

pub fn Shadow(R: def.RAY, sphere: def.SPR) bool {
    if (SphereIntersectionRay(sphere, R) >= 0) {
        return true;
    }
    return false;
}
