// 将sequencer、diver、monitor封装
// agent中需要实例化sequencer、diver、monitor对象并将sequencer和diver连接起来
// agent有active和passive之分。 passive只包含monitor。

class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent)
    //声明句柄
    my_sequencer m_seqr;
    my_driver    m_driv;
    my_monitor   m_moni;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction
    //build_phase() 和sequencer、driver、monitor的实例在这里创建
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE) begin
            //使用UVM的factory机制创建对象 
            m_seqr = my_sequencer::type_id::create("m_seqr", this);
            m_driv = my_driver::type_id::create("m_driv", this);
        end
        m_moni = my_monitor::type_id::create("m_moni", this);
    endfunction
    //connect_phase()将driver和sequencer的端口相连接 执行通信
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(is_active == UVM_ACTIVE) 
            m_driv.seq_item_port.connect(m_seqr.seq_item_export);
      endfunction

endclass