
//*******************************************************************************************************
//**                                         Verilog Model                                             **
//**                                                                                                   **
//**                                      ALL RIGHTS RESERVED                                          **
//*******************************************************************************************************
`timescale 1ns/1ps
`celldefine
//*******************************************************************************************************
//XMC55_DPS:v1.0
//
//Instance Name:  dpram16x4096
//Word Depth:     4096
//Word Width:     16
//ColMux:         8
//Bit Write:      on
//Test Mode:      off
//Created Data:   3-29-2024 10:29
//*******************************************************************************************************
//If POWER_PINS is defined, it selects the module w/ power & ground ports
`ifdef POWER_PINS 
module dpram16x4096 ( QA, QB, CLKA, CLKB, CENA, CENB, WENA, WENB, 
			  BWENA, BWENB, 
			  VDD, VSS, 
			  AA, AB, DA, DB); 
`else 
module dpram16x4096 ( QA, QB, CLKA, CLKB, CENA, CENB, WENA, WENB, 
			  BWENA, BWENB, 
			  AA, AB, DA, DB); 
`endif 
 
parameter     Bits = 16; 
parameter     Word_Depth = 4096; 
parameter     Add_Width = 12; 
parameter     Wen_Width = 16; 
parameter     Word_Pt = 1; 
parameter     TM_Width = 10; 
 
`ifdef POWER_PINS 
inout		      VDD;
inout		      VSS;
`endif 
input [Wen_Width-1:0]  BWENA;
input [Wen_Width-1:0]  BWENB;

output [Bits-1:0]     QA;
output [Bits-1:0]     QB;
input		      CLKA;
input		      CLKB;
input		      CENA;
input		      CENB;
input		      WENA;
input		      WENB;

input [Add_Width-1:0] AA;
input [Add_Width-1:0] AB;
input [Bits-1:0]      DA;
input [Bits-1:0]      DB;

//reg [Bits-1:0]        QA;
//reg [Bits-1:0]        QB;
reg [Bits-1:0]        QA_int;
reg [Bits-1:0]        QB_int;
reg [Bits-1:0]        QA_buf;
reg [Bits-1:0]        QB_buf;

reg [Bits-1:0]        mem_array[Word_Depth-1:0];

wire [Add_Width-1:0]  AA_int;
wire [Add_Width-1:0]  AB_int;
wire		      CLKA_int;
wire		      CLKB_int;
wire		      CENA_int;
wire		      CENB_int;
wire		      WENA_int;
wire		      WENB_int;
wire [Wen_Width-1:0]  BWENA_int;
wire [Wen_Width-1:0]  BWENB_int;
wire [Bits-1:0]       DA_int;
wire [Bits-1:0]       DB_int;

reg  [Bits-1:0]       QA_latched;
reg  [Bits-1:0]       QB_latched;
reg  [Add_Width-1:0]  AA_latched;
reg  [Add_Width-1:0]  AB_latched;
reg  [Bits-1:0]       DA_latched;
reg  [Bits-1:0]       DB_latched;
reg		      CENA_latched;
reg		      CENB_latched;
reg		      LAST_CLKA;
reg		      LAST_CLKB;
reg		      WENA_latched;
reg		      WENB_latched;
reg [Wen_Width-1:0]   BWENA_latched;
reg [Wen_Width-1:0]   BWENB_latched;
reg		      CENA_flag;
reg		      CENB_flag;
reg		      CLKA_CYC_flag;
reg		      CLKB_CYC_flag;
reg		      CLKA_H_flag;
reg		      CLKB_H_flag;
reg		      CLKA_L_flag;
reg		      CLKB_L_flag;
reg                   WENA_flag; 
reg                   WENB_flag; 
reg [Wen_Width-1:0]   BWENA_flag;
reg [Wen_Width-1:0]   BWENB_flag;
reg                   VIOA_flag;
reg                   VIOB_flag;
reg                   LAST_VIOA_flag;
reg                   LAST_VIOB_flag;
reg [Add_Width-1:0]   AA_flag;
reg [Add_Width-1:0]   AB_flag;
reg [Bits-1:0]        DA_flag;
reg [Bits-1:0]        DB_flag;

reg		      LAST_CENA_flag;
reg		      LAST_CENB_flag;
reg		      LAST_WENA_flag;
reg		      LAST_WENB_flag;
reg [Wen_Width-1:0]   LAST_BWENA_flag;
reg [Wen_Width-1:0]   LAST_BWENB_flag;
reg [Add_Width-1:0]   LAST_AA_flag;
reg [Add_Width-1:0]   LAST_AB_flag;
reg [Bits-1:0]        LAST_DA_flag;
reg [Bits-1:0]        LAST_DB_flag;
reg		      LAST_CLKA_CYC_flag;
reg		      LAST_CLKB_CYC_flag;
reg		      LAST_CLKA_H_flag;
reg		      LAST_CLKB_H_flag;
reg		      LAST_CLKA_L_flag;
reg		      LAST_CLKB_L_flag;
reg [Bits-1:0]        data_tmpa;
reg [Bits-1:0]        data_tmpb;

wire		      CEA_flag;
wire		      CEB_flag;
wire		      clkconfA_flag;
wire		      clkconfB_flag;
wire		      clkconf_flag;
 
reg		      AA0_flag; 
reg		      AB0_flag; 
reg		      AA1_flag; 
reg		      AB1_flag; 
reg		      AA2_flag; 
reg		      AB2_flag; 
reg		      AA3_flag; 
reg		      AB3_flag; 
reg		      AA4_flag; 
reg		      AB4_flag; 
reg		      AA5_flag; 
reg		      AB5_flag; 
reg		      AA6_flag; 
reg		      AB6_flag; 
reg		      AA7_flag; 
reg		      AB7_flag; 
reg		      AA8_flag; 
reg		      AB8_flag; 
reg		      AA9_flag; 
reg		      AB9_flag; 
reg		      AA10_flag; 
reg		      AB10_flag; 
reg		      AA11_flag; 
reg		      AB11_flag; 
reg		      DA0_flag; 
reg		      DB0_flag; 
reg		      BWENA0_flag; 
reg		      BWENB0_flag; 
wire		      WRA0_flag; 
wire		      WRB0_flag; 
assign WRA0_flag=(!CENA_int && !WENA_int && !BWENA_int[0]); 
assign WRB0_flag=(!CENB_int && !WENB_int && !BWENB_int[0]); 
reg		      DA1_flag; 
reg		      DB1_flag; 
reg		      BWENA1_flag; 
reg		      BWENB1_flag; 
wire		      WRA1_flag; 
wire		      WRB1_flag; 
assign WRA1_flag=(!CENA_int && !WENA_int && !BWENA_int[1]); 
assign WRB1_flag=(!CENB_int && !WENB_int && !BWENB_int[1]); 
reg		      DA2_flag; 
reg		      DB2_flag; 
reg		      BWENA2_flag; 
reg		      BWENB2_flag; 
wire		      WRA2_flag; 
wire		      WRB2_flag; 
assign WRA2_flag=(!CENA_int && !WENA_int && !BWENA_int[2]); 
assign WRB2_flag=(!CENB_int && !WENB_int && !BWENB_int[2]); 
reg		      DA3_flag; 
reg		      DB3_flag; 
reg		      BWENA3_flag; 
reg		      BWENB3_flag; 
wire		      WRA3_flag; 
wire		      WRB3_flag; 
assign WRA3_flag=(!CENA_int && !WENA_int && !BWENA_int[3]); 
assign WRB3_flag=(!CENB_int && !WENB_int && !BWENB_int[3]); 
reg		      DA4_flag; 
reg		      DB4_flag; 
reg		      BWENA4_flag; 
reg		      BWENB4_flag; 
wire		      WRA4_flag; 
wire		      WRB4_flag; 
assign WRA4_flag=(!CENA_int && !WENA_int && !BWENA_int[4]); 
assign WRB4_flag=(!CENB_int && !WENB_int && !BWENB_int[4]); 
reg		      DA5_flag; 
reg		      DB5_flag; 
reg		      BWENA5_flag; 
reg		      BWENB5_flag; 
wire		      WRA5_flag; 
wire		      WRB5_flag; 
assign WRA5_flag=(!CENA_int && !WENA_int && !BWENA_int[5]); 
assign WRB5_flag=(!CENB_int && !WENB_int && !BWENB_int[5]); 
reg		      DA6_flag; 
reg		      DB6_flag; 
reg		      BWENA6_flag; 
reg		      BWENB6_flag; 
wire		      WRA6_flag; 
wire		      WRB6_flag; 
assign WRA6_flag=(!CENA_int && !WENA_int && !BWENA_int[6]); 
assign WRB6_flag=(!CENB_int && !WENB_int && !BWENB_int[6]); 
reg		      DA7_flag; 
reg		      DB7_flag; 
reg		      BWENA7_flag; 
reg		      BWENB7_flag; 
wire		      WRA7_flag; 
wire		      WRB7_flag; 
assign WRA7_flag=(!CENA_int && !WENA_int && !BWENA_int[7]); 
assign WRB7_flag=(!CENB_int && !WENB_int && !BWENB_int[7]); 
reg		      DA8_flag; 
reg		      DB8_flag; 
reg		      BWENA8_flag; 
reg		      BWENB8_flag; 
wire		      WRA8_flag; 
wire		      WRB8_flag; 
assign WRA8_flag=(!CENA_int && !WENA_int && !BWENA_int[8]); 
assign WRB8_flag=(!CENB_int && !WENB_int && !BWENB_int[8]); 
reg		      DA9_flag; 
reg		      DB9_flag; 
reg		      BWENA9_flag; 
reg		      BWENB9_flag; 
wire		      WRA9_flag; 
wire		      WRB9_flag; 
assign WRA9_flag=(!CENA_int && !WENA_int && !BWENA_int[9]); 
assign WRB9_flag=(!CENB_int && !WENB_int && !BWENB_int[9]); 
reg		      DA10_flag; 
reg		      DB10_flag; 
reg		      BWENA10_flag; 
reg		      BWENB10_flag; 
wire		      WRA10_flag; 
wire		      WRB10_flag; 
assign WRA10_flag=(!CENA_int && !WENA_int && !BWENA_int[10]); 
assign WRB10_flag=(!CENB_int && !WENB_int && !BWENB_int[10]); 
reg		      DA11_flag; 
reg		      DB11_flag; 
reg		      BWENA11_flag; 
reg		      BWENB11_flag; 
wire		      WRA11_flag; 
wire		      WRB11_flag; 
assign WRA11_flag=(!CENA_int && !WENA_int && !BWENA_int[11]); 
assign WRB11_flag=(!CENB_int && !WENB_int && !BWENB_int[11]); 
reg		      DA12_flag; 
reg		      DB12_flag; 
reg		      BWENA12_flag; 
reg		      BWENB12_flag; 
wire		      WRA12_flag; 
wire		      WRB12_flag; 
assign WRA12_flag=(!CENA_int && !WENA_int && !BWENA_int[12]); 
assign WRB12_flag=(!CENB_int && !WENB_int && !BWENB_int[12]); 
reg		      DA13_flag; 
reg		      DB13_flag; 
reg		      BWENA13_flag; 
reg		      BWENB13_flag; 
wire		      WRA13_flag; 
wire		      WRB13_flag; 
assign WRA13_flag=(!CENA_int && !WENA_int && !BWENA_int[13]); 
assign WRB13_flag=(!CENB_int && !WENB_int && !BWENB_int[13]); 
reg		      DA14_flag; 
reg		      DB14_flag; 
reg		      BWENA14_flag; 
reg		      BWENB14_flag; 
wire		      WRA14_flag; 
wire		      WRB14_flag; 
assign WRA14_flag=(!CENA_int && !WENA_int && !BWENA_int[14]); 
assign WRB14_flag=(!CENB_int && !WENB_int && !BWENB_int[14]); 
reg		      DA15_flag; 
reg		      DB15_flag; 
reg		      BWENA15_flag; 
reg		      BWENB15_flag; 
wire		      WRA15_flag; 
wire		      WRB15_flag; 
assign WRA15_flag=(!CENA_int && !WENA_int && !BWENA_int[15]); 
assign WRB15_flag=(!CENB_int && !WENB_int && !BWENB_int[15]); 
 
buf bwena_buf[Wen_Width-1:0] (BWENA_int, BWENA);
buf bwenb_buf[Wen_Width-1:0] (BWENB_int, BWENB);

integer      i,j,wenn,lb,hb;
integer      n;

buf qa_buf[Bits-1:0] (QA, QA_buf);
buf qb_buf[Bits-1:0] (QB, QB_buf);
buf (CLKA_int, CLKA);
buf (CLKB_int, CLKB);
buf (CENA_int, CENA);
buf (CENB_int, CENB);
buf (WENA_int, WENA);
buf (WENB_int, WENB);


buf aa_buf[Add_Width-1:0] (AA_int, AA);
buf ab_buf[Add_Width-1:0] (AB_int, AB);
buf da_buf[Bits-1:0] (DA_int, DA);   
buf db_buf[Bits-1:0] (DB_int, DB);   

//assign QA_int= QA_latched;
//assign QB_int= QB_latched;
assign CEA_flag=!CENA_int;
assign CEB_flag=!CENB_int;

wire wa_rb; 
wire wb_ra; 
wire wa_wb; 
reg wa_rb_happen = 1'b0;
reg wb_ra_happen = 1'b0;
reg wa_wb_happen = 1'b0;
reg wa_rb_happen_d;
reg wb_ra_happen_d;
reg wa_wb_happen_d;
wire [1:0] wa_rb_happen_st;
wire [1:0] wb_ra_happen_st;
wire [1:0] wa_wb_happen_st;

assign wa_rb = ( (!CENA) && (!WENA) && (!CENB) && WENB && (AA == AB)) ? 1'b1: 1'b0;
assign wb_ra = ( (!CENA) && (WENA) && (!CENB) && (!WENB) && (AA == AB)) ? 1'b1: 1'b0;
assign wa_wb = ( (!CENA) && (!WENA) && (!CENB) && (!WENB) && (AA == AB)) ? 1'b1: 1'b0;

always @ (posedge CLKA_int)
begin
    wa_rb_happen_d = wa_rb_happen;
    wb_ra_happen_d = wb_ra_happen;
    wa_wb_happen_d = wa_wb_happen;
end

assign wa_rb_happen_st = {wa_rb_happen_d,wa_rb_happen};
assign wb_ra_happen_st = {wb_ra_happen_d,wb_ra_happen};
assign wa_wb_happen_st = {wa_wb_happen_d,wa_wb_happen};

// for WB_RA happen, QA output
always @ (wb_ra_happen or QA_latched)
begin
    if ((wb_ra_happen_st == 2'b01) || (wb_ra_happen_st == 2'b10))
        QA_int = data_tmpb;  // when happen, read failed, QA output data_B, which will be writen in this address now
    else
        QA_int= QA_latched;
end

// for WA_RB happen, QB output    
always @ (wa_rb_happen or QB_latched)
begin
    if ((wa_rb_happen_st == 2'b01) || (wa_rb_happen_st == 2'b10))
        QB_int = data_tmpa;
    else
        QB_int= QB_latched;
end



always @(CLKA_int)
begin
    casez({LAST_CLKA, CLKA_int})
    2'b01: begin
        CENA_latched = CENA_int;
        WENA_latched = WENA_int;
        BWENA_latched = BWENA_int;
        AA_latched = AA_int;
        DA_latched = DA_int;
        rw_memA;
        end
    2'b10,
    2'bx?,
    2'b00,
    2'b11: ;
    2'b?x: begin
        for(i=0;i<Word_Depth;i=i+1)
        mem_array[i]={Bits{1'bx}};
        QA_latched={Bits{1'bx}};
        rw_memA;
        end
    endcase
    LAST_CLKA=CLKA_int;
end

always @(CLKB_int)
begin
    casez({LAST_CLKB, CLKB_int})
    2'b01: begin
        CENB_latched = CENB_int;
        WENB_latched = WENB_int;
        BWENB_latched = BWENB_int;
        AB_latched = AB_int;
        DB_latched = DB_int;
        rw_memB;
        end
    2'b10,
    2'bx?,
    2'b00,
    2'b11: ;
    2'b?x: begin
        for(i=0;i<Word_Depth;i=i+1)
        mem_array[i]={Bits{1'bx}};
        QB_latched={Bits{1'bx}};
        rw_memB;
        end
    endcase
    LAST_CLKB=CLKB_int;
end
 
`ifdef POWER_PINS 
always@(VDD, VSS, QA_int) 
begin  
    if (VDD === 1'bx || VDD === 1'bz) 
    begin 
        $display("Warning: Unknown value for VDD %b in %m at %0t", VDD, $time); 
        QA_buf = {Bits{1'bx}}; 
    end 
    else if (VSS === 1'bx || VSS === 1'bz) 
    begin 
        $display("Warning: Unknown value for VSS %b in %m at %0t", VSS, $time); 
        QA_buf = {Bits{1'bx}}; 
    end 
    else 
        QA_buf = QA_int; 
end 
`else 
always@(QA_int) 
begin  
    QA_buf = QA_int; 
end 
`endif 
 
`ifdef POWER_PINS 
always@(VDD, VSS, QB_int) 
begin  
    if (VDD === 1'bx || VDD === 1'bz) 
    begin 
        $display("Warning: Unknown value for VDD %b in %m at %0t", VDD, $time); 
        QB_buf = {Bits{1'bx}}; 
    end 
    else if (VSS === 1'bx || VSS === 1'bz) 
    begin 
        $display("Warning: Unknown value for VSS %b in %m at %0t", VSS, $time); 
        QB_buf = {Bits{1'bx}}; 
    end 
    else 
        QB_buf = QB_int; 
end 
`else 
always@(QB_int) 
begin  
    QB_buf = QB_int; 
end 
`endif 
 
always @(  CENA_flag  or WENA_flag 
        or BWENA0_flag 
        or DA0_flag 
        or BWENA1_flag 
        or DA1_flag 
        or BWENA2_flag 
        or DA2_flag 
        or BWENA3_flag 
        or DA3_flag 
        or BWENA4_flag 
        or DA4_flag 
        or BWENA5_flag 
        or DA5_flag 
        or BWENA6_flag 
        or DA6_flag 
        or BWENA7_flag 
        or DA7_flag 
        or BWENA8_flag 
        or DA8_flag 
        or BWENA9_flag 
        or DA9_flag 
        or BWENA10_flag 
        or DA10_flag 
        or BWENA11_flag 
        or DA11_flag 
        or BWENA12_flag 
        or DA12_flag 
        or BWENA13_flag 
        or DA13_flag 
        or BWENA14_flag 
        or DA14_flag 
        or BWENA15_flag 
        or DA15_flag 
        or AA0_flag 
        or AA1_flag 
        or AA2_flag 
        or AA3_flag 
        or AA4_flag 
        or AA5_flag 
        or AA6_flag 
        or AA7_flag 
        or AA8_flag 
        or AA9_flag 
        or AA10_flag 
        or AA11_flag 
        or CLKA_H_flag   or CLKA_L_flag 
        or CLKA_CYC_flag or VIOA_flag) 

begin
    update_flag_busA;
    CENA_latched = (CENA_flag!==LAST_CENA_flag) ? 1'bx : CENA_latched ;
    WENA_latched = (WENA_flag!==LAST_WENA_flag) ? 1'bx : WENA_latched ;
    for (n=0; n<Wen_Width; n=n+1)
        BWENA_latched[n] = (BWENA_flag[n]!==LAST_BWENA_flag[n]) ? 1'bx : BWENA_latched[n] ;
    for (n=0; n<Add_Width; n=n+1)
        AA_latched[n] = (AA_flag[n]!==LAST_AA_flag[n]) ? 1'bx : AA_latched[n] ;
    for (n=0; n<Bits; n=n+1)
        DA_latched[n] = (DA_flag[n]!==LAST_DA_flag[n]) ? 1'bx : DA_latched[n] ;
    LAST_CENA_flag = CENA_flag;
    LAST_WENA_flag = WENA_flag;
    LAST_BWENA_flag = BWENA_flag;
    LAST_AA_flag = AA_flag;
    LAST_DA_flag = DA_flag;
    LAST_CLKA_CYC_flag = CLKA_CYC_flag;
    LAST_CLKA_H_flag = CLKA_H_flag;
    LAST_CLKA_L_flag = CLKA_L_flag;
    if(VIOA_flag!==LAST_VIOA_flag)
    begin
        if(WENB_latched===1'b1)
            QB_latched={Bits{1'bx}};
        else
        begin
            if(WENA_latched===1'b1)
                QA_latched={Bits{1'bx}};
            else
            begin
                if(^(AA_latched)===1'bx)
                    for(i=0;i<Word_Depth;i=i+1)
                        mem_array[i]={Bits{1'bx}};
                else
                    mem_array[AA_latched]={Bits{1'bx}};
            end
        end
        LAST_VIOA_flag=VIOA_flag;
    end
    else
        rw_memA;
end

task rw_memA;
begin
    if(CENA_latched==1'b0)
    begin
        if (WENA_latched==1'b1)
        begin
            if(^(AA_latched)==1'bx)
            QA_latched={Bits{1'bx}};
            else
            QA_latched=mem_array[AA_latched];
        end
        else if (WENA_latched==1'b0)
        begin
        for (wenn=0; wenn<Wen_Width; wenn=wenn+1)
            begin
            lb=wenn*Word_Pt;
            if ( (lb+Word_Pt) >= Bits) hb=Bits-1;
            else hb=lb+Word_Pt-1;
            if (BWENA_latched[wenn]==1'b1)
                begin
                if(^(AA_latched)==1'bx)
                    for (i=lb; i<=hb; i=i+1) QA_latched[i]=1'bx;
                else
                    begin
                    data_tmpa=mem_array[AA_latched];
                    for (i=lb; i<=hb; i=i+1) QA_latched[i]=data_tmpa[i];
                    end
                end
            else if (BWENA_latched[wenn]==1'b0)
                begin
                if (^(AA_latched)==1'bx)
                    begin
                    for (i=0; i<Word_Depth; i=i+1)
                        begin
                        data_tmpa=mem_array[i];
                        for (j=lb; j<=hb; j=j+1) data_tmpa[j]=1'bx;
                        mem_array[i]=data_tmpa;
                        end
                    for (i=lb; i<=hb; i=i+1) QA_latched[i]=1'bx;
                    end
                else
                    begin
                    data_tmpa=mem_array[AA_latched];
                    for (i=lb; i<=hb; i=i+1) data_tmpa[i]=DA_latched[i];
                    mem_array[AA_latched]=data_tmpa;
                    for (i=lb; i<=hb; i=i+1) QA_latched[i]=data_tmpa[i];
                    end
                end
            else
                begin
                for (i=lb; i<=hb;i=i+1) QA_latched[i]=1'bx;
                if (^(AA_latched)==1'bx)
                    begin
                    for (i=0; i<Word_Depth; i=i+1)
                        begin
                        data_tmpa=mem_array[i];
                        for (j=lb; j<=hb; j=j+1) data_tmpa[j]=1'bx;
                        mem_array[i]=data_tmpa;
                        end
                    end
                else
                    begin
                    data_tmpa=mem_array[AA_latched];
                    for (i=lb; i<=hb; i=i+1) data_tmpa[i]=1'bx;
                    mem_array[AA_latched]=data_tmpa;
                    end
                end
            end
            end
        else
            begin
            for (wenn=0; wenn<Wen_Width; wenn=wenn+1)
            begin
                lb=wenn*Word_Pt;
                if ( (lb+Word_Pt) >= Bits) hb=Bits-1;
                else hb=lb+Word_Pt-1;
                if (BWENA_latched[wenn]==1'b1)
                begin
                if(^(AA_latched)==1'bx)
                    for (i=lb; i<=hb; i=i+1) QA_latched[i]=1'bx;
                else
                    begin
                    data_tmpa=mem_array[AA_latched];
                    for (i=lb; i<=hb; i=i+1) QA_latched[i]=data_tmpa[i];
                    end
                end
            else
                begin
                for (i=lb; i<=hb;i=i+1) QA_latched[i]=1'bx;
                if (^(AA_latched)==1'bx)
                    begin
                    for (i=0; i<Word_Depth; i=i+1)
                        begin
                        data_tmpa=mem_array[i];
                        for (j=lb; j<=hb; j=j+1) data_tmpa[j]=1'bx;
                        mem_array[i]=data_tmpa;
                        end
                    end
                else
                    begin
                    data_tmpa=mem_array[AA_latched];
                    for (i=lb; i<=hb; i=i+1) data_tmpa[i]=1'bx;
                    mem_array[AA_latched]=data_tmpa;
                    end
                end
            end
            end
        end
        else if (CENA_latched==1'bx)
        begin
            for (wenn=0;wenn<Wen_Width;wenn=wenn+1)
        begin
            lb=wenn*Word_Pt;
            if ((lb+Word_Pt)>=Bits) hb=Bits-1;
            else hb=lb+Word_Pt-1;
            if(WENA_latched==1'b1 || BWENA_latched[wenn]==1'b1)
            for (i=lb;i<=hb;i=i+1) QA_latched[i]=1'bx;
            else
            begin
                for (i=lb;i<=hb;i=i+1) QA_latched[i]=1'bx;
                if(^(AA_latched)==1'bx)
                begin
                    for (i=0;i<Word_Depth;i=i+1)
                    begin
                        data_tmpa=mem_array[i];
                        for (j=lb;j<=hb;j=j+1) data_tmpa[j]=1'bx;
                        mem_array[i]=data_tmpa;
                    end
                end
                else
                begin
                    data_tmpa=mem_array[AA_latched];
                    for (i=lb;i<=hb;i=i+1) data_tmpa[i]=1'bx;
                    mem_array[AA_latched]=data_tmpa;
                end
            end
        end
    end
end
endtask

 
always @(CENB_flag    or WENB_flag 
        or BWENB0_flag 
        or DB0_flag 
        or BWENB1_flag 
        or DB1_flag 
        or BWENB2_flag 
        or DB2_flag 
        or BWENB3_flag 
        or DB3_flag 
        or BWENB4_flag 
        or DB4_flag 
        or BWENB5_flag 
        or DB5_flag 
        or BWENB6_flag 
        or DB6_flag 
        or BWENB7_flag 
        or DB7_flag 
        or BWENB8_flag 
        or DB8_flag 
        or BWENB9_flag 
        or DB9_flag 
        or BWENB10_flag 
        or DB10_flag 
        or BWENB11_flag 
        or DB11_flag 
        or BWENB12_flag 
        or DB12_flag 
        or BWENB13_flag 
        or DB13_flag 
        or BWENB14_flag 
        or DB14_flag 
        or BWENB15_flag 
        or DB15_flag 
        or AB0_flag 
        or AB1_flag 
        or AB2_flag 
        or AB3_flag 
        or AB4_flag 
        or AB5_flag 
        or AB6_flag 
        or AB7_flag 
        or AB8_flag 
        or AB9_flag 
        or AB10_flag 
        or AB11_flag 
        or CLKB_H_flag   or CLKB_L_flag 
        or CLKB_CYC_flag or VIOB_flag) 

begin
    update_flag_busB;
    CENB_latched = (CENB_flag!==LAST_CENB_flag) ? 1'bx : CENB_latched ;
    WENB_latched = (WENB_flag!==LAST_WENB_flag) ? 1'bx : WENB_latched ;
    for (n=0; n<Wen_Width; n=n+1)
        BWENB_latched[n] = (BWENB_flag[n]!==LAST_BWENB_flag[n]) ? 1'bx : BWENB_latched[n] ;
    for (n=0; n<Add_Width; n=n+1)
        AB_latched[n] = (AB_flag[n]!==LAST_AB_flag[n]) ? 1'bx : AB_latched[n] ;
    for (n=0; n<Bits; n=n+1)
        DB_latched[n] = (DB_flag[n]!==LAST_DB_flag[n]) ? 1'bx : DB_latched[n] ;
    LAST_CENB_flag = CENB_flag;
    LAST_WENB_flag = WENB_flag;
    LAST_BWENB_flag = BWENB_flag;
    LAST_AB_flag = AB_flag;
    LAST_DB_flag = DB_flag;
    LAST_CLKB_CYC_flag = CLKB_CYC_flag;
    LAST_CLKB_H_flag = CLKB_H_flag;
    LAST_CLKB_L_flag = CLKB_L_flag;
    if(VIOB_flag!==LAST_VIOB_flag)
    begin
        if(WENA_latched===1'b1)
            QA_latched={Bits{1'bx}};
        else
        begin
            if(WENB_latched===1'b1)
                QB_latched={Bits{1'bx}};
            else
            begin
                if(^(AB_latched)===1'bx)
                    for(i=0;i<Word_Depth;i=i+1)
                        mem_array[i]={Bits{1'bx}};
                else
                    mem_array[AB_latched]={Bits{1'bx}};
            end
        end
        LAST_VIOB_flag=VIOB_flag;
    end
    else
        rw_memB;
end

task rw_memB;
begin
    if(CENB_latched==1'b0)
    begin
        if (WENB_latched==1'b1)
        begin
            if(^(AB_latched)==1'bx)
            QB_latched={Bits{1'bx}};
            else
            QB_latched=mem_array[AB_latched];
        end
        else if (WENB_latched==1'b0)
        begin
        for (wenn=0; wenn<Wen_Width; wenn=wenn+1)
            begin
            lb=wenn*Word_Pt;
            if ( (lb+Word_Pt) >= Bits) hb=Bits-1;
            else hb=lb+Word_Pt-1;
            if (BWENB_latched[wenn]==1'b1)
                begin
                if(^(AB_latched)==1'bx)
                    for (i=lb; i<=hb; i=i+1) QB_latched[i]=1'bx;
                else
                    begin
                    data_tmpb=mem_array[AB_latched];
                    for (i=lb; i<=hb; i=i+1) QB_latched[i]=data_tmpb[i];
                    end
                end
            else if (BWENB_latched[wenn]==1'b0)
                begin
                if (^(AB_latched)==1'bx)
                    begin
                    for (i=0; i<Word_Depth; i=i+1)
                        begin
                        data_tmpb=mem_array[i];
                        for (j=lb; j<=hb; j=j+1) data_tmpb[j]=1'bx;
                        mem_array[i]=data_tmpb;
                        end
                    for (i=lb; i<=hb; i=i+1) QB_latched[i]=1'bx;
                    end
                else
                    begin
                    data_tmpb=mem_array[AB_latched];
                    for (i=lb; i<=hb; i=i+1) data_tmpb[i]=DB_latched[i];
                    mem_array[AB_latched]=data_tmpb;
                    for (i=lb; i<=hb; i=i+1) QB_latched[i]=data_tmpb[i];
                    end
                end
            else
                begin
                for (i=lb; i<=hb;i=i+1) QB_latched[i]=1'bx;
                if (^(AB_latched)==1'bx)
                    begin
                    for (i=0; i<Word_Depth; i=i+1)
                        begin
                        data_tmpb=mem_array[i];
                        for (j=lb; j<=hb; j=j+1) data_tmpb[j]=1'bx;
                        mem_array[i]=data_tmpb;
                        end
                    end
                else
                    begin
                    data_tmpb=mem_array[AB_latched];
                    for (i=lb; i<=hb; i=i+1) data_tmpb[i]=1'bx;
                    mem_array[AB_latched]=data_tmpb;
                    end
                end
            end
            end
        else
            begin
            for (wenn=0; wenn<Wen_Width; wenn=wenn+1)
            begin
                lb=wenn*Word_Pt;
                if ( (lb+Word_Pt) >= Bits) hb=Bits-1;
                else hb=lb+Word_Pt-1;
                if (BWENB_latched[wenn]==1'b1)
                begin
                if(^(AB_latched)==1'bx)
                    for (i=lb; i<=hb; i=i+1) QB_latched[i]=1'bx;
                else
                    begin
                    data_tmpb=mem_array[AB_latched];
                    for (i=lb; i<=hb; i=i+1) QB_latched[i]=data_tmpb[i];
                    end
                end
            else
                begin
                for (i=lb; i<=hb;i=i+1) QB_latched[i]=1'bx;
                if (^(AB_latched)==1'bx)
                    begin
                    for (i=0; i<Word_Depth; i=i+1)
                        begin
                        data_tmpb=mem_array[i];
                        for (j=lb; j<=hb; j=j+1) data_tmpb[j]=1'bx;
                        mem_array[i]=data_tmpb;
                        end
                    end
                else
                    begin
                    data_tmpb=mem_array[AB_latched];
                    for (i=lb; i<=hb; i=i+1) data_tmpb[i]=1'bx;
                    mem_array[AB_latched]=data_tmpb;
                    end
                end
            end
            end
        end
        else if (CENB_latched==1'bx)
        begin
            for (wenn=0;wenn<Wen_Width;wenn=wenn+1)
        begin
            lb=wenn*Word_Pt;
            if ((lb+Word_Pt)>=Bits) hb=Bits-1;
            else hb=lb+Word_Pt-1;
            if(WENB_latched==1'b1 || BWENB_latched[wenn]==1'b1)
            for (i=lb;i<=hb;i=i+1) QB_latched[i]=1'bx;
            else
            begin
                for (i=lb;i<=hb;i=i+1) QB_latched[i]=1'bx;
                if(^(AB_latched)==1'bx)
                begin
                    for (i=0;i<Word_Depth;i=i+1)
                    begin
                        data_tmpb=mem_array[i];
                        for (j=lb;j<=hb;j=j+1) data_tmpb[j]=1'bx;
                        mem_array[i]=data_tmpb;
                    end
                end
                else
                begin
                    data_tmpb=mem_array[AB_latched];
                    for (i=lb;i<=hb;i=i+1) data_tmpb[i]=1'bx;
                    mem_array[AB_latched]=data_tmpb;
                end
            end
        end
    end
end
endtask

 
task x_mem; 
begin 
    for(i=0;i<Word_Depth;i=i+1) 
    mem_array[i]={Bits{1'bx}}; 
end 
endtask 
 
task update_flag_busA; 
begin 
BWENA_flag = { 
            BWENA15_flag, 
            BWENA14_flag, 
            BWENA13_flag, 
            BWENA12_flag, 
            BWENA11_flag, 
            BWENA10_flag, 
            BWENA9_flag, 
            BWENA8_flag, 
            BWENA7_flag, 
            BWENA6_flag, 
            BWENA5_flag, 
            BWENA4_flag, 
            BWENA3_flag, 
            BWENA2_flag, 
            BWENA1_flag, 
            BWENA0_flag }; 
AA_flag = { 
            AA11_flag, 
            AA10_flag, 
            AA9_flag, 
            AA8_flag, 
            AA7_flag, 
            AA6_flag, 
            AA5_flag, 
            AA4_flag, 
            AA3_flag, 
            AA2_flag, 
            AA1_flag, 
            AA0_flag }; 
DA_flag = { 
            DA15_flag, 
            DA14_flag, 
            DA13_flag, 
            DA12_flag, 
            DA11_flag, 
            DA10_flag, 
            DA9_flag, 
            DA8_flag, 
            DA7_flag, 
            DA6_flag, 
            DA5_flag, 
            DA4_flag, 
            DA3_flag, 
            DA2_flag, 
            DA1_flag, 
            DA0_flag }; 
end 
endtask 
 
task update_flag_busB; 
begin 
BWENB_flag = { 
            BWENB15_flag, 
            BWENB14_flag, 
            BWENB13_flag, 
            BWENB12_flag, 
            BWENB11_flag, 
            BWENB10_flag, 
            BWENB9_flag, 
            BWENB8_flag, 
            BWENB7_flag, 
            BWENB6_flag, 
            BWENB5_flag, 
            BWENB4_flag, 
            BWENB3_flag, 
            BWENB2_flag, 
            BWENB1_flag, 
            BWENB0_flag }; 
AB_flag = { 
            AB11_flag, 
            AB10_flag, 
            AB9_flag, 
            AB8_flag, 
            AB7_flag, 
            AB6_flag, 
            AB5_flag, 
            AB4_flag, 
            AB3_flag, 
            AB2_flag, 
            AB1_flag, 
            AB0_flag }; 
DB_flag = { 
            DB15_flag, 
            DB14_flag, 
            DB13_flag, 
            DB12_flag, 
            DB11_flag, 
            DB10_flag, 
            DB9_flag, 
            DB8_flag, 
            DB7_flag, 
            DB6_flag, 
            DB5_flag, 
            DB4_flag, 
            DB3_flag, 
            DB2_flag, 
            DB1_flag, 
            DB0_flag }; 
end 
endtask 
 
specify 
(posedge CLKA => (QA[0]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[0]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[0] ,0.393,0.388,BWENA0_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[0] ,0.41,0.407,BWENA0_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[0] ,0.393,0.388,BWENB0_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[0] ,0.41,0.407,BWENB0_flag); 
$setuphold(posedge CLKA &&& WRA0_flag, posedge DA[0] ,0.393,0.388,DA0_flag); 
$setuphold(posedge CLKA &&& WRA0_flag, negedge DA[0] ,0.41,0.407,DA0_flag); 
$setuphold(posedge CLKB &&& WRB0_flag, posedge DB[0] ,0.393,0.388,DB0_flag); 
$setuphold(posedge CLKB &&& WRB0_flag, negedge DB[0] ,0.41,0.407,DB0_flag); 
(posedge CLKA => (QA[1]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[1]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[1] ,0.393,0.388,BWENA1_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[1] ,0.41,0.407,BWENA1_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[1] ,0.393,0.388,BWENB1_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[1] ,0.41,0.407,BWENB1_flag); 
$setuphold(posedge CLKA &&& WRA1_flag, posedge DA[1] ,0.393,0.388,DA1_flag); 
$setuphold(posedge CLKA &&& WRA1_flag, negedge DA[1] ,0.41,0.407,DA1_flag); 
$setuphold(posedge CLKB &&& WRB1_flag, posedge DB[1] ,0.393,0.388,DB1_flag); 
$setuphold(posedge CLKB &&& WRB1_flag, negedge DB[1] ,0.41,0.407,DB1_flag); 
(posedge CLKA => (QA[2]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[2]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[2] ,0.393,0.388,BWENA2_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[2] ,0.41,0.407,BWENA2_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[2] ,0.393,0.388,BWENB2_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[2] ,0.41,0.407,BWENB2_flag); 
$setuphold(posedge CLKA &&& WRA2_flag, posedge DA[2] ,0.393,0.388,DA2_flag); 
$setuphold(posedge CLKA &&& WRA2_flag, negedge DA[2] ,0.41,0.407,DA2_flag); 
$setuphold(posedge CLKB &&& WRB2_flag, posedge DB[2] ,0.393,0.388,DB2_flag); 
$setuphold(posedge CLKB &&& WRB2_flag, negedge DB[2] ,0.41,0.407,DB2_flag); 
(posedge CLKA => (QA[3]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[3]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[3] ,0.393,0.388,BWENA3_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[3] ,0.41,0.407,BWENA3_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[3] ,0.393,0.388,BWENB3_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[3] ,0.41,0.407,BWENB3_flag); 
$setuphold(posedge CLKA &&& WRA3_flag, posedge DA[3] ,0.393,0.388,DA3_flag); 
$setuphold(posedge CLKA &&& WRA3_flag, negedge DA[3] ,0.41,0.407,DA3_flag); 
$setuphold(posedge CLKB &&& WRB3_flag, posedge DB[3] ,0.393,0.388,DB3_flag); 
$setuphold(posedge CLKB &&& WRB3_flag, negedge DB[3] ,0.41,0.407,DB3_flag); 
(posedge CLKA => (QA[4]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[4]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[4] ,0.393,0.388,BWENA4_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[4] ,0.41,0.407,BWENA4_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[4] ,0.393,0.388,BWENB4_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[4] ,0.41,0.407,BWENB4_flag); 
$setuphold(posedge CLKA &&& WRA4_flag, posedge DA[4] ,0.393,0.388,DA4_flag); 
$setuphold(posedge CLKA &&& WRA4_flag, negedge DA[4] ,0.41,0.407,DA4_flag); 
$setuphold(posedge CLKB &&& WRB4_flag, posedge DB[4] ,0.393,0.388,DB4_flag); 
$setuphold(posedge CLKB &&& WRB4_flag, negedge DB[4] ,0.41,0.407,DB4_flag); 
(posedge CLKA => (QA[5]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[5]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[5] ,0.393,0.388,BWENA5_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[5] ,0.41,0.407,BWENA5_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[5] ,0.393,0.388,BWENB5_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[5] ,0.41,0.407,BWENB5_flag); 
$setuphold(posedge CLKA &&& WRA5_flag, posedge DA[5] ,0.393,0.388,DA5_flag); 
$setuphold(posedge CLKA &&& WRA5_flag, negedge DA[5] ,0.41,0.407,DA5_flag); 
$setuphold(posedge CLKB &&& WRB5_flag, posedge DB[5] ,0.393,0.388,DB5_flag); 
$setuphold(posedge CLKB &&& WRB5_flag, negedge DB[5] ,0.41,0.407,DB5_flag); 
(posedge CLKA => (QA[6]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[6]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[6] ,0.393,0.388,BWENA6_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[6] ,0.41,0.407,BWENA6_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[6] ,0.393,0.388,BWENB6_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[6] ,0.41,0.407,BWENB6_flag); 
$setuphold(posedge CLKA &&& WRA6_flag, posedge DA[6] ,0.393,0.388,DA6_flag); 
$setuphold(posedge CLKA &&& WRA6_flag, negedge DA[6] ,0.41,0.407,DA6_flag); 
$setuphold(posedge CLKB &&& WRB6_flag, posedge DB[6] ,0.393,0.388,DB6_flag); 
$setuphold(posedge CLKB &&& WRB6_flag, negedge DB[6] ,0.41,0.407,DB6_flag); 
(posedge CLKA => (QA[7]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[7]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[7] ,0.393,0.388,BWENA7_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[7] ,0.41,0.407,BWENA7_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[7] ,0.393,0.388,BWENB7_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[7] ,0.41,0.407,BWENB7_flag); 
$setuphold(posedge CLKA &&& WRA7_flag, posedge DA[7] ,0.393,0.388,DA7_flag); 
$setuphold(posedge CLKA &&& WRA7_flag, negedge DA[7] ,0.41,0.407,DA7_flag); 
$setuphold(posedge CLKB &&& WRB7_flag, posedge DB[7] ,0.393,0.388,DB7_flag); 
$setuphold(posedge CLKB &&& WRB7_flag, negedge DB[7] ,0.41,0.407,DB7_flag); 
(posedge CLKA => (QA[8]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[8]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[8] ,0.393,0.388,BWENA8_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[8] ,0.41,0.407,BWENA8_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[8] ,0.393,0.388,BWENB8_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[8] ,0.41,0.407,BWENB8_flag); 
$setuphold(posedge CLKA &&& WRA8_flag, posedge DA[8] ,0.393,0.388,DA8_flag); 
$setuphold(posedge CLKA &&& WRA8_flag, negedge DA[8] ,0.41,0.407,DA8_flag); 
$setuphold(posedge CLKB &&& WRB8_flag, posedge DB[8] ,0.393,0.388,DB8_flag); 
$setuphold(posedge CLKB &&& WRB8_flag, negedge DB[8] ,0.41,0.407,DB8_flag); 
(posedge CLKA => (QA[9]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[9]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[9] ,0.393,0.388,BWENA9_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[9] ,0.41,0.407,BWENA9_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[9] ,0.393,0.388,BWENB9_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[9] ,0.41,0.407,BWENB9_flag); 
$setuphold(posedge CLKA &&& WRA9_flag, posedge DA[9] ,0.393,0.388,DA9_flag); 
$setuphold(posedge CLKA &&& WRA9_flag, negedge DA[9] ,0.41,0.407,DA9_flag); 
$setuphold(posedge CLKB &&& WRB9_flag, posedge DB[9] ,0.393,0.388,DB9_flag); 
$setuphold(posedge CLKB &&& WRB9_flag, negedge DB[9] ,0.41,0.407,DB9_flag); 
(posedge CLKA => (QA[10]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[10]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[10] ,0.393,0.388,BWENA10_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[10] ,0.41,0.407,BWENA10_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[10] ,0.393,0.388,BWENB10_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[10] ,0.41,0.407,BWENB10_flag); 
$setuphold(posedge CLKA &&& WRA10_flag, posedge DA[10] ,0.393,0.388,DA10_flag); 
$setuphold(posedge CLKA &&& WRA10_flag, negedge DA[10] ,0.41,0.407,DA10_flag); 
$setuphold(posedge CLKB &&& WRB10_flag, posedge DB[10] ,0.393,0.388,DB10_flag); 
$setuphold(posedge CLKB &&& WRB10_flag, negedge DB[10] ,0.41,0.407,DB10_flag); 
(posedge CLKA => (QA[11]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[11]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[11] ,0.393,0.388,BWENA11_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[11] ,0.41,0.407,BWENA11_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[11] ,0.393,0.388,BWENB11_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[11] ,0.41,0.407,BWENB11_flag); 
$setuphold(posedge CLKA &&& WRA11_flag, posedge DA[11] ,0.393,0.388,DA11_flag); 
$setuphold(posedge CLKA &&& WRA11_flag, negedge DA[11] ,0.41,0.407,DA11_flag); 
$setuphold(posedge CLKB &&& WRB11_flag, posedge DB[11] ,0.393,0.388,DB11_flag); 
$setuphold(posedge CLKB &&& WRB11_flag, negedge DB[11] ,0.41,0.407,DB11_flag); 
(posedge CLKA => (QA[12]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[12]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[12] ,0.393,0.388,BWENA12_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[12] ,0.41,0.407,BWENA12_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[12] ,0.393,0.388,BWENB12_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[12] ,0.41,0.407,BWENB12_flag); 
$setuphold(posedge CLKA &&& WRA12_flag, posedge DA[12] ,0.393,0.388,DA12_flag); 
$setuphold(posedge CLKA &&& WRA12_flag, negedge DA[12] ,0.41,0.407,DA12_flag); 
$setuphold(posedge CLKB &&& WRB12_flag, posedge DB[12] ,0.393,0.388,DB12_flag); 
$setuphold(posedge CLKB &&& WRB12_flag, negedge DB[12] ,0.41,0.407,DB12_flag); 
(posedge CLKA => (QA[13]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[13]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[13] ,0.393,0.388,BWENA13_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[13] ,0.41,0.407,BWENA13_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[13] ,0.393,0.388,BWENB13_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[13] ,0.41,0.407,BWENB13_flag); 
$setuphold(posedge CLKA &&& WRA13_flag, posedge DA[13] ,0.393,0.388,DA13_flag); 
$setuphold(posedge CLKA &&& WRA13_flag, negedge DA[13] ,0.41,0.407,DA13_flag); 
$setuphold(posedge CLKB &&& WRB13_flag, posedge DB[13] ,0.393,0.388,DB13_flag); 
$setuphold(posedge CLKB &&& WRB13_flag, negedge DB[13] ,0.41,0.407,DB13_flag); 
(posedge CLKA => (QA[14]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[14]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[14] ,0.393,0.388,BWENA14_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[14] ,0.41,0.407,BWENA14_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[14] ,0.393,0.388,BWENB14_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[14] ,0.41,0.407,BWENB14_flag); 
$setuphold(posedge CLKA &&& WRA14_flag, posedge DA[14] ,0.393,0.388,DA14_flag); 
$setuphold(posedge CLKA &&& WRA14_flag, negedge DA[14] ,0.41,0.407,DA14_flag); 
$setuphold(posedge CLKB &&& WRB14_flag, posedge DB[14] ,0.393,0.388,DB14_flag); 
$setuphold(posedge CLKB &&& WRB14_flag, negedge DB[14] ,0.41,0.407,DB14_flag); 
(posedge CLKA => (QA[15]  : 1'bx))=(2.236,2.311); 
(posedge CLKB => (QB[15]  : 1'bx))=(2.236,2.311); 
$setuphold(posedge CLKA &&& CEA_flag,posedge BWENA[15] ,0.393,0.388,BWENA15_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge BWENA[15] ,0.41,0.407,BWENA15_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge BWENB[15] ,0.393,0.388,BWENB15_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge BWENB[15] ,0.41,0.407,BWENB15_flag); 
$setuphold(posedge CLKA &&& WRA15_flag, posedge DA[15] ,0.393,0.388,DA15_flag); 
$setuphold(posedge CLKA &&& WRA15_flag, negedge DA[15] ,0.41,0.407,DA15_flag); 
$setuphold(posedge CLKB &&& WRB15_flag, posedge DB[15] ,0.393,0.388,DB15_flag); 
$setuphold(posedge CLKB &&& WRB15_flag, negedge DB[15] ,0.41,0.407,DB15_flag); 
 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[0],0.521,0.749,AA0_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[0],0.585,0.749,AA0_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[0],0.521,0.749,AB0_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[0],0.585,0.749,AB0_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[1],0.521,0.749,AA1_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[1],0.585,0.749,AA1_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[1],0.521,0.749,AB1_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[1],0.585,0.749,AB1_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[2],0.521,0.749,AA2_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[2],0.585,0.749,AA2_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[2],0.521,0.749,AB2_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[2],0.585,0.749,AB2_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[3],0.521,0.749,AA3_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[3],0.585,0.749,AA3_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[3],0.521,0.749,AB3_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[3],0.585,0.749,AB3_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[4],0.521,0.749,AA4_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[4],0.585,0.749,AA4_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[4],0.521,0.749,AB4_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[4],0.585,0.749,AB4_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[5],0.521,0.749,AA5_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[5],0.585,0.749,AA5_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[5],0.521,0.749,AB5_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[5],0.585,0.749,AB5_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[6],0.521,0.749,AA6_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[6],0.585,0.749,AA6_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[6],0.521,0.749,AB6_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[6],0.585,0.749,AB6_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[7],0.521,0.749,AA7_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[7],0.585,0.749,AA7_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[7],0.521,0.749,AB7_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[7],0.585,0.749,AB7_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[8],0.521,0.749,AA8_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[8],0.585,0.749,AA8_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[8],0.521,0.749,AB8_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[8],0.585,0.749,AB8_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[9],0.521,0.749,AA9_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[9],0.585,0.749,AA9_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[9],0.521,0.749,AB9_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[9],0.585,0.749,AB9_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[10],0.521,0.749,AA10_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[10],0.585,0.749,AA10_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[10],0.521,0.749,AB10_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[10],0.585,0.749,AB10_flag); 
$setuphold(posedge CLKA &&& CEA_flag,posedge AA[11],0.521,0.749,AA11_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge AA[11],0.585,0.749,AA11_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge AB[11],0.521,0.749,AB11_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge AB[11],0.585,0.749,AB11_flag); 
 
$setuphold(posedge CLKA,posedge CENA,0.4,0.4,CENA_flag); 
$setuphold(posedge CLKA,negedge CENA,0.4,0.4,CENA_flag); 
$setuphold(posedge CLKB,posedge CENB,0.4,0.4,CENB_flag); 
$setuphold(posedge CLKB,negedge CENB,0.4,0.4,CENB_flag); 
 
$setuphold(posedge CLKA &&& CEA_flag,posedge WENA,0.384,0.407,WENA_flag); 
$setuphold(posedge CLKA &&& CEA_flag,negedge WENA,0.393,0.415,WENA_flag); 
$setuphold(posedge CLKB &&& CEB_flag,posedge WENB,0.384,0.407,WENB_flag); 
$setuphold(posedge CLKB &&& CEB_flag,negedge WENB,0.393,0.415,WENB_flag); 
 
$period(posedge CLKA,2.636,CLKA_CYC_flag); 
$period(negedge CLKA,2.636,CLKA_CYC_flag); 
$width(posedge CLKA,1.151,0,CLKA_H_flag); 
$width(negedge CLKA,0.728,0,CLKA_L_flag); 
$period(posedge CLKB,2.636,CLKB_CYC_flag); 
$period(negedge CLKB,2.636,CLKB_CYC_flag); 
$width(posedge CLKB,1.151,0,CLKB_H_flag); 
$width(negedge CLKB,0.728,0,CLKB_L_flag); 
 
/* 
$setup(posedge CLKA,posedge CLKB &&& clkconfB_flag,0.652,VIOB_flag); 
$hold (posedge CLKA,posedge CLKB &&& clkconf_flag ,0.652,VIOB_flag); 
$setup(posedge CLKB,posedge CLKA &&& clkconfA_flag,0.652,VIOA_flag); 
$hold (posedge CLKB,posedge CLKA &&& clkconf_flag ,0.652,VIOA_flag); 
 
$setup(posedge CLKA,posedge CLKB,0.652,VIOB_flag); 
$hold (posedge CLKA,posedge CLKB,0.652,VIOB_flag); 
$setup(posedge CLKB,posedge CLKA,0.652,VIOA_flag); 
$hold (posedge CLKB,posedge CLKA,0.652,VIOA_flag); 
*/ 
// below violations were reminders for AA == AB 
$setup(posedge CLKB &&& wa_rb,posedge CLKA &&& wa_rb,0.652,wa_rb_happen); // write A and read B happened at same time, write A passes, read B fails 
$setup(posedge CLKB &&& wb_ra,posedge CLKA &&& wb_ra,0.652,wb_ra_happen); // write B and read A happened at same time, write B passes, read A fails 
$setup(posedge CLKB &&& wa_wb,posedge CLKA &&& wa_wb,0.652,wa_wb_happen); // write A and write B happened at same time, illegal opreation. 
 
$setup(posedge CLKA &&& wa_rb,posedge CLKB &&& wa_rb,0.652,wa_rb_happen); // write A and read B happened at same time, write A passes, read B fails 
$setup(posedge CLKA &&& wb_ra,posedge CLKB &&& wb_ra,0.652,wb_ra_happen); // write B and read A happened at same time, write B passes, read A fails 
$setup(posedge CLKA &&& wa_wb,posedge CLKB &&& wa_wb,0.652,wa_wb_happen); // write A and write B happened at same time, illegal opreation. 
 
endspecify 
endmodule 
 
 

`endcelldefine
//*******************************************************************************************************
