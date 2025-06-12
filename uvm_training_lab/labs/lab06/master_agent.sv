// 将sequencer、diver、monitor封装
// agent中需要实例化sequencer、diver、monitor对象并将sequencer和diver连接起来
// agent有active和passive之分。 passive只包含monitor。

class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent)
    //声明句柄
    my_sequencer m_seqr;
    my_driver    m_driv;
    my_monitor   m_moni;

    agent_config m_agent_cfg;

    function new(string name= "",uvm_component parent);
        super.new(name,parent);
    endfunction
    //build_phase() 和sequencer、driver、monitor的实例在这里创建
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //从上一层获取配置
        if(!uvm_config_db#(agent_config)::get(this,"","m_agent_cfg",m_agent_cfg)) begin
            `uvm_fatal("CONFIG_ERROR","tese can not get the configuration !!!")
        end

        is_active = m_agent_cfg.is_active;

        uvm_config_db #(int unsigned)::set(this,"m_drive","pad_cycles",m_agent_cfg.pad_cycles);
        uvm_config_db #(virtual dut_interface)::set(this,"m_drive","vif",m_agent_cfg.m_vif);
        //区别lab05
        uvm_config_db #(virtual dut_interface)::set(this,"m_moni","vif",m_agent_cfg);

        if(is_active == UVM_ACTIVE) begin
            //使用UVM的factory机制创建对象 
            m_seqr = my_sequencer::type_id::create("m_seqr",this);
            m_driv = my_driver::type_id::create("m_driv",this);
        end
        m_moni = my_monitor::type_id::create("m_moni",this);
    endfunction
    //connect_phase()将driver和sequencer的端口相连接 执行通信
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(is_active == UVM_ACTIVE) 
            m_driv.seq_item_port.connect(m_seqr.seq_item_export);
      endfunction

endclass