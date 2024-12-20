pub const LibInput = opaque {};

pub const Device = opaque {
    pub const Capability = enum(c_int) {
        keyboard = 0,
        pointer = 1,
        touch = 2,
        tablet_tool = 3,
        tablet_pad = 4,
        gesture = 5,
        @"switch" = 6,
        _,
    };

    extern fn libinput_device_get_device_group(device: *Device) *DeviceGroup;
    pub const getDeviceGroup = libinput_device_get_device_group;
};

pub const DeviceGroup = opaque {};

pub const Seat = opaque {};

pub const TabletTool = opaque {};

pub const Event = opaque {
    pub const DeviceNotify = opaque {};
    pub const Keyboard = opaque {};
    pub const Pointer = opaque {};
    pub const Touch = opaque {};
    pub const TabletTool = opaque {};
    pub const TabletPad = opaque {};
};

pub const LogPriority = enum(c_int) {
    debug = 10,
    info = 20,
    @"error" = 30,
    _,
};

pub const KeyState = enum(c_int) {
    pressed,
    released,
    _,
};

pub const Led = enum(c_int) {
    num_lock = (1 << 0),
    caps_lock = (1 << 1),
    scroll_lock = (1 << 2),
    compose = (1 << 3),
    kana = (1 << 4),
    _,
};

pub const ButtonState = enum(c_int) {
    pressed,
    released,
    _,
};

pub const PointerAxis = enum(c_int) {
    scroll_vertical,
    scroll_horizontal,
    _,
};

pub const PointerAxisSource = enum(c_int) {
    wheel = 1,
    finger,
    continuous,
    wheel_tilt,
    _,
};

pub const TabletPadRingAxisSource = enum(c_int) {
    unkown = 1,
    finger,
    _,
};

pub const TabletPadStripAxisSource = enum(c_int) {
    unkown = 1,
    finger,
    _,
};

pub const TabletToolType = enum(c_int) {
    pen = 1,
    eraser,
    brush,
    pencil,
    airbrush,
    mouse,
    lens,
    totem,
    _,
};

pub const TabletToolProximityState = enum(c_int) {
    out,
    in,
    _,
};

pub const TabletToolTipState = enum(c_int) {
    up,
    down,
    _,
};

pub const TabletPadModeGroup = opaque {};

test {
    const std = @import("std");
    @setEvalBranchQuota(4000);
    std.testing.refAllDeclsRecursive(@This());
}
