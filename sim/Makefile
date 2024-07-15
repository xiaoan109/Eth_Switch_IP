
DUT=
PART=
SV_ENABLE=
SEED=
HOSTNAME    :=$(shell hostname)
REPO_ROOT	:=$(shell pwd)/..
SIM_DIR		:=$(REPO_ROOT)/sim
RTL_PATH	:=$(REPO_ROOT)/src/rtl
TB_PATH		:=$(REPO_ROOT)/src/tb
C_PATH		:=$(REPO_ROOT)/src/dpic
MODEL_PATH	:=$(REPO_ROOT)/src/model
DEFINE_PATH	:=$(REPO_ROOT)/src/define

RUN_DIR 	:= 	$(REPO_ROOT)/sim/run

DUMPWAVE 	:= 	1
DUMPMDA := 0
TESTNAME =
SIM_NOTIME	:= 	1
DPI_ENABLE	:= 	0

SIM_TOOL	:= 	vcs
WAV_TOOL	:=	verdi
FILELIST 	:= 	$(SIM_DIR)/filelist.f
DPIC_FILES	:=	$(wildcard $(C_PATH)/*.c $(C_PATH)/*.cpp)

ifeq ($(SIM_TOOL),vcs)
SIM_OPTION	:=	-j16 +v2k +vcs+loopdetect -q +race=all +lint=all,noSVA-NSVU,noVCDE,noUI,noSVA-CE,noSVA-DIU  -debug_access+all -full64 -timescale=1ns/10ps
ifneq ($(SV_ENABLE),)
SIM_OPTION	+=	-sverilog
SIM_OPTION  +=  -top tb_$(DUT)
endif

SIM_INC 	:=	+incdir+"$(DEFINE_PATH)"
SIM_VSRC	:= 	-f $(FILELIST)

ifeq ($(SIM_NOTIME),1)
SIM_OPTION	+=	+nospecify +notimingcheck  +delay_mode_zero
$(info "Info: Disable Timing Sim")
endif

ifeq ($(DPI_ENABLE),1)
SIM_CSRC	:= 	$(DPIC_FILES)
$(info "Info: Enable Dpi-C")
endif
endif

ifeq ($(SIM_TOOL),vcs)
ifeq ($(SEED),)
SIM_EXEC  	:= $(RUN_DIR)/simv +ntb_random_seed_automatic +fsdb+functions
else
SIM_EXEC  	:= $(RUN_DIR)/simv +ntb_random_seed=$(SEED) +fsdb+functions
endif
endif




ifeq ($(WAV_TOOL),verdi)
WAV_OPTIONS 	:= -nologo +v2k -sverilog
WAV_VSRC		:= -f $(FILELIST)
WAV_INC			:= +incdir+"$(DEFINE_PATH)"
WAV_FILE	 	:= -ssf $(RUN_DIR)/tb_$(DUT).fsdb
# WAV_FILE	 	:= -ssf `find $(RUN_DIR) -name "*.fsdb"`
endif

all: filelist compile run
	

filelist:
ifeq ($(DUT),)
	$(error "Error: DUT not Specified!")
else
	-rm -r $(SIM_DIR)/filelist.f
ifeq ($(PART),)
	$(warning "Warning: PART not Specified! Will use all part!")
	find $(RTL_PATH)/design -name "*.v" >> $(SIM_DIR)/filelist.f
ifneq ($(SV_ENABLE),)
	find $(RTL_PATH)/design -name "*.sv" >> $(SIM_DIR)/filelist.f
endif
else
  find $(RTL_PATH)/design/common -name "*.v" >> $(SIM_DIR)/filelist.f
	find $(RTL_PATH)/$(PART) -name "*.v" >> $(SIM_DIR)/filelist.f
ifneq ($(SV_ENABLE),)
 find $(RTL_PATH)/design/common -name "*.sv" >> $(SIM_DIR)/filelist.f
	find $(RTL_PATH)/$(PART) -name "*.sv" >> $(SIM_DIR)/filelist.f
endif
endif
	find $(TB_PATH) -name "tb_$(DUT).v" >> $(SIM_DIR)/filelist.f
	find $(MODEL_PATH) -name "*.v" >> $(SIM_DIR)/filelist.f
ifneq ($(SV_ENABLE),)
	find $(TB_PATH) -name "tb_$(DUT).sv" >> $(SIM_DIR)/filelist.f
	find $(MODEL_PATH) -name "*.sv" >> $(SIM_DIR)/filelist.f
endif
endif

compile.flg: $(FILELIST)
	-mkdir $(RUN_DIR)
	-rm -rf $(SIM_DIR)/compile.flg
ifneq ($(SV_ENABLE),)
	$(warning "Warning: Enable SystemVerilog!! Race Check will be disabled!!")
endif
	cd $(RUN_DIR); $(SIM_TOOL) $(SIM_OPTION) $(SIM_VSRC) $(SIM_INC) $(SIM_CSRC) |$ tee $(SIM_DIR)/$(DUT)_compile.log; cd $(SIM_DIR);
	touch $(SIM_DIR)/compile.flg

compile: compile.flg

run: compile
	cd $(RUN_DIR); $(SIM_EXEC) +DUMPWAVE=$(DUMPWAVE) +DUMPMDA=$(DUMPMDA) +TESTNAME=$(TESTNAME) +SIM_TOOL=$(SIM_TOOL) |$ tee $(SIM_DIR)/$(DUT)_run.log

wave:
	$(WAV_TOOL) $(WAV_OPTIONS) $(WAV_VSRC) $(WAV_INC) $(WAV_FILE) &

clean:
	cd $(SIM_DIR); find * | grep -v -e 'Makefile' -e '.*.sh' | xargs rm -r;



.PHONY: clean run wave compile filelist
