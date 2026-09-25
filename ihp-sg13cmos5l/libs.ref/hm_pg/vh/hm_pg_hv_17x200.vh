module hm_pg_lv_17x200 (
`ifdef USE_POWER_PINS
  inout VAPWR,
  inout VDPWR,
  inout GND,
  inout GPWR,
`endif
  input CTRL
);
endmodule
