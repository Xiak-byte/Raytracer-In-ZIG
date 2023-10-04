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

pub fn SphereIntersectionRay(sphere: def.SPR, R: def.RAY) bool {
    const a: f32 = pop.Dot(R.DIR, R.DIR);
    const v: def.P3D = pop.Sub(sphere.POS, R.POS);
    const b: f32 = 2.0 * pop.Dot(v, R.DIR);
    const c: f32 = pop.Dot(v, v) - sphere.RAD * sphere.RAD;

    const discriminant: f32 = b * b - 4.0 * a * c;
    if (discriminant > 0) {
        std.debug.print("Intersection\n", .{});
        return true;
    } else {
        return false;
    }
}
