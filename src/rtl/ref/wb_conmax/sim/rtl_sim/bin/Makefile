
all:	sim

SHELL = /bin/sh
MS=-s

##########################################################################
#
# DUT Sources
#
##########################################################################
DUT_SRC_DIR=../../../rtl/verilog
_TARGETS_=	$(DUT_SRC_DIR)/wb_conmax_top.v		\
		$(DUT_SRC_DIR)/wb_conmax_slave_if.v	\
		$(DUT_SRC_DIR)/wb_conmax_master_if.v	\
		$(DUT_SRC_DIR)/wb_conmax_msel.v		\
		$(DUT_SRC_DIR)/wb_conmax_arb.v		\
		$(DUT_SRC_DIR)/wb_conmax_pri_enc.v	\
		$(DUT_SRC_DIR)/wb_conmax_pri_dec.v	\
		$(DUT_SRC_DIR)/wb_conmax_rf.v


##########################################################################
#
# Test Bench Sources
#
##########################################################################
_TOP_=test
TB_SRC_DIR=../../../bench/verilog
_TB_=		$(TB_SRC_DIR)/test_bench_top.v		\
		$(TB_SRC_DIR)/wb_slv_model.v		\
		$(TB_SRC_DIR)/wb_mast_model.v

##########################################################################
#
# Misc Variables
#
##########################################################################

INCDIR=+incdir+./$(DUT_SRC_DIR)/ +incdir+./$(TB_SRC_DIR)/
LOGF=-l .nclog
UMC_LIB=/tools/dc_libraries/virtual_silicon/umc_lib.v
GATE_NETLIST = ../../../syn/out/wb_dma_top_ps.v

##########################################################################
#
# Make Targets
#
##########################################################################

ss:
	signalscan -do waves/waves.do -waves waves/waves.trn &

simxl:
	verilog +incdir+$(DUT_SRC_DIR) +incdir+$(TB_SRC_DIR)	\
	$(_TARGETS_) $(_TB_)

simw:
	@$(MAKE) -s sim ACCESS="+access+r " WAVES="+define+WAVES"


sim:
	ncverilog -q +define+RUDIS_TB $(_TARGETS_) $(_TB_)      \
                $(INCDIR) $(WAVES) $(ACCESS) $(LOGF) +ncstatus  \
                +ncuid+`hostname`

gatew:
	@$(MAKE) -s gate ACCESS="+access+r" WAVES="+define+WAVES"

gate:
	ncverilog -q +define+RUDIS_TB $(_TB_) $(UMC_LIB)        \
		$(GATE_NETLIST) $(INCDIR) $(WAVES) $(ACCESS)    \
		$(LOGF) +ncstatus +ncuid+`hostname`

hal:
	@echo ""
	@echo "----- Running HAL ... ----------"
	@hal	-NOP -NOS -nocheck STYVAL:USEPRT:NOBLKN:DLNBLK	\
		+incdir+$(DUT_SRC_DIR) $(_TARGETS_)
	@echo "----- DONE ... ----------"
 
vcs:
	 bsub -I vcs -j16 +v2k +vcs+loopdetect -q +race=all +lint=all,noSVA-NSVU,noVCDE,noUI,noSVA-CE,noSVA-DIU \
	 						 -debug_access+all -debug_region=cell+lib -full64 -timescale=1ns/10ps \
							 +nospecify +notimingcheck  +delay_mode_zero $(_TARGETS_) $(_TB_) $(INCDIR)  |$ tee vcs_compile.log

simv: vcs
	bsub -I ./simv +ntb_random_seed_automatic +fsdb+functions |$ tee vcs_run.log

verdi:
	bsub -I verdi $(_TARGETS_) $(_TB_) $(INCDIR) -ssf test.fsdb &

clean:
	rm -rf	./waves/*.dsn ./waves/*.trn		\
		ncwork/inc* ncwork/.inc* 		\
		./verilog.* .nclog hal.log \
		INCA_libs .nclog.history \
		csrc race.out.static simv.daidir simv ucli.key vcs_compile.log vcs_run.log \
		*.fsdb novas.conf novas.rc novas_dump.log verdiLog

##########################################################################

