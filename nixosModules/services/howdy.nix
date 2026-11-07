{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.howdy.enable = true;
  services.howdy.control = "sufficient";
  services.linux-enable-ir-emitter.enable = true;
  services.howdy.settings = {
    core = {
      abort_if_lid_closed = true;
      abort_if_ssh = true;
      detection_notice = false;
      disabled = false;
      no_confirmation = false;
      suppress_unknown = false;
      timeout_notice = true;
      use_cnn = false;
      workaround = "off";
    };
    debug = {
      end_report = false;
      gtk_stdout = false;
      verbose_stamps = false;
    };
    rubberstamps = {
      enabled = false;
      stamp_rules = "nod		5s		failsafe     min_distance=12";
    };
    snapshots = {
      save_failed = true;
      save_successful = false;
    };
    video = {
      certainty = 3.5;
      dark_threshold = 60;
      device_format = "v4l2";
      device_fps = -1;
      exposure = -1;
      force_mjpeg = false;
      frame_height = -1;
      frame_width = -1;
      max_height = 320;
      recording_plugin = "opencv";
      rotate = 0;
      timeout = 4;
      warn_no_device = true;
    };
  };
}
