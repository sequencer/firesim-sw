PLATFORM ?= xilinx_vcu118

out/build/FireSim-generated.const.h: ../playground/rtl/FireSim-generated.const.h
	mkdir -p out/build
	cp $^ $@

out/FireSim-$(PLATFORM): out/build/FireSim-generated.const.h
	make -C sim/midas/src/main/cc driver MAIN=$(PLATFORM) PLATFORM=$(PLATFORM) \
		CXXFLAGS="-I$(PWD)/sim/firesim-lib/src/main/cc" \
		LDFLAGS="-ldwarf -lelf" \
		DRIVER_NAME=FireSim \
		GEN_FILE_BASENAME=FireSim-generated \
		GEN_DIR=$(PWD)/out/build \
		OUT_DIR=$(PWD)/out \
		DRIVER="$(PWD)/sim/src/main/cc/firesim/firesim_top.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/blockdev.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/dromajo.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/groundtest.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/simplenic.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/tracerv.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/tsibridge.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/uart.cc $(PWD)/sim/firesim-lib/src/main/cc/fesvr/firesim_tsi.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/tracerv/tracerv_dwarf.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/tracerv/tracerv_elf.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/tracerv/tracerv_processing.cc $(PWD)/sim/firesim-lib/src/main/cc/bridges/tracerv/trace_tracker.cc $(SPIKE_PATH)/lib/libfesvr.a $(DROMAJO_PATH)/lib/libdromajo_cosim.a $(TESTCHIPIP_PATH)/include/testchip_tsi.cc"

clean:
	rm -rf out
