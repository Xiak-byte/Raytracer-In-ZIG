const std = @import("std");
const gen = @import("gen.zig");
const def = @import("def.zig");
const col = @import("col.zig");
const img = @import("img.zig");
const sto = @import("std").io.getStdOut().writer();
const thr = @import("std").Thread;
const alloc = @import("std").heap.page_allocator;

const MAX_CORE: usize = 128;
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: u32 = 900;
pub const ImageProperties: def.IMG = img.PropIMG(WIDTH, AspectRatio);

fn usedThread() usize {
    const UsedCoreErr = thr.getCpuCount();
    var UsedCore = UsedCoreErr catch |err| {
        std.debug.print("ERROR IN GETTING CPU COUNT => {}\n", .{err});
        return 1;
    };
    return UsedCore;
}

fn thread(COLOR: def.COL) void {
    var UsedCore: usize = usedThread();
    const SpawnConfig = thr.SpawnConfig{
        .stack_size = 4096,
    };
    var ThreadArray: [MAX_CORE]thr = undefined;
    var i: usize = 0;
    while (i < UsedCore) {
        var ThreadArrayERR = thr.spawn(SpawnConfig, col.color, .{COLOR});
        ThreadArray[i] = ThreadArrayERR catch |err| {
            std.debug.print("EROOR THREAD ARRAY DECLARATION => {}\n", .{err});
            return;
        };
        i += 1;
    }
    for (ThreadArray) |joinThread| {
        if (@TypeOf(joinThread) == @TypeOf(thr)) {
            defer thr.join(joinThread);
        }
    }
}

pub fn render() void {
    const COLOR = def.COL{ .R = 123, .G = 89, .B = 224 };
    const UsedCore = usedThread();
    //file head
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    var i: usize = 0;
    var j: usize = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            thread(COLOR);
            j += UsedCore;
        }
        j = 0;
        i += 1;
    }
    for (col.IMAGE_PIXEL) |value| {
        sto.print("{} {} {}\n", .{ value.R, value.G, value.B }) catch |err| {
            std.debug.print("IMAGE PIXEL ARRAY PRINT ERROR => {}\n", .{err});
        };
    }
}
