# CrossbarSwitch_dim4

Arbitration algorithm - Round Robin (in src also can be found Wrapped WaveFront Arbiter - WWFA)

Dimension 4×4 (4  Master Devices and 4 Slave Devices)

### Target Device

Arty A7 (xc7a35ticsg324-1L)
### Top level for FPGA

stimulus_TOP_LEVEL.v (*stimulus_for_Crossbar4*)
### Simulation

Contains **two test modules** - non-Synthesizable (test_for_Crossbar.v -> *test*) file and Synthesizable (stimulus_TOP_LEVEL.v -> *stimulus_for_Crossbar4*). 
### Constraints and frequency

Contains **two constraints files**. File *crossbar_constraints_max_freq.xdc* restricts frequency for the Crossbar itself (the design of crossbar requires little space of FPGA, whats why the main delay goes to achieve the design)

### Arbitration Algorithms

Top-level for Round Robin - RoundRobin_Arbiter.v (*round_robin_module*)

Top-level for Wrapped WaveFront Arbiter - WWFA_top.v (*WF_main_module*)

For replacement Round Robin with WWFA (and vice versa) uncomment in file Crossbar.v (*main_module_of_Crossbar*) one of them: lines 156-157.
