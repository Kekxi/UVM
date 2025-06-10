// 测试案例 testcase 
// 实例化和配置env
// 配置需要启动sequence

class my_test extends uvm_tset;
    `uvm_component_utils(my_test)

    my_env m_env;

    function new(string name= "",uvm_component parent);
        super.new(name,parent);
    endfunction

     virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
                            //创建env对象
        m_env = my_env::type_id::create("m_env",this);

        //使用uvm_config机制配置agent sequencer的default_sequence
        uvm_config_db#(uvm_object_wrapper)::set(
                            this,  "*.m_seqr.run_phase",
                            "default_sequence",my_sequencer::get_type());  
    endfunction
            //在start_of_simulation_phase中打印本平台的结构
    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass