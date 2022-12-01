const std = @import("std");
const print = @import("std").debug.print;
const allocator = std.heap.page_allocator;

const payload = @embedFile("input.txt");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    //print("{s}", .{payload.*});

    var start: u64 = 0;
    var end: u64 = 0;
    var biggest_number: u64 = 0;
    var tmp_number: u64 = 0;
    var last_char: u8 = '0';
    var sums = std.ArrayList(u64).init(allocator);
    sums.deinit();
    for (payload.*) |elem , i| {
        if ((payload.*[i] >= '0') and (payload.*[i] <= '9')) {
            // we got a number, so progress end
            end = i;
        } else if (payload.*[i] == '\n') {
            // got a newline
            if (last_char == '\n') {
                // last char was also newline so this elf is finished
                // compare current number to biggest
                try sums.append(tmp_number);
                if (tmp_number > biggest_number) {
                    biggest_number = tmp_number;
                    //try stdout.print("debug biggest number: {d}\n", .{biggest_number});
                }
                // reset number
                tmp_number = 0;
                // start is set to next char
                start = i + 1;
            } else {
                // just the next number
                // Parse number now
                const tmp: u64 = try std.fmt.parseUnsigned(u64, payload.*[start..end+1], 10);
                tmp_number += tmp;
                //try stdout.print("debug sum: {d}\n", .{tmp_number});
                start = i + 1;
                end = start;
            }
        }
        last_char = elem;
    }

    try stdout.print("Biggest number: {d}\n", .{biggest_number});

    var x = sums.toOwnedSlice();
    std.sort.sort(u64, x, {}, comptime std.sort.desc(u64));

    const top_three_cal = x[0] + x[1] + x[2];

    try stdout.print("Top three calories: {d}\n", .{top_three_cal});
}

const Data = struct {
    data: u64,
};

fn cmpByData(context: void, a: Data, b: Data) bool {
    _ = context;
    if (a.data < b.data) {
      return true;
    } else {
      return false;
    }
}
