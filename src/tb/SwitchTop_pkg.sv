package SwitchTop_pkg;

  // import "DPI" function int sine(input real degree);

  semaphore pktSendEndFlags = new();
  event startWaitIdle;
  semaphore pktIdleFlags = new();
  event startTransfer;
  event checkFinish;

  // A single pkt class
  class pkt_transaction;
    rand bit [31:0] data[];
    rand bit [3:0] srcPort;
    rand bit [3:0] dstPort;
    rand bit [2:0] prio;  // randc may be better?
    rand bit [9:0] pktLen;  // 63-1023 indicates 64B-1024B
    rand bit [7:0] pktId;
    rand int data_nidles;
    rand int pkt_nidles;
    bit rsp;
    local static int obj_id = 0;
    local bit [31:0] data_pre[256];
    rand bit [9:0] pktLen_mod;

    constraint cstr {
      // if (pktLen[1:0] == 2'b11)
      // data.size() == ((this.pktLen + 1) >> 2) + 1;
      // else
      // data.size() == ((this.pktLen + 1) >> 2) + 1 + 1;
      if (((this.pktLen | 2'b11) & 6'h3f) == 6'h3f)  //TODO: Fix Unpack Bug
      data.size() == (((this.pktLen | 2'b11) + 1) >> 2) + 2;
      else
      data.size() == (((this.pktLen | 2'b11) + 1) >> 2) + 1;

      if (((this.pktLen | 2'b11) & 6'h3f) == 6'h3f)  //TODO: Fix Unpack Bug
      pktLen_mod == (this.pktLen | 2'b11) + 4;
      else
      pktLen_mod == (this.pktLen | 2'b11);

      foreach (data[i])
      if (i == 0)
      data[i] == {15'b0, this.pktLen_mod, this.prio, this.dstPort};
      else
      if (i == 1)
      data[i] == {3'b0, this.pktId, this.pktLen_mod, this.prio, this.dstPort, this.srcPort};
      else
      // data[i] == data_pre[i];
      data[i] == 'hc0000000 + (this.pktId << 12) + i;


      srcPort inside {[0 : 15]};
      dstPort inside {[0 : 15]};
      prio inside {[0 : 7]};
      pktLen inside {[63 : 1023]};
      soft pktId == 0;
      data_nidles inside {[0 : 2]};
      pkt_nidles inside {[1 : 10]};
    }

    function void pre_randomize();
      // real offset = $urandom;
      // foreach (this.data_pre[i]) this.data_pre[i] = sine(i * 3 + offset);
    endfunction

    function new();
      this.obj_id++;
    endfunction

    function pkt_transaction clone();
      pkt_transaction c = new();
      c.data = this.data;
      c.srcPort = this.srcPort;
      c.dstPort = this.dstPort;
      c.prio = this.prio;
      c.pktLen = this.pktLen;
      c.pktId = this.pktId;
      c.data_nidles = this.data_nidles;
      c.pkt_nidles = this.pkt_nidles;
      c.rsp = this.rsp;
      return c;
    endfunction

    function string sprint();
      string s;
      s = {s, $sformatf("=======================================\n")};
      s = {s, $sformatf("pkt_transaction object content is as below: \n")};
      s = {s, $sformatf("obj_id = %0d: \n", this.obj_id)};
      foreach (data[i]) s = {s, $sformatf("data[%0d] = %8x \n", i, this.data[i])};
      s = {s, $sformatf("srcPort = %0d: \n", this.srcPort)};
      s = {s, $sformatf("dstPort = %0d: \n", this.dstPort)};
      s = {s, $sformatf("prio = %0d: \n", this.prio)};
      s = {s, $sformatf("pktLen = %0d: \n", this.pktLen)};
      s = {s, $sformatf("pktLen_mod = %0d: \n", this.pktLen_mod)};
      s = {s, $sformatf("data.size() = %0d: \n", this.data.size())};
      s = {s, $sformatf("pktId = %0d: \n", this.pktId)};
      s = {s, $sformatf("data_nidles = %0d: \n", this.data_nidles)};
      s = {s, $sformatf("pkt_nidles = %0d: \n", this.pkt_nidles)};
      s = {s, $sformatf("rsp = %0d: \n", this.rsp)};
      s = {s, $sformatf("=======================================\n")};
      return s;
    endfunction
  endclass

  bit [2:0] prio_arr[16];
  // Generate multi pkts class
  class pkt_generator;
    rand int srcPort_q[$];
    rand int dstPort_q[$];
    rand int prio_q[$];
    rand int pktLen_q[$];
    rand int pktId_q[$];
    rand int ntrans_q[$];  //Pkt num
    rand int data_nidles = -1;
    rand int pkt_nidles = -1;
    rand int ntests;  //Test num
    rand int order_prio;
    int srcPort = -1;
    int dstPort = -1;
    int prio = -1;
    int pktLen = -1;  // 63-1023 indicates 64B-1024B
    int pktId = -1;
    int ntrans = 10;



    mailbox #(pkt_transaction) req_mb;
    mailbox #(pkt_transaction) rsp_mb;

    constraint cstr {
      srcPort_q.size() == ntests;
      dstPort_q.size() == ntests;
      prio_q.size() == ntests;
      pktLen_q.size() == ntests;
      pktId_q.size() == ntests;
      ntrans_q.size() == ntests;
      soft order_prio == 0;
      soft data_nidles == -1;
      soft pkt_nidles == -1;
      soft ntrans == 10;
      soft ntests == 1;
    }


    function new();
      this.req_mb = new();
      this.rsp_mb = new();
    endfunction


    task run();
      repeat (this.ntests) begin
        this.srcPort = srcPort_q.pop_front();
        this.dstPort = dstPort_q.pop_front();
        this.prio = prio_q.pop_front();
        this.pktLen = pktLen_q.pop_front();
        this.pktId = pktId_q.pop_front();
        this.ntrans = ntrans_q.pop_front();
        repeat (this.ntrans) send_pkt_trans();
        pktSendEndFlags.put();
        @startTransfer;
      end
    endtask


    // generate pkt transaction and put into local mailbox
    task send_pkt_trans();
      pkt_transaction req, rsp;
      req = new();
      assert (req.randomize with {
        local:: srcPort >= 0 -> srcPort == local:: srcPort;
        local:: dstPort >= 0 -> dstPort == local:: dstPort;

        if (order_prio)
        prio == prio_arr[dstPort];
        else
        local:: prio >= 0 -> prio == local:: prio;

        local:: pktLen >= 0 -> pktLen == local:: pktLen;
        local:: pktId >= 0 -> pktId == local:: pktId;
        local:: data_nidles >= 0 -> data_nidles == local:: data_nidles;
        local:: pkt_nidles >= 0 -> pkt_nidles == local:: pkt_nidles;
      })
      else $fatal("[RNDFAIL] channel packet randomization failure!");
      if (this.pktId == 255) this.pktId = 0;
      else this.pktId++;
      if (this.order_prio) prio_arr[req.dstPort]++;
`ifdef DEBUG
      $display(req.sprint());
`endif
      this.req_mb.put(req);
      this.rsp_mb.get(rsp);
`ifdef DEBUG
      $display(rsp.sprint());
`endif
      assert (rsp.rsp)
      else $error("[RSPERR] %0t error response received!", $time);
    endtask


    function string sprint();
      string s;
      s = {s, $sformatf("=======================================\n")};
      s = {s, $sformatf("pkt_generator object content is as below: \n")};
      s = {s, $sformatf("ntests = %0d: \n", this.ntests)};
      s = {s, $sformatf("ntrans_q = %p: \n", this.ntrans_q)};
      s = {s, $sformatf("srcPort_q = %p: \n", this.srcPort_q)};
      s = {s, $sformatf("dstPort_q = %p: \n", this.dstPort_q)};
      s = {s, $sformatf("prio_q = %p: \n", this.prio_q)};
      s = {s, $sformatf("pktLen_q = %p: \n", this.pktLen_q)};
      s = {s, $sformatf("pktId_q = %p: \n", this.pktId_q)};
      s = {s, $sformatf("data_nidles = %0d: \n", this.data_nidles)};
      s = {s, $sformatf("pkt_nidles = %0d: \n", this.pkt_nidles)};
      s = {s, $sformatf("=======================================\n")};
      return s;
    endfunction

    function void post_randomize();
      string s;
      s = {"AFTER RANDOMIZATION \n", this.sprint()};
      $display(s);
    endfunction

  endclass

  // Sender class
  class pkt_driver;
    local string name;
    local virtual wrPortIntf intf;
    mailbox #(pkt_transaction) req_mb;
    mailbox #(pkt_transaction) rsp_mb;

    function new(string name = "pkt_driver");
      this.name = name;
    endfunction

    function void set_interface(virtual wrPortIntf intf);
      if (intf == null)
        $error("interface handle is NULL, please check if target interface has been intantiated");
      else this.intf = intf;
    endfunction

    task run();
      this.drive();
    endtask

    task drive();
      pkt_transaction req, rsp;
      @(posedge intf.iRst_n);
      forever begin
        this.req_mb.get(req);
        this.pkt_write(req);
        rsp = req.clone();
        rsp.rsp = 1;
        this.rsp_mb.put(rsp);
      end
    endtask


    task pkt_write(input pkt_transaction t);
      @(posedge intf.iClk);
      intf.drv_ck.wrSop <= 1;
      @(posedge intf.iClk);
      intf.drv_ck.wrSop <= 0;
      foreach (t.data[i]) begin
        if (i != 0) @(posedge intf.iClk);
        intf.drv_ck.wrVld  <= 1;
        intf.drv_ck.wrData <= t.data[i];
        @(negedge intf.iClk);
        // wait (intf.fifoFull === 'b0 && intf.sramAlmostFull === 'b0);
        wait (intf.fifoFull === 'b0);  //TODO: Use sramAlmostFull
`ifdef DEBUG
        $display("%0t pkt drive [%s] sent data %x", $time, name, t.data[i]);
`endif
        if (i != t.data.size() - 1) repeat (t.data_nidles) driver_idle();
      end
      driver_idle();
      // @(posedge intf.iClk);
      intf.drv_ck.wrEop <= 1;
      @(posedge intf.iClk);
      intf.drv_ck.wrEop <= 0;

      repeat (t.pkt_nidles) driver_idle();
    endtask

    task driver_idle();
      @(posedge intf.iClk);
      intf.drv_ck.wrVld  <= 0;
      intf.drv_ck.wrData <= 0;
    endtask
  endclass



  typedef enum {
    SOP,
    CTRL,
    DATA0,
    DATAN,
    EOP
  } state_e;

  typedef struct {
    bit [3:0] srcPort;
    bit [3:0] dstPort;
    bit [2:0] prio;
    bit [9:0] pktLen;
    bit [7:0] pktId;
  } pktInfo_t;

  class pkt_send_monitor;
    local string name;
    local virtual wrPortIntf intf;
    mailbox #(pktInfo_t) send_mb[16];
    local state_e sendState = SOP;
    mailbox sendCnt_mb;

    function new(string name = "pkt_send_monitor");
      this.name = name;
    endfunction
    function void set_interface(virtual wrPortIntf intf);
      if (intf == null)
        $error("interface handle is NULL, please check if target interface has been intantiated");
      else this.intf = intf;
    endfunction
    task run();
      this.mon_pkt_send();
    endtask

    task mon_pkt_send();
      pktInfo_t p;
      forever begin
        @(posedge intf.iClk);
        case (sendState)
          SOP: begin
            if (intf.mon_ck.wrSop === 'b1) begin
              sendState = CTRL;
            end
          end
          CTRL: begin
            // if (intf.mon_ck.wrVld === 'b1 && intf.mon_ck.fifoFull === 'b0 &&  intf.mon_ck.sramAlmostFull === 'b0) begin
            if (intf.mon_ck.wrVld === 'b1 && intf.mon_ck.fifoFull === 'b0) begin
              sendState = DATA0;
              sendCnt_mb.put(1);
`ifdef DEBUG
              $display("%0t %s monitored pkt send ctrl frame %8x", $time, this.name,
                       intf.mon_ck.wrData);
`endif
            end
          end
          DATA0: begin
            // if (intf.mon_ck.wrVld === 'b1 && intf.mon_ck.fifoFull === 'b0 &&  intf.mon_ck.sramAlmostFull === 'b0) begin
            if (intf.mon_ck.wrVld === 'b1 && intf.mon_ck.fifoFull === 'b0) begin
              sendState = DATAN;
              sendCnt_mb.put(1);
              {p.pktId, p.pktLen, p.prio, p.dstPort, p.srcPort} = intf.mon_ck.wrData;
              send_mb[p.dstPort].put(p);
`ifdef DEBUG
              $display("%0t %s monitored pkt send data frame0 %p", $time, this.name, p);
`endif
            end
          end
          DATAN: begin
            // if (intf.mon_ck.wrVld === 'b1 && intf.mon_ck.fifoFull === 'b0 &&  intf.mon_ck.sramAlmostFull === 'b0) begin
            if (intf.mon_ck.wrVld === 'b1 && intf.mon_ck.fifoFull === 'b0) begin
              sendState = DATAN;
              sendCnt_mb.put(1);
`ifdef DEBUG
              $display("%0t %s monitored pkt send data frameN %8x", $time, this.name,
                       intf.mon_ck.wrData);
`endif
            end else if (intf.mon_ck.wrEop === 'b1) begin
              sendState = EOP;
            end
          end
          EOP: begin
            sendState = SOP;
`ifdef DEBUG
            $display("%0t %s monitored a complete pkt, total %d pkt in send_mb[%0d]", $time,
                     this.name, send_mb[p.dstPort].num(), p.dstPort);
`endif
          end
        endcase
      end
    endtask
  endclass

  class pkt_receive_monitor;
    local string name;
    virtual rdPortIntf intf;
    mailbox #(pktInfo_t) receive_mb;
    local state_e receiveState = SOP;
    mailbox err_mb;

    function new(string name = "pkt_receive_monitor");
      this.name = name;
    endfunction
    function void set_interface(virtual rdPortIntf intf);
      if (intf == null)
        $error("interface handle is NULL, please check if target interface has been intantiated");
      else this.intf = intf;
    endfunction
    task run();
      fork
        this.mon_pkt_receive();
        this.mon_pkt_idle(2000);  //TODO: parameter
      join
    endtask

    task mon_pkt_receive();
      pktInfo_t p;
      forever begin
        @(posedge intf.iClk);
        case (receiveState)
          SOP: begin
            if (intf.mon_ck.rdSop === 'b1) begin
              receiveState = DATA0;
            end
          end
          DATA0: begin
            if (intf.mon_ck.rdVld === 'b1 && intf.mon_ck.ready === 'b1) begin
              receiveState = DATAN;
              {p.pktId, p.pktLen, p.prio, p.dstPort, p.srcPort} = intf.mon_ck.rdData;
              receive_mb.put(p);
`ifdef DEBUG
              $display("%0t %s monitored pkt receive data frame0 %p", $time, this.name, p);
`endif
            end
          end
          DATAN: begin
            if (intf.mon_ck.rdVld === 'b1 && intf.mon_ck.ready === 'b1) begin
              receiveState = DATAN;
`ifdef DEBUG
              $display("%0t %s monitored pkt receive data frameN %8x", $time, this.name,
                       intf.mon_ck.rdData);
`endif
            end else if (intf.mon_ck.rdEop === 'b1) begin
              receiveState = EOP;
              if (intf.mon_ck.err === 1'b1) begin
                err_mb.put(1);
                $display("%0t %s monitored pkt receive CRC error! Total CRC error: %0d", $time,
                         this.name, err_mb.num());
              end
            end
          end
          EOP: begin
            receiveState = SOP;
`ifdef DEBUG
            $display("%0t %s monitored a complete pkt, total %d pkt in receive_mb", $time,
                     this.name, receive_mb.num());
`endif
          end
        endcase
      end
    endtask


    task mon_pkt_idle();
      input int idleCycles;
      int cnt;
      forever begin
        @startWaitIdle;
        $display("%0t %s wait for port idle", $time, this.name);
        fork
          forever begin
            @(posedge intf.iClk);
            if (!intf.mon_ck.rdVld) begin
              cnt = cnt + 1;
            end else begin
              cnt = 0;
            end
          end

          begin
            wait (cnt == idleCycles);
            $display("%0t, %s port idle detected!", $time, this.name);
            cnt = 0;
          end
        join_any
        disable fork;
        pktIdleFlags.put();
      end
    endtask
  endclass


  class pkt_drop_monitor;
    local string name;
    local virtual pktDropIntf intf;
    mailbox drop_mb[16];

    function new(string name = "pkt_drop_monitor");
      this.name = name;
    endfunction

    function void set_interface(virtual pktDropIntf intf);
      if (intf == null)
        $error("interface handle is NULL, please check if target interface has been intantiated");
      else this.intf = intf;
    endfunction

    task run();
      this.mon_pkt_drop();
    endtask

    task mon_pkt_drop();
      forever begin
        @(posedge intf.iClk);
        if (intf.mon_ck.vld && intf.mon_ck.rdy && intf.mon_ck.drop) begin
          drop_mb[intf.mon_ck.dstPort].put(1);
`ifdef DEBUG
          $display(
            "%0t %s monitored pkt drop from port %0d to %0d! Port %0d total receive drop: %0d",
            $time, this.name, intf.mon_ck.srcPort, intf.mon_ck.dstPort, intf.mon_ck.dstPort,
            drop_mb[intf.mon_ck.dstPort].num());
`endif
        end
      end
    endtask

  endclass

  class pkt_agent;
    local string name;
    pkt_driver driver;
    pkt_send_monitor send_mon;
    pkt_drop_monitor drop_mon;
    virtual wrPortIntf vif;

    function new(string name = "pkt_agent");
      this.name = name;
      this.driver = new({name, ".driver"});
      this.send_mon = new({name, ".send_mon"});
      this.drop_mon = new({name, ".drop_mon"});
    endfunction

    function void set_interface(virtual wrPortIntf vif, virtual pktDropIntf pktDrop_vif);
      this.vif = vif;
      driver.set_interface(vif);
      send_mon.set_interface(vif);
      drop_mon.set_interface(pktDrop_vif);
    endfunction

    task run();
      fork
        driver.run();
        send_mon.run();
        drop_mon.run();
      join
    endtask

  endclass

  class pkt_checker;
    local string name;
    local virtual fifoUsageIntf intf[16];
    local int pktStore[16];
    mailbox #(pktInfo_t) send_mb[16][16];
    mailbox #(pktInfo_t) receive_mb[16];
    mailbox drop_mb[16];
    mailbox err_mb[16];
    mailbox sendCnt_mb[16];
    local int ntests;

    function new(string name = "pkt_checker", int ntests);
      this.name   = name;
      this.ntests = ntests;
      foreach (this.send_mb[i, j]) this.send_mb[i][j] = new();
      foreach (this.receive_mb[i]) this.receive_mb[i] = new();
      foreach (this.drop_mb[i]) this.drop_mb[i] = new();
      foreach (this.err_mb[i]) this.err_mb[i] = new();
      foreach (this.sendCnt_mb[i]) this.sendCnt_mb[i] = new();
    endfunction

    function void set_interface(virtual fifoUsageIntf intf[16]);
      foreach (intf[i]) begin
        if (intf[i] == null)
          $error("interface handle is NULL, please check if target interface has been intantiated");
        else this.intf[i] = intf[i];
      end
    endfunction

    task run();
      bit err;
      fork
        begin
          repeat (this.ntests) begin
            this.mon_pkt_end();
            ->startTransfer;
            foreach (this.err_mb[i]) begin
              if (this.err_mb[i].num() > 0) begin
                $display("port %0d has %0d CRC errors", i, err_mb[i].num());
                err = 1;
              end
            end
            if (err) begin
              $fatal("[TESTFAIL]!\nCRC error monitored!");
            end else begin
              $display("[TESTPASS]!");
            end
          end
          ->checkFinish;
        end
        mon_time_out();
      join
    endtask


    task mon_pkt_store();
      begin
        @(posedge intf[0].iClk);
        for (int i = 0; i < 16; i = i + 1) begin
          pktStore[i] = intf[i].mon_ck.num.sum();
        end
      end
    endtask

    task mon_pkt_end();
      int tmp_sum;
      begin
        $display("%s wait for all port idle", this.name);
        pktIdleFlags.get(16);
        this.mon_pkt_store();
        for (int i = 0; i < 16; i = i + 1) begin
          for (int j = 0; j < 16; j = j + 1) begin
            tmp_sum = this.send_mb[j][i].num() + tmp_sum;
          end
          wait (this.receive_mb[i].num() + this.drop_mb[i].num() + this.pktStore[i] == tmp_sum);
          $display(
            "%0t %s checked port %0d num, receive_mb: %0d, drop_mb: %0d, pktStore: %0d, send_mb: %0d",
            $time, this.name, i, this.receive_mb[i].num(), this.drop_mb[i].num(), this.pktStore[i],
            tmp_sum);
          tmp_sum = 0;
        end
      end
    endtask

    task mon_time_out();
      int tmp_sum;
      begin
        repeat (2000000) @(posedge intf[0].iClk);
        $display("[TESTTIMEOUT]!");
        for (int i = 0; i < 16; i = i + 1) begin
          for (int j = 0; j < 16; j = j + 1) begin
            tmp_sum = this.send_mb[j][i].num() + tmp_sum;
          end
          $display("send_mb[%0d]: %0d", i, tmp_sum);
          tmp_sum = 0;
        end
        foreach (this.receive_mb[i]) $display("receive_mb[%0d]: %0d", i, this.receive_mb[i].num());
        foreach (this.drop_mb[i]) $display("drop_mb[%0d]: %0d", i, this.drop_mb[i].num());
        foreach (this.err_mb[i]) $display("err_mb[%0d]: %0d", i, this.err_mb[i].num());
        foreach (this.pktStore[i]) $display("pktStore[%0d]: %0d", i, this.pktStore[i]);
        foreach (this.sendCnt_mb[i]) $display("sendCnt_mb[%0d]: %0d", i, this.sendCnt_mb[i].num());
        $fatal;
      end
    endtask
  endclass

  class root_test;
    pkt_generator gen[16];
    pkt_agent agent[16];
    pkt_receive_monitor receive_mon[16];
    pkt_checker chker;
    protected string name;
    protected int ntests;
    local virtual wrrCfgIntf vif;
    event gen_stop_e;

    function new(string name = "root_test", int ntests = 1);
      this.name   = name;
      this.ntests = ntests;
      this.chker  = new("pkt_checker", this.ntests);
      foreach (agent[i]) begin
        this.agent[i] = new($sformatf("pkt_agent%0d", i));
        this.gen[i] = new();
        this.agent[i].driver.req_mb = this.gen[i].req_mb;
        this.agent[i].driver.rsp_mb = this.gen[i].rsp_mb;
        this.agent[i].send_mon.send_mb = this.chker.send_mb[i];
        this.agent[i].send_mon.sendCnt_mb = this.chker.sendCnt_mb[i];
        this.agent[i].drop_mon.drop_mb = this.chker.drop_mb;
      end
      foreach (receive_mon[i]) begin
        this.receive_mon[i] = new($sformatf("pkt_receive_monitor%0d", i));
        this.receive_mon[i].receive_mb = this.chker.receive_mb[i];
        this.receive_mon[i].err_mb = this.chker.err_mb[i];
      end
      $display("%s instantiated and connected objects", this.name);
    endfunction

    virtual task gen_stop_callback();
      // empty
    endtask

    virtual task pkt_send_end_callback();
      begin
        $display("%s: wait for all generators have generated and tranferred transcations",
                 this.name);
        pktSendEndFlags.get(16);
        ->startWaitIdle;
      end
    endtask

    virtual task run();
      $display($sformatf("*****************%s started********************", this.name));
      this.do_config();
      fork
        this.do_ready_gen();
        this.do_init_wrr({8, 8, 8, 8, 8, 8, 8, 8});
      join_none
      fork
        agent[0].run();
        agent[1].run();
        agent[2].run();
        agent[3].run();
        agent[4].run();
        agent[5].run();
        agent[6].run();
        agent[7].run();
        agent[8].run();
        agent[9].run();
        agent[10].run();
        agent[11].run();
        agent[12].run();
        agent[13].run();
        agent[14].run();
        agent[15].run();
        receive_mon[0].run();
        receive_mon[1].run();
        receive_mon[2].run();
        receive_mon[3].run();
        receive_mon[4].run();
        receive_mon[5].run();
        receive_mon[6].run();
        receive_mon[7].run();
        receive_mon[8].run();
        receive_mon[9].run();
        receive_mon[10].run();
        receive_mon[11].run();
        receive_mon[12].run();
        receive_mon[13].run();
        receive_mon[14].run();
        receive_mon[15].run();
        chker.run();
      join_none
      // run first the callback thread to conditionally disable gen_threads
      fork
        this.gen_stop_callback();
        @(this.gen_stop_e) disable gen_threads;
      join_none
      fork : gen_threads
        gen[0].run();
        gen[1].run();
        gen[2].run();
        gen[3].run();
        gen[4].run();
        gen[5].run();
        gen[6].run();
        gen[7].run();
        gen[8].run();
        gen[9].run();
        gen[10].run();
        gen[11].run();
        gen[12].run();
        gen[13].run();
        gen[14].run();
        gen[15].run();
      join_none
      repeat (this.ntests) pkt_send_end_callback();
      @checkFinish;
      $display($sformatf("*****************%s finished********************", this.name));
      $finish();
    endtask
    virtual function void set_interface(
      virtual wrPortIntf wr_vif[16], virtual rdPortIntf rd_vif[16],
      virtual pktDropIntf pktDrop_vif[16], virtual fifoUsageIntf fifoUsage_vif[16],
      virtual wrrCfgIntf wrrCfg_vif);
      foreach (agent[i]) agent[i].set_interface(wr_vif[i], pktDrop_vif[i]);
      foreach (receive_mon[i]) receive_mon[i].set_interface(rd_vif[i]);
      chker.set_interface(fifoUsage_vif);
      this.vif = wrrCfg_vif;
    endfunction


    virtual function void do_config();
      foreach (gen[i]) begin
        assert (gen[i].randomize() with {
          foreach (srcPort_q[j]) srcPort_q[j] == i;
          foreach (dstPort_q[j]) dstPort_q[j] == i;
          foreach (prio_q[j]) prio_q[j] == -1;  // -1 indicates random
          foreach (pktLen_q[j]) pktLen_q[j] inside {[63 : 255]};
          foreach (pktId_q[j]) pktId_q[j] == 0;
          foreach (ntrans_q[j]) ntrans_q[j] == 50;
          ntests == local:: ntests;
          data_nidles == 0;
          pkt_nidles == 1;
        })
        else $fatal("[RNDFAIL] gen[%0d] randomization failure!", i);
      end
    endfunction

    virtual task do_ready_gen();
      begin
        @(posedge receive_mon[0].intf.iRst_n);
        fork
          receive_mon[0].intf.READREADY(0, 1);
          receive_mon[1].intf.READREADY(0, 1);
          receive_mon[2].intf.READREADY(0, 1);
          receive_mon[3].intf.READREADY(0, 1);
          receive_mon[4].intf.READREADY(0, 1);
          receive_mon[5].intf.READREADY(0, 1);
          receive_mon[6].intf.READREADY(0, 1);
          receive_mon[7].intf.READREADY(0, 1);
          receive_mon[8].intf.READREADY(0, 1);
          receive_mon[9].intf.READREADY(0, 1);
          receive_mon[10].intf.READREADY(0, 1);
          receive_mon[11].intf.READREADY(0, 1);
          receive_mon[12].intf.READREADY(0, 1);
          receive_mon[13].intf.READREADY(0, 1);
          receive_mon[14].intf.READREADY(0, 1);
          receive_mon[15].intf.READREADY(0, 1);
        join_none
      end
    endtask

    virtual task do_init_wrr(int weight[8]);
      begin
        @(posedge this.vif.iRst_n);
        this.vif.INITWRR(weight[0], weight[1], weight[2], weight[3], weight[4], weight[5],
                         weight[6], weight[7]);
      end
    endtask
  endclass




  class s2s_test extends root_test;
    function new(string name = "s2s_test");
      super.new(name, 16);
    endfunction

    virtual function void do_config();
      foreach (gen[i]) begin
        assert (gen[i].randomize() with {
          foreach (srcPort_q[j]) srcPort_q[j] == i;
          foreach (dstPort_q[j]) dstPort_q[j] == (i + j) % 16;
          foreach (prio_q[j]) prio_q[j] == -1;  // -1 indicates random
          foreach (pktLen_q[j]) pktLen_q[j] inside {[63 : 255]};
          foreach (pktId_q[j]) pktId_q[j] == 0;
          foreach (ntrans_q[j]) ntrans_q[j] inside {[0 : 50]};
          ntests == local:: ntests;
          data_nidles == 0;
          pkt_nidles == 1;
        })
        else $fatal("[RNDFAIL] gen[%0d] randomization failure!", i);
      end
    endfunction
  endclass


  class m2s_test extends root_test;
    function new(string name = "m2s_test");
      super.new(name, 16);
    endfunction

    virtual function void do_config();
      foreach (gen[i]) begin
        assert (gen[i].randomize() with {
          foreach (srcPort_q[j]) srcPort_q[j] == i;
          foreach (dstPort_q[j]) dstPort_q[j] == j;
          foreach (prio_q[j]) prio_q[j] == -1;  // -1 indicates random
          foreach (pktLen_q[j]) pktLen_q[j] inside {[63 : 255]};
          foreach (pktId_q[j]) pktId_q[j] == 0;
          foreach (ntrans_q[j]) ntrans_q[j] inside {[0 : 50]};
          ntests == local:: ntests;
          data_nidles == 0;
          pkt_nidles == 1;
        })
        else $fatal("[RNDFAIL] gen[%0d] randomization failure!", i);
      end
    endfunction
  endclass

  class random_test extends root_test;
    function new(string name = "random_test");
      super.new(name, 10);
    endfunction

    virtual function void do_config();
      foreach (gen[i]) begin
        assert (gen[i].randomize() with {
          foreach (srcPort_q[j]) srcPort_q[j] == i;
          foreach (dstPort_q[j]) dstPort_q[j] inside {[0 : 15]};
          foreach (prio_q[j]) prio_q[j] == -1;  // -1 indicates random
          foreach (pktLen_q[j]) pktLen_q[j] inside {[63 : 255]};
          foreach (pktId_q[j]) pktId_q[j] == 0;
          foreach (ntrans_q[j]) ntrans_q[j] inside {[0 : 50]};
          ntests == local:: ntests;
          data_nidles == 0;
          pkt_nidles == 1;
        })
        else $fatal("[RNDFAIL] gen[%0d] randomization failure!", i);
      end
    endfunction
  endclass

  class sram_full_test extends root_test;
    function new(string name = "sram_full_test");
      super.new(name);
    endfunction

    // get all of 4 sram banks almostFull signals as a 4-bits vector
    local function bit [3:0] get_sram_flags();
      bit [3:0] tmp;
      foreach (tmp[i]) tmp[i] = agent[i<<2].vif.mon_ck.sramAlmostFull;
      return tmp;
    endfunction

    virtual function void do_config();
      foreach (gen[i]) begin
        assert (gen[i].randomize() with {
          foreach (srcPort_q[j]) srcPort_q[j] == i;
          foreach (dstPort_q[j]) dstPort_q[j] == i;
          foreach (prio_q[j]) prio_q[j] == -1;  // -1 indicates random
          foreach (pktLen_q[j]) pktLen_q[j] == 1023;
          foreach (pktId_q[j]) pktId_q[j] == 0;
          foreach (ntrans_q[j]) ntrans_q[j] == 500;  // To fill sram
          ntests == local:: ntests;
          data_nidles == 0;
          pkt_nidles == 1;
        })
        else $fatal("[RNDFAIL] gen[%0d] randomization failure!", i);
      end
    endfunction

    virtual task do_ready_gen();
      begin
        @(posedge receive_mon[0].intf.iRst_n);
        fork
          receive_mon[0].intf.READREADY(0, 0);
          receive_mon[1].intf.READREADY(0, 0);
          receive_mon[2].intf.READREADY(0, 0);
          receive_mon[3].intf.READREADY(0, 0);
          receive_mon[4].intf.READREADY(0, 0);
          receive_mon[5].intf.READREADY(0, 0);
          receive_mon[6].intf.READREADY(0, 0);
          receive_mon[7].intf.READREADY(0, 0);
          receive_mon[8].intf.READREADY(0, 0);
          receive_mon[9].intf.READREADY(0, 0);
          receive_mon[10].intf.READREADY(0, 0);
          receive_mon[11].intf.READREADY(0, 0);
          receive_mon[12].intf.READREADY(0, 0);
          receive_mon[13].intf.READREADY(0, 0);
          receive_mon[14].intf.READREADY(0, 0);
          receive_mon[15].intf.READREADY(0, 0);
        join_none
      end
    endtask

    virtual task gen_stop_callback();
      bit [3:0] sram_flags;
      $display("gen_stop_callback enterred");
      @(posedge agent[0].vif.iRst_n);
      forever begin
        @(posedge agent[0].vif.iClk);
        sram_flags = this.get_sram_flags();
        if ($countones(sram_flags) == 4) break;
      end

      $display("%s: stop 16 generators running", this.name);
      ->this.gen_stop_e;
    endtask

    virtual task pkt_send_end_callback();
      begin
        @(this.gen_stop_e);
        $display($sformatf("*****************%s finished********************", this.name));
        $finish();
      end
    endtask
  endclass

  class max_test extends root_test;
    function new(string name = "max_test");
      super.new(name, 1);
    endfunction

    virtual function void do_config();
      foreach (gen[i]) begin
        assert (gen[i].randomize() with {
          foreach (srcPort_q[j]) srcPort_q[j] == i;
          foreach (dstPort_q[j]) dstPort_q[j] == -1;  // -1 indicates random in every trans
          foreach (prio_q[j]) prio_q[j] == -1;
          foreach (pktLen_q[j]) pktLen_q[j] == -1;
          foreach (pktId_q[j]) pktId_q[j] == 0;
          foreach (ntrans_q[j]) ntrans_q[j] == 500;
          order_prio == 1;  //do not shuffle prio
          ntests == local:: ntests;
          data_nidles == 0;
          pkt_nidles == 1;
        })
        else $fatal("[RNDFAIL] gen[%0d] randomization failure!", i);
      end
    endfunction
  endclass
endpackage




