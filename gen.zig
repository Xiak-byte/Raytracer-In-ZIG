const std = @import("std");
const def = @import("def.zig");
const ray = @import("ray.zig");
const sto = @import("std").io.getStdOut().writer();

//some important variable
var COLOR = def.P3D{ .X = 89, .Y = 79, .Z = 245 };
const COLOR_SPHERE = def.P3D{ .X = 255, .Y = 255, .Z = 0 };
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: i64 = 256;

//image properties, height, width
fn PropIMG(W: i64, ASPECT_RATIO: f32) def.IMG {
    var HEIGHT: i64 = @intFromFloat(@as(f32, W) / ASPECT_RATIO);
    var ImgPropreties = def.IMG{ .WIDTH = W, .HEIGHT = HEIGHT };
    return ImgPropreties;
}

const ImageProperties: def.IMG = PropIMG(WIDTH, AspectRatio);

//camera position and direction
pub var CAMERA = def.RAY{
    .POS = def.P3D{ .X = 0, .Y = 0, .Z = 0 },
    .DIR = def.P3D{ .X = 0, .Y = 0, .Z = 1 },
};

//sphere position, radius and color
const SPHERE_POS = def.P3D{ .X = 0, .Y = 0, .Z = 2 };
const SPHERE = def.SPR{ .COL = COLOR_SPHERE, .POS = SPHERE_POS, .RAD = 1 };

//function to print the current pixel color
fn color(Color: def.P3D) void {
    var R: usize = @intFromFloat(Color.X);
    var G: usize = @intFromFloat(Color.Y);
    var B: usize = @intFromFloat(Color.Z);
    sto.print("{d} {d} {d}\n", .{ R, G, B }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
}

//function to render the ppm file
pub fn render() void {
    //file header
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    //loop to iterate over each pixels
    var i: i64 = 0;
    var j: i64 = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            var R: def.RAY = CAMERA;
            R.DIR.X += @floatFromInt(j - (ImageProperties.WIDTH / 2));
            R.DIR.Y += @floatFromInt((ImageProperties.HEIGHT / 2) - i);
            //check for intersection
            R.DIR.Z += 1;
            if (ray.SphereIntersectionRay(SPHERE, R)) {
                color(SPHERE.COL);
            } else {
                color(COLOR);
            }
            j += 1;
            R = CAMERA;
        }
        j = 0;
        i += 1;
    }
}
