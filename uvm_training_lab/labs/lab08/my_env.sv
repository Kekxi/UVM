// environment 包含测试平台的所有组件 
class  my_env extends uvm_env;
    `uvm_component_utils(my_env)

    master_agent m_agent;
    env_config m_env_cfg;
    my_reference_model ref_model;

    function new(string name= "",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //从上一层获取配置
        if(!uvm_config_db#(env_config)::get(this,"","env_cfg",m_env_cfg)) begin
            `uvm_fatal("CONFIG_ERROR","tese can not get the interface !!!")
        end

        uvm_config_db #(agent_config)::set(
            this,"m_agent","m_agent_cfg",m_env_cfg.m_agent_cfg);

        if(m_env_cfg.is_coverage) begin
            `uvm_info("COVERAGE_ENABLE","The function coverage is enabled for this testcase",UVM_MEDIUM)
        end

        if(m_env_cfg.is_check) begin
            `uvm_info("CHECK_ENABLE","The check function is enabled for this testcase",UVM_MEDIUM)
        end

        m_agent = master_agent::type_id::create("m_agent",this);
        ref_model = my_reference_model::type_id::create("ref_model",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ENV","Connect the agent and reference model ...",UVM_MEDIUM)
        m_agent.m_a2r_export.connect(ref_model.i_m2r_imp);
    endfunction
endclass