<!--
 * @FilePath       : /HdlRepoTemplate/README.md
 * @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 * @CreateDate     : 23-10-27
 * @LastEditors    : ZhouZiheng ziheng.zhou.1999@qq.com
 * @LastEditTime   : 23-10-27
 * Version        :
 * @Description    : 
 *                  
 * 
 * Parameter       :
 *                  
 * 
 * IO Port         :
 *                  
 * 
 * Modification History
 *    Date   |   Author   |   Version   |   Change Description
 * ==============================================================================
 *  23-10-27 | zhouziheng |     1.0     | Original Version
 *                  
 * 
-->

Verilog Project Template
========================

Contents at a glance:
* `.gitignore` - helps Git ignore junk like generated files, build products, and temporary files.
* `sim/Makefile` - rules to call vcs (*may support other simulator in later version*)
* `src/define/define.v` - Verilog Global Define File
* `src/dpic/template/TemplateAdderModel.c` - C/Cpp file for DPI-C
* `src/rtl/template/TemplateAdder.v` - Verilog Source File
* `src/tb/template/tb_TemplateAdder.v` - Verilog Testbench File

***Feel free to rename or delete files under `src/` or use them as a reference/template.***

## Start Simulation
To run simulation for a specified DUT (`TemplateAdder` for example)
```bash
cd sim
make DUT=TemplateAdder
```
You can find waveform and log file here  
* `sim/run/tb_TemplateAdder.fsdb`  
* `sim/run/TemplateAdder.log`

To Check Waveform
```bash
cd sim
make wave
```

To Remove Sim generated files
```bash
cd sim
make clean
```
