// 测试案例 testcase 
// 实例化和配置env
// 配置需要启动sequence

class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_env m_env;
    env_config m_env_cfg;

    function new(string name= "",uvm_component parent);
        super.new(name,parent);
        m_env_cfg = new("m_env_cfg");
    endfunction

     virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
                            //创建env对象
        m_env = my_env::type_id::create("m_env",this);

        //使用uvm_config机制配置agent sequencer的default_sequence
        uvm_config_db#(uvm_object_wrapper)::set(
                            this,  "*.m_seqr.run_phase",
                            "default_sequence",my_sequence::get_type());  

        uvm_config_db#(int)::set(this,"*.m_seqr","item_num",20);
        //为配置对象的成员赋值
        m_env_cfg.is_coverage = 1; 
        m_env_cfg.is_check  = 1;
        m_env_cfg.m_agent_cfg.is_active  = UVM_ACTIVE;
        m_env_cfg.m_agent_cfg.pad_cycles = 10;
        //从顶层获取virtual interface   
        if(!uvm_config_db#(virtual dut_interface)::get(
            this,"","top_if",m_env_cfg.m_agent_cfg.m_vif)) begin
                `uvm_fatal("CONFIG_ERROR","tese can not get the interface !!!")
            end
        //将配置对象配置给env  
        uvm_config_db #(env_config) ::set(
                this,"m_env","env_cfg",m_env_cfg);

    endfunction
            //在start_of_simulation_phase中打印本平台的结构
    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass