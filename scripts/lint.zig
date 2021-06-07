const std = @import("std");

const mem = std.mem;
const math = std.math;
const fs = std.fs;

var stats = std.ArrayListUnmanaged(Stats){};
var seen = std.AutoArrayHashMapUnmanaged(fs.File.INode, void){};

const Stats = struct {
    path: []const u8,
    functions: u32,
    asserts: u32,
};

var allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = &allocator.allocator;

pub fn main() !void {
    const argv = std.os.argv;
    for (argv[1..]) |raw| {
        const path = mem.span(raw);
        lint(path, fs.cwd(), path) catch |e| switch (e) {
            error.IsDir, error.AccessDenied => try lintDir(path, fs.cwd(), path),
            else => return e,
        };
    }

    for (stats.items) |item| {
        std.log.info("{s} consists of {d} functions and {d} assertions", .{
            item.path,
            item.functions,
            item.asserts,
        });
    }
}

const LintError = error{
    OutOfMemory,
    ParseError,
    NotUtf8,
} || fs.File.OpenError || fs.File.ReadError || fs.File.WriteError;

fn lintDir(path: []const u8, parent: fs.Dir, subpath: []const u8) LintError!void {
    var dir = try parent.openDir(subpath, .{ .iterate = true });
    defer dir.close();

    var it = dir.iterate();
    while (try it.next()) |entry| {
        const is_dir = entry.kind == .Directory;
        if (is_dir and mem.eql(u8, entry.name, "zig-cache")) continue;
        if (is_dir or mem.endsWith(u8, entry.name, ".zig")) {
            const fullpath = try fs.path.join(gpa, &.{ path, entry.name });
            defer gpa.free(fullpath);

            if (is_dir) {
                try lintDir(fullpath, dir, entry.name);
            } else {
                try lint(fullpath, dir, entry.name);
            }
        }
    }
}

fn lint(path: []const u8, dir: fs.Dir, subpath: []const u8) LintError!void {
    const source_file = try dir.openFile(subpath, .{});
    defer source_file.close();

    const stat = try source_file.stat();

    if (stat.kind == .Directory) return error.IsDir;

    if (try seen.fetchPut(gpa, stat.inode, {})) |_| return;

    const source = try source_file.readToEndAlloc(gpa, math.maxInt(usize));
    defer gpa.free(source);

    var tree = try std.zig.parse(gpa, source);
    defer tree.deinit(gpa);

    const tags = tree.nodes.items(.tag);
    const tokens = tree.nodes.items(.main_token);
    const data = tree.nodes.items(.data);

    var asserts: u32 = 0;
    var functions: u32 = 0;

    for (tags) |tag, node| {
        switch (tag) {
            .fn_decl => {
                functions += 1;
                const body = data[node].rhs;
                const start = tree.tokenLocation(0, tree.firstToken(body));
                const end = tree.tokenLocation(0, tree.lastToken(body));
                const line = @intCast(u32, start.line + 1);
                const length = end.line - start.line;
                const required = 2;
                switch (length) {
                    0...9 => {},
                    10...70 => {},
                    else => std.log.err("{s}:{d} `{s}` exceeds the 70 line limit by {d} lines", .{
                        path,
                        line,
                        tree.tokenSlice(data[node].rhs),
                        length,
                    }),
                }
            },

            .call_one, .call_one_comma => {
                const lhs = data[node].lhs;
                if (tags[lhs] == .identifier and mem.eql(u8, "assert", tree.tokenSlice(tokens[lhs]))) {
                    asserts += 1;
                }
            },

            .unreachable_literal => asserts += 1,

            else => {},
        }
    }

    try stats.append(gpa, .{
        .path = try gpa.dupe(u8, path),
        .asserts = asserts,
        .functions = functions,
    });
}
