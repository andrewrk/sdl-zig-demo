const Build = @import("std").Build;

pub fn build(b: *Build) void {
    const mode = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "sdl-zig-demo",
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = mode,
    });
    exe.linkSystemLibrary("SDL2");
    exe.linkSystemLibrary("c");

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);

    const run = b.step("run", "Run the demo");
    const run_cmd = exe.run();
    run.dependOn(&run_cmd.step);
}
