module hm_pg_lv_17x200 (
`ifdef USE_POWER_PINS
  inout VPWR,
  inout GND,
  inout GPWR,
`endif
  input CTRL
);
endmodule
