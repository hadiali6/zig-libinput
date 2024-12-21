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

    extern fn libinput_device_get_seat(device: *Device) *Seat;
    pub const getSeat = libinput_device_get_seat;

    extern fn libinput_device_set_seat_logical_name(device: *Device, name: [*:0]const u8) c_int;
    pub fn setSeatLogicalName(device: *Device, name: [*:0]const u8) !void {
        return if (libinput_device_set_seat_logical_name(device, name) != 0)
            return error.SetDeviceSeatLogicalNameFailed;
    }

    // Device configuration

    pub const ConfigStatus = enum(c_int) {
        success = 0,
        unsupported,
        invalid,
        _,

        extern fn libinput_config_status_to_str(status: ConfigStatus) [*:0]u8;
        pub const toString = libinput_config_status_to_str;
    };

    pub const TapToClickState = enum(c_int) { disabled = 0, enabled, _ };

    pub const DragState = enum(c_int) { disabled = 0, enabled, _ };

    pub const DragLockState = enum(c_int) {
        disabled = 0,
        timeout = 1,
        sticky = 2,
        _,
    };

    pub const ConfigAreaRectangle = extern struct {
        x1: f64,
        x2: f64,
        y1: f64,
        y2: f64,
    };

    extern fn libinput_device_config_tap_get_finger_count(device: *Device) c_int;
    pub const getTapToClickFingerCount = libinput_device_config_tap_get_finger_count;

    extern fn libinput_device_config_tap_set_enabled(device: *Device, enable: TapToClickState) ConfigStatus;
    pub fn enableTapToClick(device: *Device, enabled: bool) ConfigStatus {
        return libinput_device_config_tap_set_enabled(device, if (enabled) .enabled else .disabled);
    }

    extern fn libinput_device_config_tap_get_enabled(device: *Device) TapToClickState;
    pub fn isTapToClickEnabled(device: *Device) bool {
        return switch (libinput_device_config_tap_get_enabled(device)) {
            .enabled => true,
            .disabled => false,
            _ => false,
        };
    }

    extern fn libinput_device_config_tap_get_default_enabled(device: *Device) TapToClickState;
    pub fn getDefaultTapToClickEnabled(device: *Device) bool {
        return libinput_device_config_tap_get_default_enabled(device) != .disabled;
    }

    extern fn libinput_device_config_tap_set_button_map(device: *Device, map: TapToClickButtonMap) ConfigStatus;
    pub const setTapToClickButtonMap = libinput_device_config_tap_set_button_map;

    extern fn libinput_device_config_tap_get_button_map(device: *Device) TapToClickButtonMap;
    pub const getTapToClickButtonMap = libinput_device_config_tap_get_button_map;

    extern fn libinput_device_config_tap_get_default_button_map(device: *Device) TapToClickButtonMap;
    pub const getDefaultTapToClickButtonMap = libinput_device_config_tap_get_button_map;

    extern fn libinput_device_config_tap_set_drag_enabled(device: *Device, enabled: DragState) ConfigStatus;
    pub fn enableTapToClickDrag(device: *Device, enabled: bool) ConfigStatus {
        return libinput_device_config_tap_set_drag_enabled(device, if (enabled) .enabled else .disabled);
    }

    extern fn libinput_device_config_tap_get_drag_enabled(device: *Device) DragState;
    pub const isTapToClickDragEnabled = libinput_device_config_tap_get_drag_enabled;

    extern fn libinput_device_config_tap_get_default_drag_enabled(device: *Device) DragState;
    pub const getDefaultTapToClickDragEnabled = libinput_device_config_tap_get_default_drag_enabled;

    extern fn libinput_device_config_tap_set_drag_lock_enabled(device: *Device, enabled: DragLockState) ConfigStatus;
    pub const setTapToClickDragLock = libinput_device_config_tap_set_drag_lock_enabled;

    extern fn libinput_device_config_tap_get_drag_lock_enabled(device: *Device) DragLockState;
    pub const getTapToClickDragLock = libinput_device_config_tap_get_drag_lock_enabled;

    extern fn libinput_device_config_tap_get_default_drag_lock_enabled(device: *Device) DragLockState;
    pub const getDefaultTapToClickDragLock = libinput_device_config_tap_get_default_drag_lock_enabled;

    extern fn libinput_device_config_calibration_has_matrix(device: *Device) c_int;
    pub fn hasCalibrationMatrix(device: *Device) bool {
        return libinput_device_config_calibration_has_matrix(device) != 0;
    }

    extern fn libinput_device_config_calibration_set_matrix(device: *Device, matrix: [*]const f32) ConfigStatus;
    pub fn setCalibrationMatrix(device: *Device, matrix: [6]f32) ConfigStatus {
        return libinput_device_config_calibration_set_matrix(device, @constCast((&matrix).ptr));
    }

    extern fn libinput_device_config_calibration_get_matrix(device: *Device, matrix: [*]f32) c_int;
    pub fn getCalibrationMatrix(device: *Device, matrix: [6]f32) bool {
        return libinput_device_config_calibration_get_matrix(device, @constCast((&matrix).ptr)) == 1;
    }

    extern fn libinput_device_config_calibration_get_default_matrix(device: *Device, matrix: [*]f32) c_int;
    pub fn getDefaultCalibrationMatrix(device: *Device, matrix: [6]f32) bool {
        return libinput_device_config_calibration_get_default_matrix(device, @constCast((&matrix).ptr)) == 1;
    }

    extern fn libinput_device_config_area_has_rectangle(device: *Device) c_int;
    pub fn hasAreaRectangle(device: *Device) bool {
        return libinput_device_config_area_has_rectangle(device) != 0;
    }

    extern fn libinput_device_config_area_set_rectangle(device: *Device, rect: *const ConfigAreaRectangle) ConfigStatus;
    pub const setAreaRectangle = libinput_device_config_area_set_rectangle;

    extern fn libinput_device_config_area_get_rectangle(device: *Device) ConfigAreaRectangle;
    pub const getAreaRectangle = libinput_device_config_area_get_rectangle;

    extern fn libinput_device_config_area_get_default_rectangle(device: *Device) ConfigAreaRectangle;
    pub const getDefaultAreaRectangle = libinput_device_config_area_get_default_rectangle;

    extern fn libinput_device_config_send_events_get_modes(device: *Device) SendEventsModeBitmask;
    pub const getSendEventsModes = libinput_device_config_send_events_get_modes;

    extern fn libinput_device_config_send_events_set_mode(device: *Device, mode: SendEventsModeBitmask) ConfigStatus;
    pub const setSendEventsMode = libinput_device_config_send_events_set_mode;

    extern fn libinput_device_config_send_events_get_mode(device: *Device) SendEventsModeBitmask;
    pub const getSendEventsMode = libinput_device_config_send_events_get_mode;

    extern fn libinput_device_config_send_events_get_default_mode(device: *Device) SendEventsModeBitmask;
    pub const getDefaultSendEventsMode = libinput_device_config_send_events_get_default_mode;

    extern fn libinput_device_config_accel_is_available(device: *Device) c_int;
    pub fn isAccelerationAvailable(device: *Device) bool {
        return libinput_device_config_accel_is_available(device) != 0;
    }

    extern fn libinput_device_config_accel_set_speed(device: *Device, speed: f64) ConfigStatus;
    pub const setAccelerationSpeed = libinput_device_config_area_has_rectangle;

    extern fn libinput_device_config_accel_get_speed(device: *Device) f64;
    pub const getAccelerationSpeed = libinput_device_config_accel_get_speed;

    extern fn libinput_device_config_accel_get_default_speed(device: *Device) f64;
    pub const getDefaultAccelerationSpeed = libinput_device_config_accel_get_default_speed;

    extern fn libinput_config_accel_create(profile: AccelerationProfile) ?*AccelerationConfig;
    pub fn createAccelerationConfig(profile: AccelerationProfile) !*AccelerationConfig {
        return libinput_config_accel_create(profile) orelse error.AccelerationConfigCreateFailed;
    }

    extern fn libinput_device_config_accel_apply(device: *Device, accel_config: *AccelerationConfig) ConfigStatus;
    pub const applyAccelerationConfig = libinput_device_config_accel_apply;

    extern fn libinput_device_config_accel_get_profiles(device: *Device) AccelerationProfileBitmask;
    pub const getAccelerationProfiles = libinput_device_config_accel_get_profiles;

    extern fn libinput_device_config_accel_set_profile(device: *Device, profile: AccelerationProfile) ConfigStatus;
    pub const setAccelerationProfile = libinput_device_config_accel_set_profile;

    extern fn libinput_device_config_accel_get_profile(device: *Device) AccelerationProfile;
    pub const getAccelerationProfile = libinput_device_config_accel_get_profile;

    extern fn libinput_device_config_accel_get_default_profile(device: *Device) AccelerationProfile;
    pub const getDefaultAccelerationProfile = libinput_device_config_accel_get_default_profile;

    extern fn libinput_device_config_scroll_has_natural_scroll(device: *Device) c_int;
    pub fn hasNaturalScroll(device: *Device) bool {
        return libinput_device_config_scroll_has_natural_scroll(device) != 0;
    }

    extern fn libinput_device_config_scroll_set_natural_scroll_enabled(device: *Device, enabled: c_int) ConfigStatus;
    pub fn enableNaturalScroll(device: *Device, enabled: bool) ConfigStatus {
        return libinput_device_config_scroll_set_natural_scroll_enabled(device, if (enabled) 1 else 0);
    }

    extern fn libinput_device_config_scroll_get_natural_scroll_enabled(device: *Device) c_int;
    pub fn isNaturalScrollEnabled(device: *Device) bool {
        return libinput_device_config_scroll_get_natural_scroll_enabled(device) != 0;
    }

    extern fn libinput_device_config_scroll_get_default_natural_scroll_enabled(device: *Device) c_int;
    pub fn getDefaultNaturalScrollEnabled(device: *Device) bool {
        return libinput_device_config_scroll_get_default_natural_scroll_enabled(device) != 0;
    }

    extern fn libinput_device_config_left_handed_is_available(device: *Device) c_int;
    pub fn isLeftHandedAvailable(device: *Device) bool {
        return libinput_device_config_left_handed_is_available(device) != 0;
    }

    extern fn libinput_device_config_left_handed_set(device: *Device, left_handed: c_int) ConfigStatus;
    pub fn enableLeftHanded(device: *Device, enabled: bool) ConfigStatus {
        return libinput_device_config_left_handed_set(device, if (enabled) 1 else 0);
    }

    extern fn libinput_device_config_left_handed_get(device: *Device) c_int;
    pub fn isLeftHanded(device: *Device) bool {
        return libinput_device_config_left_handed_get(device) != 0;
    }

    extern fn libinput_device_config_left_handed_get_default(device: *Device) c_int;
    pub fn getDefaultLeftHanded(device: *Device) bool {
        return libinput_device_config_left_handed_get_default(device) != 0;
    }

    // Groups

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

pub const SendEventsMode = enum(c_int) {
    enabled = 0,
    disabled = (1 << 0),
    disabled_on_external_mouse = (1 << 1),
    _,
};

pub const SendEventsModeBitmask = packed struct(u32) {
    disabled: bool,
    disabled_on_external_mouse: bool,
    _padding: u30,
};

pub const AccelerationProfile = enum(c_int) {
    none = 0,
    flat = 1 << 0,
    adaptive = 1 << 1,
    custom = 1 << 2,
    _,
};

pub const AccelerationProfileBitmask = packed struct(u32) {
    flat: bool,
    adaptive: bool,
    custom: bool,
    _padding: u29,
};

pub const AccelerationType = enum(c_int) {
    fallback = 0,
    motion,
    scroll,
};

pub const AccelerationConfig = opaque {
    extern fn libinput_config_accel_destroy(accel_config: *AccelerationConfig) void;
    pub const destroy = libinput_config_accel_destroy;

    extern fn libinput_config_accel_set_points(
        accel_config: *AccelerationConfig,
        accel_type: AccelerationType,
        step: f64,
        npoints: usize,
        points: *f64,
    ) Device.ConfigStatus;
    pub const setPoints = libinput_config_accel_set_points;
};

pub const ClickMethod = enum(c_int) {
    none = 0,
    button_areas = (1 << 0),
    clickfinger = (1 << 1),
    _,
};

pub const ClickMethodBitmask = packed struct(u32) {
    button_areas: bool,
    clickfinger: bool,
    _padding: u30,
};

pub const ScrollMethod = enum(c_int) {
    no_scroll = 0,
    @"2fg" = 1 << 0,
    edge = 1 << 1,
    on_button_down = 1 << 2,
    _,
};

pub const ScrollMethodBitmask = packed struct(u32) {
    @"2fg": bool,
    edge: bool,
    on_button_down: bool,
    _padding: u29,
};

pub const MiddleEmulationState = enum(c_int) { disabled = 0, enabled, _ };
pub const ScrollButtonLockState = enum(c_int) { disabled = 0, enabled, _ };
pub const DwtState = enum(c_int) { disabled = 0, enabled, _ };
pub const DwtpState = enum(c_int) { disabled = 0, enabled, _ };

pub const TapToClickButtonMap = enum(c_int) { left_right_middle = 0, left_middle_right, _ };
pub const ClickFingerButtonMap = enum(c_int) { left_right_middle = 0, left_middle_right, _ };

test {
    const std = @import("std");
    @setEvalBranchQuota(4000);
    std.testing.refAllDeclsRecursive(@This());
}
