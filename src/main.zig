const std = @import("std");
const vaxis = @import("vaxis");
const heap = std.heap;
const io = std.io;
const os = std.os;
const mem = std.mem;
const meta = std.meta;
const fmt = std.fmt;

const log = std.log.scoped(.main);

/// Set the default panic handler to the vaxis panic_handler. This will clean up the terminal if any
/// panics occur
pub const panic = vaxis.panic_handler;

/// Set some scope levels for the vaxis scopes
pub const std_options: std.Options = .{
    .log_scope_levels = &.{
        .{ .scope = .vaxis, .level = .warn },
        .{ .scope = .vaxis_parser, .level = .warn },
    },
};

// const ActiveSection = enum {
//     top,
//     mid,
//     btm,
// };

/// User Struct
// pub const User = struct {
//     first: []const u8,
//     last: []const u8,
//     user: []const u8,
//     email: ?[]const u8 = null,
//     phone: ?[]const u8 = null,
// };

// // Users Array
// const users = [_]User{
//     .{ .first = "Nancy", .last = "Dudley", .user = "angela73", .email = "brian47@rodriguez.biz", .phone = null },
//     .{ .first = "Emily", .last = "Thornton", .user = "mrogers", .email = null, .phone = "(558)888-8604x094" },
//     .{ .first = "Kyle", .last = "Huff", .user = "xsmith", .email = null, .phone = "301.127.0801x12398" },
//     .{ .first = "Christine", .last = "Dodson", .user = "amandabradley", .email = "cheryl21@sullivan.com", .phone = null },
//     .{ .first = "Nathaniel", .last = "Kennedy", .user = "nrobinson", .email = null, .phone = null },
//     .{ .first = "Laura", .last = "Leon", .user = "dawnjones", .email = "fjenkins@patel.com", .phone = "1833013180" },
//     .{ .first = "Patrick", .last = "Landry", .user = "michaelhutchinson", .email = "daniel17@medina-wallace.net", .phone = "+1-634-486-6444x964" },
//     .{ .first = "Tammy", .last = "Hall", .user = "jamessmith", .email = null, .phone = "(926)810-3385x22059" },
//     .{ .first = "Stephanie", .last = "Anderson", .user = "wgillespie", .email = "campbelljaime@yahoo.com", .phone = null },
//     .{ .first = "Jennifer", .last = "Williams", .user = "shawn60", .email = null, .phone = "611-385-4771x97523" },
//     .{ .first = "Elizabeth", .last = "Ortiz", .user = "jennifer76", .email = "johnbradley@delgado.info", .phone = null },
//     .{ .first = "Stacy", .last = "Mays", .user = "scottgonzalez", .email = "kramermatthew@gmail.com", .phone = null },
//     .{ .first = "Jennifer", .last = "Smith", .user = "joseph75", .email = "masseyalexander@hill-moore.net", .phone = null },
//     .{ .first = "Gary", .last = "Hammond", .user = "brittany26", .email = null, .phone = null },
//     .{ .first = "Lisa", .last = "Johnson", .user = "tina28", .email = null, .phone = "850-606-2978x1081" },
//     .{ .first = "Zachary", .last = "Hopkins", .user = "vargasmichael", .email = null, .phone = null },
//     .{ .first = "Joshua", .last = "Kidd", .user = "ghanna", .email = "jbrown@yahoo.com", .phone = null },
//     .{ .first = "Dawn", .last = "Jones", .user = "alisonlindsey", .email = null, .phone = null },
//     .{ .first = "Monica", .last = "Berry", .user = "barbara40", .email = "michael00@hotmail.com", .phone = "(295)346-6453x343" },
//     .{ .first = "Shannon", .last = "Roberts", .user = "krystal37", .email = null, .phone = "980-920-9386x454" },
//     .{ .first = "Thomas", .last = "Mitchell", .user = "williamscorey", .email = "richardduncan@roberts.com", .phone = null },
//     .{ .first = "Nicole", .last = "Shaffer", .user = "rogerstroy", .email = null, .phone = "(570)128-5662" },
//     .{ .first = "Edward", .last = "Bennett", .user = "andersonchristina", .email = null, .phone = null },
//     .{ .first = "Duane", .last = "Howard", .user = "pcarpenter", .email = "griffithwayne@parker.net", .phone = null },
//     .{ .first = "Mary", .last = "Brown", .user = "kimberlyfrost", .email = "perezsara@anderson-andrews.net", .phone = null },
//     .{ .first = "Pamela", .last = "Sloan", .user = "kvelez", .email = "huynhlacey@moore-bell.biz", .phone = "001-359-125-1393x8716" },
//     .{ .first = "Timothy", .last = "Charles", .user = "anthony04", .email = "morrissara@hawkins.info", .phone = "+1-619-369-9572" },
//     .{ .first = "Sydney", .last = "Torres", .user = "scott42", .email = "asnyder@mitchell.net", .phone = null },
//     .{ .first = "John", .last = "Jones", .user = "anthonymoore", .email = null, .phone = "701.236.0571x99622" },
//     .{ .first = "Erik", .last = "Johnson", .user = "allisonsanders", .email = null, .phone = null },
//     .{ .first = "Donna", .last = "Kirk", .user = "laurie81", .email = null, .phone = null },
//     .{ .first = "Karina", .last = "White", .user = "uperez", .email = null, .phone = null },
//     .{ .first = "Jesse", .last = "Schwartz", .user = "ryan60", .email = "latoyawilliams@gmail.com", .phone = null },
//     .{ .first = "Cindy", .last = "Romero", .user = "christopher78", .email = "faulknerchristina@gmail.com", .phone = "780.288.2319x583" },
//     .{ .first = "Tyler", .last = "Sanders", .user = "bennettjessica", .email = null, .phone = "1966269423" },
//     .{ .first = "Pamela", .last = "Carter", .user = "zsnyder", .email = null, .phone = "125-062-9130x58413" },
// };

// /// Tagged union of all events our application will handle. These can be generated by Vaxis or your
// /// own custom events
const Event = union(enum) {
    key_press: vaxis.Key,
    key_release: vaxis.Key,
    mouse: vaxis.Mouse,
    focus_in, // window has gained focus
    focus_out, // window has lost focus
    paste_start, // bracketed paste start
    paste_end, // bracketed paste end
    paste: []const u8, // osc 52 paste, caller must free
    color_report: vaxis.Color.Report, // osc 4, 10, 11, 12 response
    color_scheme: vaxis.Color.Scheme, // light / dark OS theme changes
    winsize: vaxis.Winsize, // the window size has changed. This event is always sent when the loop
    table_upd,
    // is started
};

// /// The application state
const MyApp = struct {
    alloc: std.mem.Allocator,
    history: *History,
    //     // A flag for if we should quit
    should_quit: bool,
    //     /// The tty we are talking to
    tty: vaxis.Tty,
    //     /// The vaxis instance
    vx: vaxis.Vaxis,
    //     /// A mouse event that we will handle in the draw cycle
    mouse: ?vaxis.Mouse,
    loop: vaxis.Loop(Event),

    pub fn init(allocator: std.mem.Allocator, history: *History) !MyApp {
        return .{
            .alloc = allocator,
            .history = history,
            .should_quit = false,
            .tty = try vaxis.Tty.init(),
            .vx = try vaxis.init(allocator, .{}),
            .mouse = null,
            .loop = undefined,
        };
    }

    pub fn deinit(self: *MyApp) void {
        // Deinit takes an optional allocator. You can choose to pass an allocator to clean up
        // memory, or pass null if your application is shutting down and let the OS clean up the
        // memory
        self.vx.deinit(self.alloc, self.tty.anyWriter());
        self.tty.deinit();
    }

    pub fn run(self: *MyApp) !void {
        // Users set up below the main function
        const users_buf = try self.alloc.dupe(HistoryCommand, self.history.commands.items[0..]);
        // const users_buf = try self.alloc.dupe(User, users[0..5]);
        // for (users_buf, 0..) |*user, i| {
        //     user.first = self.history.commands.items[i].cmd;
        // }
        const user_list = std.ArrayList(HistoryCommand).fromOwnedSlice(self.alloc, users_buf);
        // const user_list = std.ArrayList(User).fromOwnedSlice(self.alloc, users_buf);
        defer user_list.deinit();
        var user_mal = std.MultiArrayList(HistoryCommand){};
        // var user_mal = std.MultiArrayList(User){};
        for (users_buf[0..]) |user| try user_mal.append(self.alloc, user);
        defer user_mal.deinit(self.alloc);

        // var tty = try vaxis.Tty.init();
        // defer tty.deinit();
        var tty_buf_writer = self.tty.bufferedWriter();
        defer tty_buf_writer.flush() catch {};
        const tty_writer = tty_buf_writer.writer().any();
        var vx = try vaxis.init(self.alloc, .{
            .kitty_keyboard_flags = .{ .report_events = true },
        });
        defer vx.deinit(self.alloc, self.tty.anyWriter());

        self.loop = .{ .tty = &self.tty, .vaxis = &self.vx };
        try self.loop.init();
        try self.loop.start();
        defer self.loop.stop();
        try vx.enterAltScreen(self.tty.anyWriter());
        try vx.queryTerminal(self.tty.anyWriter(), 250 * std.time.ns_per_ms);

        const logo =
            \\░█░█░█▀█░█░█░▀█▀░█▀▀░░░▀█▀░█▀█░█▀▄░█░░░█▀▀░
            \\░▀▄▀░█▀█░▄▀▄░░█░░▀▀█░░░░█░░█▀█░█▀▄░█░░░█▀▀░
            \\░░▀░░▀░▀░▀░▀░▀▀▀░▀▀▀░░░░▀░░▀░▀░▀▀░░▀▀▀░▀▀▀░
        ;
        const title_logo = vaxis.Cell.Segment{
            .text = logo,
            .style = .{},
        };
        const title_info = vaxis.Cell.Segment{
            .text = "===A Demo of the the Vaxis Table Widget!===",
            .style = .{},
        };
        const title_disclaimer = vaxis.Cell.Segment{
            .text = "(All data is non-sensical & LLM generated.)",
            .style = .{},
        };
        var title_segs = [_]vaxis.Cell.Segment{ title_logo, title_info, title_disclaimer };

        var cmd_input = vaxis.widgets.TextInput.init(self.alloc, &vx.unicode);
        defer cmd_input.deinit();

        // Colors
        const active_bg: vaxis.Cell.Color = .{ .rgb = .{ 64, 128, 255 } };
        const selected_bg: vaxis.Cell.Color = .{ .rgb = .{ 32, 64, 255 } };
        const other_bg: vaxis.Cell.Color = .{ .rgb = .{ 32, 32, 48 } };

        // Table Conext
        var demo_tbl: vaxis.widgets.Table.TableContext = .{
            .active_bg = active_bg,
            .active_fg = .{ .rgb = .{ 0, 0, 0 } },
            .row_bg_1 = .{ .rgb = .{ 8, 8, 8 } },
            .selected_bg = selected_bg,
            .header_names = .{ .custom = &.{"Cmd"} },
            //.header_align = .left,
            .col_indexes = .{ .by_idx = &.{0} },
            //.col_align = .{ .by_idx = &.{ .left, .left, .center, .center, .left } },
            //.col_align = .{ .all = .center },
            //.header_borders = true,
            //.col_borders = true,
            //.col_width = .{ .static_all = 15 },
            //.col_width = .{ .dynamic_header_len = 3 },
            //.col_width = .{ .static_individual = &.{ 10, 20, 15, 25, 15 } },
            //.col_width = .dynamic_fill,
            //.y_off = 10,
        };
        defer if (demo_tbl.sel_rows) |rows| self.alloc.free(rows);

        // TUI State
        var active: ActiveSection = .mid;
        var moving = false;
        var see_content = false;

        // Create an Arena Allocator for easy allocations on each Event.
        var event_arena = heap.ArenaAllocator.init(self.alloc);
        defer event_arena.deinit();
        while (true) {
            defer _ = event_arena.reset(.retain_capacity);
            defer tty_buf_writer.flush() catch {};
            const event_alloc = event_arena.allocator();
            const event = self.loop.nextEvent();

            switch (event) {
                .key_press => |key| keyEvt: {
                    // Close the Program
                    if (key.matches('c', .{ .ctrl = true })) {
                        break;
                    }
                    // Refresh the Screen
                    if (key.matches('l', .{ .ctrl = true })) {
                        vx.queueRefresh();
                        break :keyEvt;
                    }
                    // Enter Moving State
                    if (key.matches('w', .{ .ctrl = true })) {
                        moving = !moving;
                        break :keyEvt;
                    }
                    // Command State
                    if (active != .btm and
                        key.matchesAny(&.{ ':', '/', 'g', 'G' }, .{}))
                    {
                        active = .btm;
                        cmd_input.clearAndFree();
                        try cmd_input.update(.{ .key_press = key });
                        break :keyEvt;
                    }

                    switch (active) {
                        .top => {
                            if (key.matchesAny(&.{ vaxis.Key.down, 'j' }, .{}) and moving) active = .mid;
                        },
                        .mid => midEvt: {
                            if (moving) {
                                if (key.matchesAny(&.{ vaxis.Key.up, 'k' }, .{})) active = .top;
                                if (key.matchesAny(&.{ vaxis.Key.down, 'j' }, .{})) active = .btm;
                                break :midEvt;
                            }
                            // Change Row
                            if (key.matchesAny(&.{ vaxis.Key.up, 'k' }, .{})) demo_tbl.row -|= 1;
                            if (key.matchesAny(&.{ vaxis.Key.down, 'j' }, .{})) demo_tbl.row +|= 1;
                            // Change Column
                            if (key.matchesAny(&.{ vaxis.Key.left, 'h' }, .{})) demo_tbl.col -|= 1;
                            if (key.matchesAny(&.{ vaxis.Key.right, 'l' }, .{})) demo_tbl.col +|= 1;
                            // Select/Unselect Row
                            if (key.matches(vaxis.Key.space, .{})) {
                                const rows = demo_tbl.sel_rows orelse createRows: {
                                    demo_tbl.sel_rows = try self.alloc.alloc(u16, 1);
                                    break :createRows demo_tbl.sel_rows.?;
                                };
                                var rows_list = std.ArrayList(u16).fromOwnedSlice(self.alloc, rows);
                                for (rows_list.items, 0..) |row, idx| {
                                    if (row != demo_tbl.row) continue;
                                    _ = rows_list.orderedRemove(idx);
                                    break;
                                } else try rows_list.append(demo_tbl.row);
                                demo_tbl.sel_rows = try rows_list.toOwnedSlice();
                            }
                            // See Row Content
                            if (key.matches(vaxis.Key.enter, .{}) or key.matches('j', .{ .ctrl = true })) see_content = !see_content;
                        },
                        .btm => {
                            if (key.matchesAny(&.{ vaxis.Key.up, 'k' }, .{}) and moving) active = .mid
                                // Run Command and Clear Command Bar
                            else if (key.matchExact(vaxis.Key.enter, .{}) or key.matchExact('j', .{ .ctrl = true })) {
                                const cmd = try cmd_input.toOwnedSlice();
                                defer self.alloc.free(cmd);
                                if (mem.eql(u8, ":q", cmd) or
                                    mem.eql(u8, ":quit", cmd) or
                                    mem.eql(u8, ":exit", cmd)) return;
                                if (mem.eql(u8, "G", cmd)) {
                                    demo_tbl.row = @intCast(user_list.items.len - 1);
                                    active = .mid;
                                }
                                if (cmd.len >= 2 and mem.eql(u8, "gg", cmd[0..2])) {
                                    const goto_row = fmt.parseInt(u16, cmd[2..], 0) catch 0;
                                    demo_tbl.row = goto_row;
                                    active = .mid;
                                }
                            } else try cmd_input.update(.{ .key_press = key });
                        },
                    }
                    moving = false;
                },
                .winsize => |ws| try vx.resize(self.alloc, self.tty.anyWriter(), ws),
                else => {},
            }

            // Content
            seeRow: {
                if (!see_content) {
                    demo_tbl.active_content_fn = null;
                    demo_tbl.active_ctx = &{};
                    break :seeRow;
                }
                const RowContext = struct {
                    row: []const u8,
                    bg: vaxis.Color,
                };
                const row_ctx = RowContext{
                    .row = try fmt.allocPrint(event_alloc, "Row #: {d}", .{demo_tbl.row}),
                    .bg = demo_tbl.active_bg,
                };
                demo_tbl.active_ctx = &row_ctx;
                demo_tbl.active_content_fn = struct {
                    fn see(win: *vaxis.Window, ctx_raw: *const anyopaque) !u16 {
                        const ctx: *const RowContext = @alignCast(@ptrCast(ctx_raw));
                        win.height = 5;
                        const see_win = win.child(.{
                            .x_off = 0,
                            .y_off = 1,
                            .width = win.width,
                            .height = 4,
                        });
                        see_win.fill(.{ .style = .{ .bg = ctx.bg } });
                        const content_logo =
                            \\
                            \\░█▀▄░█▀█░█░█░░░█▀▀░█▀█░█▀█░▀█▀░█▀▀░█▀█░▀█▀
                            \\░█▀▄░█░█░█▄█░░░█░░░█░█░█░█░░█░░█▀▀░█░█░░█░
                            \\░▀░▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░░▀░
                        ;
                        const content_segs: []const vaxis.Cell.Segment = &.{
                            .{
                                .text = ctx.row,
                                .style = .{ .bg = ctx.bg },
                            },
                            .{
                                .text = content_logo,
                                .style = .{ .bg = ctx.bg },
                            },
                        };
                        _ = see_win.print(content_segs, .{});
                        return see_win.height;
                    }
                }.see;
                self.loop.postEvent(.table_upd);
            }

            // Sections
            // - Window
            const win = vx.window();
            win.clear();

            // - Top
            const top_div = 6;
            const top_bar = win.child(.{
                .x_off = 0,
                .y_off = 0,
                .width = win.width,
                .height = win.height / top_div,
            });
            for (title_segs[0..]) |*title_seg|
                title_seg.style.bg = if (active == .top) selected_bg else other_bg;
            top_bar.fill(.{ .style = .{
                .bg = if (active == .top) selected_bg else other_bg,
            } });
            const logo_bar = vaxis.widgets.alignment.center(
                top_bar,
                44,
                top_bar.height - (top_bar.height / 3),
            );
            _ = logo_bar.print(title_segs[0..], .{ .wrap = .word });

            // - Middle
            const middle_bar = win.child(.{
                .x_off = 0,
                .y_off = win.height / top_div,
                .width = win.width,
                .height = win.height - (top_bar.height + 1),
            });
            if (user_list.items.len > 0) {
                demo_tbl.active = active == .mid;
                try vaxis.widgets.Table.drawTable(
                    event_alloc,
                    middle_bar,
                    //users_buf[0..],
                    //user_list,
                    user_mal,
                    &demo_tbl,
                );
            }

            // - Bottom
            const bottom_bar = win.child(.{
                .x_off = 0,
                .y_off = win.height - 1,
                .width = win.width,
                .height = 1,
            });
            if (active == .btm) bottom_bar.fill(.{ .style = .{ .bg = active_bg } });
            cmd_input.draw(bottom_bar);

            // Render the screen
            try vx.render(tty_writer);
        }
    }
};

const HistoryCommand = struct {
    cmd: []const u8,
};

const HistoryKind = enum {
    zsh,
    bash,
};

const History = struct {
    const Self = @This();
    allocator: std.mem.Allocator,
    location: []const u8,
    kind: HistoryKind,
    commands: std.ArrayList(HistoryCommand),

    pub fn init(allocator: std.mem.Allocator, location: []const u8, kind: HistoryKind) !*History {
        const self = try allocator.create(Self);
        self.* = Self{
            .allocator = allocator,
            .location = location,
            .kind = kind,
            .commands = std.ArrayList(HistoryCommand).init(allocator),
        };
        return self;
    }

    pub fn deinit(self: *Self) void {
        for (self.commands.items) |item| self.allocator.free(item.cmd);
        self.commands.deinit();
        self.allocator.destroy(self);
    }

    pub fn load(self: *Self) !void {
        const home = std.posix.getenv("HOME");
        if (home) |h| {
            // std.debug.print("home: {s}\n", .{h});
            // const full_file = try std.fmt.allocPrint(self.allocator, "{s}/{s}", .{ h, self.location });
            // std.debug.print("full_file: {s}\n", .{full_file});
            const result_path = try std.fmt.allocPrint(self.allocator, "{s}{s}", .{ h, self.location[1..] });
            defer self.allocator.free(result_path);
            // std.debug.print("location: {s}\n", .{result_path});
            var file = try std.fs.cwd().openFile(result_path, .{});
            defer file.close();

            // Create a buffered reader
            const file_size = try file.getEndPos();
            const file_content = try self.allocator.alloc(u8, file_size);
            defer self.allocator.free(file_content);

            _ = try file.readAll(file_content);

            // Split the file content on newlines
            var it = std.mem.splitSequence(u8, file_content, "\n");
            while (it.next()) |line| {
                // Process each line
                if (line.len == 0) {
                    continue;
                }

                if (line[0] == ':') {
                    if (std.mem.indexOf(u8, line, ";")) |semi_loc| {
                        const l = line[semi_loc + 1 ..];
                        // try std.io.getStdOut().writer().print("{s}\n", .{l});
                        try self.commands.append(.{ .cmd = try self.allocator.dupe(u8, l) });
                    }
                } else {
                    // try std.io.getStdOut().writer().print("{s}\n", .{line});
                    try self.commands.append(.{ .cmd = try self.allocator.dupe(u8, line) });
                }
            }
        }
    }
};

/// Keep our main function small. Typically handling arg parsing and initialization only
// pub fn main() !void {
//     var gpa = std.heap.GeneralPurposeAllocator(.{}){};
//     defer {
//         const deinit_status = gpa.deinit();
//         //fail test; can't try in defer as defer is executed after we return
//         if (deinit_status == .leak) {
//             std.log.err("memory leak", .{});
//         }
//     }
//     const allocator = gpa.allocator();

//     const outw = std.io.getStdOut().writer();
//     const histfile = std.posix.getenv("HISTFILE");
//     const shell = std.posix.getenv("SHELL");

//     if (shell) |s| {
//         // try outw.print("Shell: {s}\n", .{s});

//         // if (std.mem.containsAtLeast(u8, s, 1, "zsh")) {
//         //     try outw.print("Zsh detected\n", .{});
//         // }

//         var history_file: []const u8 = undefined;
//         var history_kind: HistoryKind = undefined;

//         if (histfile) |h| {
//             history_file = h;
//         } else {
//             if (std.mem.containsAtLeast(u8, s, 1, "zsh")) {
//                 history_file = "~/.zsh_history"[0..];
//                 history_kind = .zsh;
//             } else {
//                 history_file = "~/.bash_history"[0..];
//                 history_kind = .bash;
//             }
//         }

//         var history = try History.init(allocator, history_file, history_kind);
//         defer history.deinit();
//         try history.load();

//         // try outw.print("History file: {s}\n", .{history.location});

//         // Initialize our application
//         var app = try MyApp.init(allocator, history);
//         defer app.deinit();

//         // Run the application
//         try app.run();
//     } else {
//         try outw.print("No shell detected\n", .{});
//         return;
//     }
// }

const ActiveSection = enum {
    top,
    mid,
    btm,
};

pub fn main() !void {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.detectLeaks()) log.err("Memory leak detected!", .{});
    const alloc = gpa.allocator();

    const outw = std.io.getStdOut().writer();
    const histfile = std.posix.getenv("HISTFILE");
    const shell = std.posix.getenv("SHELL");

    if (shell) |s| {
        // try outw.print("Shell: {s}\n", .{s});

        // if (std.mem.containsAtLeast(u8, s, 1, "zsh")) {
        //     try outw.print("Zsh detected\n", .{});
        // }

        var history_file: []const u8 = undefined;
        var history_kind: HistoryKind = undefined;

        if (histfile) |h| {
            history_file = h;
        } else {
            if (std.mem.containsAtLeast(u8, s, 1, "zsh")) {
                history_file = "~/.zsh_history"[0..];
                history_kind = .zsh;
            } else {
                history_file = "~/.bash_history"[0..];
                history_kind = .bash;
            }
        }

        var history = try History.init(alloc, history_file, history_kind);
        defer history.deinit();
        try history.load();

        // try outw.print("History file: {s}\n", .{history.location});

        // Initialize our application
        var app = try MyApp.init(alloc, history);
        defer app.deinit();

        // Run the application
        try app.run();
    } else {
        try outw.print("No shell detected\n", .{});
        return;
    }
}

/// User Struct
pub const User = struct {
    first: []const u8,
    last: []const u8,
    user: []const u8,
    email: ?[]const u8 = null,
    phone: ?[]const u8 = null,
};

// Users Array
const users = [_]User{
    .{ .first = "Nancy", .last = "Dudley", .user = "angela73", .email = "brian47@rodriguez.biz", .phone = null },
    .{ .first = "Emily", .last = "Thornton", .user = "mrogers", .email = null, .phone = "(558)888-8604x094" },
    .{ .first = "Kyle", .last = "Huff", .user = "xsmith", .email = null, .phone = "301.127.0801x12398" },
    .{ .first = "Christine", .last = "Dodson", .user = "amandabradley", .email = "cheryl21@sullivan.com", .phone = null },
    .{ .first = "Nathaniel", .last = "Kennedy", .user = "nrobinson", .email = null, .phone = null },
    .{ .first = "Laura", .last = "Leon", .user = "dawnjones", .email = "fjenkins@patel.com", .phone = "1833013180" },
    .{ .first = "Patrick", .last = "Landry", .user = "michaelhutchinson", .email = "daniel17@medina-wallace.net", .phone = "+1-634-486-6444x964" },
    .{ .first = "Tammy", .last = "Hall", .user = "jamessmith", .email = null, .phone = "(926)810-3385x22059" },
    .{ .first = "Stephanie", .last = "Anderson", .user = "wgillespie", .email = "campbelljaime@yahoo.com", .phone = null },
    .{ .first = "Jennifer", .last = "Williams", .user = "shawn60", .email = null, .phone = "611-385-4771x97523" },
    .{ .first = "Elizabeth", .last = "Ortiz", .user = "jennifer76", .email = "johnbradley@delgado.info", .phone = null },
    .{ .first = "Stacy", .last = "Mays", .user = "scottgonzalez", .email = "kramermatthew@gmail.com", .phone = null },
    .{ .first = "Jennifer", .last = "Smith", .user = "joseph75", .email = "masseyalexander@hill-moore.net", .phone = null },
    .{ .first = "Gary", .last = "Hammond", .user = "brittany26", .email = null, .phone = null },
    .{ .first = "Lisa", .last = "Johnson", .user = "tina28", .email = null, .phone = "850-606-2978x1081" },
    .{ .first = "Zachary", .last = "Hopkins", .user = "vargasmichael", .email = null, .phone = null },
    .{ .first = "Joshua", .last = "Kidd", .user = "ghanna", .email = "jbrown@yahoo.com", .phone = null },
    .{ .first = "Dawn", .last = "Jones", .user = "alisonlindsey", .email = null, .phone = null },
    .{ .first = "Monica", .last = "Berry", .user = "barbara40", .email = "michael00@hotmail.com", .phone = "(295)346-6453x343" },
    .{ .first = "Shannon", .last = "Roberts", .user = "krystal37", .email = null, .phone = "980-920-9386x454" },
    .{ .first = "Thomas", .last = "Mitchell", .user = "williamscorey", .email = "richardduncan@roberts.com", .phone = null },
    .{ .first = "Nicole", .last = "Shaffer", .user = "rogerstroy", .email = null, .phone = "(570)128-5662" },
    .{ .first = "Edward", .last = "Bennett", .user = "andersonchristina", .email = null, .phone = null },
    .{ .first = "Duane", .last = "Howard", .user = "pcarpenter", .email = "griffithwayne@parker.net", .phone = null },
    .{ .first = "Mary", .last = "Brown", .user = "kimberlyfrost", .email = "perezsara@anderson-andrews.net", .phone = null },
    .{ .first = "Pamela", .last = "Sloan", .user = "kvelez", .email = "huynhlacey@moore-bell.biz", .phone = "001-359-125-1393x8716" },
    .{ .first = "Timothy", .last = "Charles", .user = "anthony04", .email = "morrissara@hawkins.info", .phone = "+1-619-369-9572" },
    .{ .first = "Sydney", .last = "Torres", .user = "scott42", .email = "asnyder@mitchell.net", .phone = null },
    .{ .first = "John", .last = "Jones", .user = "anthonymoore", .email = null, .phone = "701.236.0571x99622" },
    .{ .first = "Erik", .last = "Johnson", .user = "allisonsanders", .email = null, .phone = null },
    .{ .first = "Donna", .last = "Kirk", .user = "laurie81", .email = null, .phone = null },
    .{ .first = "Karina", .last = "White", .user = "uperez", .email = null, .phone = null },
    .{ .first = "Jesse", .last = "Schwartz", .user = "ryan60", .email = "latoyawilliams@gmail.com", .phone = null },
    .{ .first = "Cindy", .last = "Romero", .user = "christopher78", .email = "faulknerchristina@gmail.com", .phone = "780.288.2319x583" },
    .{ .first = "Tyler", .last = "Sanders", .user = "bennettjessica", .email = null, .phone = "1966269423" },
    .{ .first = "Pamela", .last = "Carter", .user = "zsnyder", .email = null, .phone = "125-062-9130x58413" },
};
