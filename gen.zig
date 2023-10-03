const std = @import("std");
const gen = @import("gen.zig");
const def = @import("def.zig");
const col = @import("col.zig");
const scn = @import("scn.zig");
const img = @import("img.zig");
const pop = @import("pop.zig");
const sto = @import("std").io.getStdOut().writer();
const thr = @import("std").Thread;
const alloc = @import("std").heap.page_allocator;

const COLOR = def.P3D{ .X = 123, .Y = 89, .Z = 224 };
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: u32 = 900;
pub const ImageProperties: def.IMG = img.PropIMG(WIDTH, AspectRatio);
pub var CAMERA = def.RAY{
    .POS = def.P3D{ .X = 0, .Y = 10, .Z = 0 },
    .DIR = def.P3D{ .X = -@as(f64, WIDTH) / 2.0, .Y = @as(f64, ImageProperties.HEIGHT) / 2.0, .Z = 100 },
};
const FOV: f32 = 120;
const FOV_RAD: f32 = FOV * (std.math.pi / 180.0);
const STEP: f32 = 2.0 * std.math.tan(FOV_RAD / 2.0) / @as(f32, ImageProperties.WIDTH);
const PIXEL_GRID_W = def.P3D{ .X = STEP, .Y = 0, .Z = 0 };
const PIXEL_GRID_H = def.P3D{ .X = 0, .Y = STEP, .Z = 0 };

pub fn render() void {
    //file head
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    var i: usize = 0;
    var j: usize = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            if (scn.IntersectSphere(CAMERA, scn.SPHERE)) {
                col.color(scn.SPHERE.COL);
            } else {
                col.color(COLOR);
            }
            CAMERA.DIR = pop.Add(CAMERA.DIR, PIXEL_GRID_W);
            j += 1;
        }

        CAMERA.DIR = def.P3D{ .X = -@as(f64, WIDTH) / 2.0, .Y = @as(f64, ImageProperties.HEIGHT) / 2.0, .Z = 100 };
        CAMERA.DIR = pop.Sub(CAMERA.DIR, PIXEL_GRID_H);
        j = 0;
        i += 1;
    }
}
