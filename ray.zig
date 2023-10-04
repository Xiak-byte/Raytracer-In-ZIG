const std = @import("std");
const def = @import("def.zig");
const pop = @import("pop.zig");

pub fn SphereRayIntersection(sphere: def.SPR, R: def.RAY) bool {
    var v: def.P3D = pop.Sub(sphere.POS, R.POS);
    var b: f32 = pop.Dot(R.DIR, v);
    var discriminant: f32 = b * b - pop.Dot(v, v) + sphere.RAD * sphere.RAD;
    if (discriminant > 0) {
        return true;
    } else {
        return false;
    }
}
