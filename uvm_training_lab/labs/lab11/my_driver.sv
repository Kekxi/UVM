// driver 驱动器
// 主要职能有三个：
// 从sequencer获取transaction
// 将transaction 分解为DUT可以接受的PIN级信号
// 将转化之后的PIN级信号按照DUT总线协议的方式驱动给DUT

class my_driver extends uvm_driver #(my_transaction);
    `uvm_component_utils (my_driver)

    `uvm_register_cb(my_driver,driver_base_callback);

    virtual dut_interface m_vif; // 声明接口的句柄
    int unsigned pad_cycles;

    function new(string name= "my_driver",uvm_component parent);
        super.new(name,parent);
    endfunction
                
    virtual task pre_reset_phase(uvm_phase phase);
        super.pre_reset_phase(phase);
        `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
        phase.raise_objection(this);
        m_vif.driver_cb.frame_n <= 'x;
        m_vif.driver_cb.valid_n <= 'x;
        m_vif.driver_cb.din     <= 'x;
        m_vif.driver_cb.reset_n <= 'x;
        phase.drop_objection(this);
    endtask
                
    virtual task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
        phase.raise_objection(this);
        m_vif.driver_cb.frame_n <= '1;
        m_vif.driver_cb.valid_n <= '1;
        m_vif.driver_cb.din     <= '0;
        m_vif.driver_cb.reset_n <= '1;
        repeat(5) @(m_vif.driver_cb);
        m_vif.driver_cb.reset_n <= '0;
        repeat(5) @(m_vif.driver_cb);
        m_vif.driver_cb.reset_n <= '1;
        phase.drop_objection(this);
    endtask

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //从上一层获取配置
        if(!uvm_config_db#(int unsigned)::get(this,"","pad_cycles",pad_cycles)) begin
            `uvm_fatal("CONFIG_ERROR","Driver can not get the pad_cycles !!!")
        end
        $display("pad_cycles = %0d",pad_cycles);

        if(!uvm_config_db#(virtual dut_interface)::get(this,"","vif",m_vif)) begin
            `uvm_fatal("CONFIG_ERROR","Driver can not get the interface !!!")
        end

    endfunction

    virtual task run_phase(uvm_phase phase);
        logic [7:0] temp;
        repeat(15) @(m_vif.driver_cb);

        forever begin
            //从sequencer中获取transaction
            seq_item_port.get_next_item(req);           
            `uvm_info("DRV_RUN_PHASE",req.sprint(),UVM_MEDIUM)
            // 使用宏来调用callback方法
            `uvm_do_callbacks(my_driver, driver_base_callback, pre_send(this));

            //Send address
            m_vif.driver_cb.frame_n[req.sa] <= 1'b0;
            for(int i=0; i<4; i++) begin
                m_vif.driver_cb.din[req.sa] <= req.da[i];
                @(m_vif.driver_cb);
            end
            //Send pad
            m_vif.driver_cb.din[req.sa] <= 1'b1;
            m_vif.driver_cb.valid_n[req.sa] <= 1'b1;
            repeat(pad_cycles) @(m_vif.driver_cb);

            //Send payload
            while (!m_vif.driver_cb.busy_n[req.sa]) @(m_vif.driver_cb);
            foreach(req.payload[index])  begin
                temp = req.payload[index];
                for(int i=0; i<8; i++) begin
                    m_vif.driver_cb.din[req.sa]      <= temp[i];
                    m_vif.driver_cb.valid_n[req.sa]  <= 1'b0;
                    m_vif.driver_cb.frame_n[req.sa]  <= ((req.payload.size()-1) == index) && (i==7);
                    @(m_vif.driver_cb);
                end
            end
            m_vif.driver_cb.valid_n[req.sa] <= 1'b1;

            //产生响应并关联事务
            rsp = my_transaction::type_id::create("rsq");
            $cast(rsp,req.clone());
            rsp.set_id_info(req);
            seq_item_port.put_response(rsp);

            seq_item_port.item_done();   

            `uvm_do_callbacks(my_driver, driver_base_callback, post_send());
        end
    endtask
endclass