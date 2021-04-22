const std = @import("std");
const mem = std.mem;
const meta = std.meta;
const os = std.os;

const url = "https://somafm.com/{s}{s}.pls";

const SomaFm = enum {
    groovesalad,
    dronezone,
    indiepop,
    deepspaceone,
    spacestation,
    lush,
    gsclassic,
    u80s,
    seventies,
    secrentagent,
    folkfwd,
    poptron,
    beatblender,
    bootliquor,
    thetrip,
    defcon,
    suburbsofgoa,
    bagel,
    synphaera,
    sonicuniverse,
    fluid,
    soul,
    thistle,
    illstreet,
    reggae,
    dubstep,
    missioncontroll,
    cliqhop,
    digitali,
    metal,
    vaporwaves,
    covers,
    brfm,
    n5md,
    sf1033,
    live,
    specials,
    scanner,
};

const Quality = enum {
    @"128",
    @"64",
    @"32",

    pub fn format(q: Quality, comptime fmt: []const u8, options: std.fmt.FormatOptions, out: anytype) !void {
        switch (q) {
            .@"128" => try out.writeAll("130"),
            else => try out.writeAll(@tagName(q)),
        }
    }
};

const Radio = enum {
    lainchan,
    somafm,
};

pub fn main() !u8 {
    var instance = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = instance.deinit();

    const gpa = &instance.allocator;

    const radio = blk: {
        const name = mem.spanZ(os.argv[1]);

        if (mem.eql(u8, name, "list")) {
            inline for (meta.fields(Radio)) |field| std.log.info("{s}", .{field.name});
            return 0;
        }

        break :blk meta.stringToEnum(Radio, name) orelse {
            std.log.err("invalid radio name {s}", .{name});
            return 1;
        };
    };

    const channel = blk: {
        const name = mem.spanZ(os.argv[2]);

        if (mem.eql(u8, name, "list")) {
            inline for (meta.fields(SomaFm)) |field| std.log.info("{s}", .{field.name});
            return 0;
        }

        break :blk meta.stringToEnum(SomaFm, name) orelse {
            std.log.err("invalid channel name {s}", .{name});
            return 1;
        };
    };

    const quality: Quality = if (os.argv.len == 3) .@"64" else blk: {
        const name = mem.spanZ(os.argv[3]);
        break :blk meta.stringToEnum(Quality, name) orelse {
            std.log.err("invalid quality {s}", .{name});
            return 1;
        };
    };

    const link = try std.fmt.allocPrint(gpa, url, .{ @tagName(channel), quality });
    defer gpa.free(link);

    std.log.info("playing {s} at {s}k", .{ @tagName(channel), @tagName(quality) });
    const child = try std.ChildProcess.init(&.{ "mpv", link }, gpa);
    defer child.deinit();

    const term = try child.spawnAndWait();

    switch (term) {
        .Exited => |code| if (code != 0) return @truncate(u8, code),
        else => return 1,
    }

    return 0;
}
