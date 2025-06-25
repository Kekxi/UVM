//直接写在my_tset里面了 这样就不用添加该文件到顶层
class my_test_driver_error extends my_test;

    `uvm_component_utils(my_test_driver_error)

    driver_error_callback drv_err_cb;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void connect_phase(uvm_phase phase);

        drv_err_cb = new();
        uvm_callback #(my_driver, driver_base_callback) ::add(m_env.m_agent.my_driv, drv_err_cb);

    endfunction
endclass