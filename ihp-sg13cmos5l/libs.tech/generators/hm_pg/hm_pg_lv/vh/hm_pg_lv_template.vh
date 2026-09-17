module hm_pg_lv_{{WIDTH}}x{{HEIGHT}} (
`ifdef USE_POWER_PINS
  inout VPWR,
  inout GND,
  inout GPWR,
`endif
  input CTRL
);
endmodule
