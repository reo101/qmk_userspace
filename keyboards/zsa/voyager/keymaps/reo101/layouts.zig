const std = @import("std");

// zig fmt: off
// zig fmt: on
pub fn layout(
    comptime T: type,
    comptime segments: comptime_int,
    comptime rows: comptime_int,
    comptime cols: comptime_int,
    reverse_last: bool,
    keys: [segments * rows * cols]T,
) [segments * rows][cols]T {
    var result: [segments * rows][cols]T = undefined;

    var row: u8 = 0;
    var segment: u8 = undefined;

    while (row < rows) : (row += 1) {
        segment = 0;
        while (segment < segments) : (segment += 1) {
            std.mem.copyForwards(
                T,
                result[rows * segment + row][0..],
                keys[((row * 2) + segment) * cols .. ((row * 2) + segment + 1) * cols],
            );
        }
        if (reverse_last and segment != 0) {
            // Reverse last segment (if wanted)
            std.mem.reverse(T, result[rows * (segment - 1) + row][0..]);
        }
    }

    return result;
}

// VOYAGER

// #define LAYOUT_voyager( \
//   k00, k01, k02, k03, k04, k05,                 k26, k27, k28, k29, k30, k31, \
//   k06, k07, k08, k09, k10, k11,                 k32, k33, k34, k35, k36, k37, \
//   k12, k13, k14, k15, k16, k17,                 k38, k39, k40, k41, k42, k43, \
//   k18, k19, k20, k21, k22, k23,                 k44, k45, k46, k47, k48, k49, \
//                               k24, k25, k50, k51 \
// )\
// { \
//     { KC_NO, k00, k01, k02, k03, k04, k05 }, \
//     { KC_NO, k06, k07, k08, k09, k10, k11 }, \
//     { KC_NO, k12, k13, k14, k15, k16, k17 }, \
//     { KC_NO, k18, k19, k20, k21, k22, KC_NO }, \
//     { KC_NO, KC_NO, KC_NO, KC_NO, k23, KC_NO, KC_NO }, \
//     { k24, k25, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO }, \
// \
//     { k26, k27, k28, k29, k30, k31, KC_NO }, \
//     { k32, k33, k34, k35, k36, k37, KC_NO }, \
//     { k38, k39, k40, k41, k42, k43, KC_NO }, \
//     { KC_NO, k45, k46, k47, k48, k49, KC_NO }, \
//     { KC_NO, KC_NO, k44, KC_NO, KC_NO, KC_NO, KC_NO }, \
//     { KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, k50, k51 }, \
// }

pub fn layout_voyager(
    comptime T: type,
    empty: T,
    keys: [52]T,
) [12][7]T {
    const k = keys;
    const no = empty;

    const SEGMENTS = 2;
    const ROWS = 6;
    const COLS = 7;

    // zig fmt: off
    _ = .{
        k[0],  k[1],  k[2],  k[3],  k[4],  k[5],      k[26], k[27], k[28], k[29], k[30], k[31],
        k[6],  k[7],  k[8],  k[9],  k[10], k[11],     k[32], k[33], k[34], k[35], k[36], k[37],
        k[12], k[13], k[14], k[15], k[16], k[17],     k[38], k[39], k[40], k[41], k[42], k[43],
        k[18], k[19], k[20], k[21], k[22], k[23],     k[44], k[45], k[46], k[47], k[48], k[49],
                                    k[24], k[25],     k[50], k[51],
    };
    // Indices of each k_i in the provided array
    const indexed = blk: {
        const inverse = .{
            0,  1,  2,  3,  4,  5,  // 0 - 5
            12, 13, 14, 15, 16, 17, // 6 - 11
            24, 25, 26, 27, 28, 29, // 12 - 17
            36, 37, 38, 39, 40, 41, // 18 - 23
                            48, 49, // 24 - 25
            6,  7,  8,  9,  10, 11, // 26 - 31
            18, 19, 20, 21, 22, 23, // 32 - 37
            30, 31, 32, 33, 34, 35, // 38 - 43
            42, 43, 44, 45, 46, 47, // 44 - 49
            50, 51,                 // 50 - 51
        };
        var result = [_]T{undefined} ** 52;

        inline for (&result, 0..) |*r, i| {
            r.* = k[inverse[i]];
        }

        break :blk result;
    };
    // zig fmt: on
    const i = indexed;

    // zig fmt: off
    // Board-specific wiring
    const real = [SEGMENTS * ROWS * COLS]T{
         no,    i[0],  i[1],  i[2],  i[3],  i[4],  i[5],  i[26], i[27], i[28], i[29], i[30], i[31], no,
         no,    i[6],  i[7],  i[8],  i[9],  i[10], i[11], i[32], i[33], i[34], i[35], i[36], i[37], no,
         no,    i[12], i[13], i[14], i[15], i[16], i[17], i[38], i[39], i[40], i[41], i[42], i[43], no,
         no,    i[18], i[19], i[20], i[21], i[22], no,    no,    i[45], i[46], i[47], i[48], i[49], no,
         no,    no,    no,    no,    i[23], no,    no,    no,    no,    i[44], no,    no,    no,    no,
         i[24], i[25], no,    no,    no,    no,    no,    no,    no,    no,    no,    no,    i[50], i[51],
    };
    // zig fmt: on

    const prepared = layout(
        T,
        SEGMENTS,
        ROWS,
        COLS,
        false,
        real,
    );

    return prepared;
}

test "Voyager" {
    const ElemType: type = [:0]const u8;

    const SEGMENTS = 2;
    const ROWS = 6;
    const COLS = 7;

    // zig fmt: off
    const src = [52]ElemType{
        "k00", "k01", "k02", "k03", "k04", "k05",     "k26", "k27", "k28", "k29", "k30", "k31",
        "k06", "k07", "k08", "k09", "k10", "k11",     "k32", "k33", "k34", "k35", "k36", "k37",
        "k12", "k13", "k14", "k15", "k16", "k17",     "k38", "k39", "k40", "k41", "k42", "k43",
        "k18", "k19", "k20", "k21", "k22", "k23",     "k44", "k45", "k46", "k47", "k48", "k49",
                                    "k24", "k25",     "k50", "k51",
    };
    // zig fmt: on

    // zig fmt: off
    const expected = [SEGMENTS * ROWS][COLS]ElemType{
        .{ "KC_NO", "k00",   "k01",   "k02",   "k03",   "k04",   "k05",   },
        .{ "KC_NO", "k06",   "k07",   "k08",   "k09",   "k10",   "k11",   },
        .{ "KC_NO", "k12",   "k13",   "k14",   "k15",   "k16",   "k17",   },
        .{ "KC_NO", "k18",   "k19",   "k20",   "k21",   "k22",   "KC_NO", },
        .{ "KC_NO", "KC_NO", "KC_NO", "KC_NO", "k23",   "KC_NO", "KC_NO", },
        .{ "k24",   "k25",   "KC_NO", "KC_NO", "KC_NO", "KC_NO", "KC_NO", },

        .{ "k26",   "k27",   "k28",   "k29",   "k30",   "k31",   "KC_NO", },
        .{ "k32",   "k33",   "k34",   "k35",   "k36",   "k37",   "KC_NO", },
        .{ "k38",   "k39",   "k40",   "k41",   "k42",   "k43",   "KC_NO", },
        .{ "KC_NO", "k45",   "k46",   "k47",   "k48",   "k49",   "KC_NO", },
        .{ "KC_NO", "KC_NO", "k44",   "KC_NO", "KC_NO", "KC_NO", "KC_NO", },
        .{ "KC_NO", "KC_NO", "KC_NO", "KC_NO", "KC_NO", "k50",   "k51",   },
    };
    // zig fmt: on

    const actual = layout_voyager(
        ElemType,
        "KC_NO",
        src,
    );

    try std.testing.expectEqual(expected, actual);
}

// PLANCK

// #define LAYOUT( \
//     LA1, LA2, LA3, LA4, LA5, LA6,           RA6, RA5, RA4, RA3, RA2, RA1, \
//     LB1, LB2, LB3, LB4, LB5, LB6,           RB6, RB5, RB4, RB3, RB2, RB1, \
//     LC1, LC2, LC3, LC4, LC5, LC6,           RC6, RC5, RC4, RC3, RC2, RC1, \
//     LD1, LD2, LD3, LD4, LD5, LD6, LE6, RE6, RD6, RD5, RD4, RD3, RD2, RD1, \
//                         LE3, LE4, LE5, RE5, RE4, RE3 \
//     ) \
//     { \
//         { LA1, LA2, LA3, LA4, LA5, LA6 }, \
//         { LB1, LB2, LB3, LB4, LB5, LB6 }, \
//         { LC1, LC2, LC3, LC4, LC5, LC6 }, \
//         { LD1, LD2, LD3, LD4, LD5, LD6 }, \
//         { KC_NO, KC_NO, LE3, LE4, LE5, LE6 }, \
//         { RA1, RA2, RA3, RA4, RA5, RA6 }, \
//         { RB1, RB2, RB3, RB4, RB5, RB6 }, \
//         { RC1, RC2, RC3, RC4, RC5, RC6 }, \
//         { RD1, RD2, RD3, RD4, RD5, RD6 }, \
//         { KC_NO, KC_NO, RE3, RE4, RE5, RE6 } \
//     }

test "Planck" {
    const ElemType: type = [:0]const u8;

    const SEGMENTS = 2;
    const ROWS = 5;
    const COLS = 6;

    const src = [SEGMENTS * ROWS * COLS]ElemType{
        "LA1", "LA2", "LA3", "LA4", "LA5", "LA6", "RA6", "RA5", "RA4", "RA3", "RA2", "RA1",
        "LB1", "LB2", "LB3", "LB4", "LB5", "LB6", "RB6", "RB5", "RB4", "RB3", "RB2", "RB1",
        "LC1", "LC2", "LC3", "LC4", "LC5", "LC6", "RC6", "RC5", "RC4", "RC3", "RC2", "RC1",
        "LD1", "LD2", "LD3", "LD4", "LD5", "LD6", "RD6", "RD5", "RD4", "RD3", "RD2", "RD1",
        "_NO", "_NO", "LE3", "LE4", "LE5", "LE6", "RE6", "RE5", "RE4", "RE3", "_NO", "_NO",
    };

    const expected = [SEGMENTS * ROWS][COLS]ElemType{
        .{ "LA1", "LA2", "LA3", "LA4", "LA5", "LA6" },
        .{ "LB1", "LB2", "LB3", "LB4", "LB5", "LB6" },
        .{ "LC1", "LC2", "LC3", "LC4", "LC5", "LC6" },
        .{ "LD1", "LD2", "LD3", "LD4", "LD5", "LD6" },
        .{ "_NO", "_NO", "LE3", "LE4", "LE5", "LE6" },

        .{ "RA1", "RA2", "RA3", "RA4", "RA5", "RA6" },
        .{ "RB1", "RB2", "RB3", "RB4", "RB5", "RB6" },
        .{ "RC1", "RC2", "RC3", "RC4", "RC5", "RC6" },
        .{ "RD1", "RD2", "RD3", "RD4", "RD5", "RD6" },
        .{ "_NO", "_NO", "RE3", "RE4", "RE5", "RE6" },
    };

    const actual = layout(
        ElemType,
        SEGMENTS,
        ROWS,
        COLS,
        true,
        src,
    );

    // std.debug.print(
    //     "src: {s}\nexpected: {s}\nactual: {s}\n\n",
    //     .{
    //         src,
    //         expected,
    //         actual,
    //     },
    // );

    try std.testing.expectEqual(expected, actual);
}
