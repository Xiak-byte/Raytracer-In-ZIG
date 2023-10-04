const std = @import("std");
const def = @import("def.zig");
const img = @import("img.zig");
const col = @import("col.zig");
const pop = @import("pop.zig");
const ray = @import("ray.zig");
const sto = @import("std").io.getStdOut().writer();
const thr = @import("std").Thread;
const alloc = @import("std").heap.page_allocator;

const COLOR = def.P3D{ .X = 123, .Y = 89, .Z = 224 };
const COLOR_SPHERE = def.P3D{ .X = 255, .Y = 255, .Z = 0 };
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: u32 = 256;
pub const ImageProperties: def.IMG = img.PropIMG(WIDTH, AspectRatio);
pub var CAMERA = def.RAY{
    .POS = def.P3D{ .X = 0, .Y = 10, .Z = 0 },
    .DIR = def.P3D{ .X = -@as(f64, WIDTH) / 2.0, .Y = @as(f64, ImageProperties.HEIGHT) / 2.0, .Z = 0 },
};
const SPHERE_POS = def.P3D{ .X = 0, .Y = 10, .Z = 2 };
const SPHERE = def.SPR{ .COL = COLOR_SPHERE, .POS = SPHERE_POS, .RAD = 2 };

pub fn render() void {
    //file head
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    var i: u32 = 0;
    var j: u32 = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            var R: def.RAY = CAMERA;
            R.DIR.X += @floatFromInt(j);
            R.DIR.Y += @floatFromInt(i);
            if (ray.SphereIntersectionRay(SPHERE, R)) {
                col.color(COLOR_SPHERE);
            } else {
                col.color(COLOR);
            }
            j += 1;
        }
        j = 0;
        i += 1;
    }
}
