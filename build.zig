const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zig-bench",
        .root_source_file = .{ .path = "bench.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    const tests = b.addTest(.{
        .name = "test",
        .root_source_file = .{ .path = "bench.zig" },
        .target = target,
        .optimize = optimize,
    });

    const test_install = b.addInstallArtifact(tests, .{});

    const test_step = b.step("test", "Run the libraries tests");
    test_step.dependOn(&test_install.step);
}
