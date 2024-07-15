# Crossbar
Crossbar realization (perform connection between  2 masters and 2 slaves)

//crossbar filling
    - 4 muxes: two for servicing input signal buses from masters to slaves, and 2 for servising input signals from slaves to masters; 
    - two arbiters which form control signals for master->slave muxes;
    - two combination logic blocks which form control signals for slave->master muxes from arbiters output singnals;
    
//Performance comparison:
Crossbar test bench perform 9 states:

    1) master_1 - off, master_2 -off;
    2) master_1 - off, master_2 -> slave_1;
    3) master_1 - off, master_2 -> slave_2;
    4) master_1 -> slave_1, master_2 -off;
    5) master_1 -> slave_1, master_2 -> slave_1;
    6) master_1 -> slave_1, master_2 -> slave_2;
    7) master_1 -> slave_2, master_2 -off;
    8) master_1 -> slave_2, master_2 -> slave_1;
    9) master_1 -> slave_2, master_2 -> slave_2;
    
//for performance comparison it is necessary to observe connection between masters and slaves:   
    m_req(i) -> s_req(i);
    m_addr(i) -> s_addr(i);
    m_wdata(i) -> s_wdata(i);
    s_rdata(i) -> m_rdata(i);
    
//initial variable values: 
    m_wdata1 = 1111;
    m_wdata2 = 2222;
    s_rdata1 = 1000;
    s_rdata2 = 2000;
    
Best regards,
Michael Gaidukov
      
