gds read ../../../libs.ref/hm_io/gds/hm_IOPadInOut30mA_OpenDrain_PUPD
load hm_IOPadInOut30mA_OpenDrain_PUPD
select top cell
lef write ../../../libs.ref/hm_io/lef/hm_IOPadInOut30mA_OpenDrain_PUPD.lef -pinonly -hide -toplayer
quit -noprompt
