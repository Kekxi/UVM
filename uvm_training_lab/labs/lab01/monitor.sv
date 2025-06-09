//monitor的主要功能是监视接口信号
//该monitor的功能就是每过100个时间单位就打印一条信息，没有监视接口信号，也没有与其他组件进行联系
class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)
    function new(string name= "my_monitor",uvm_component parent)
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("MON_RUN_PHASE","Montior run",UVM_MEDIUM)
            #100;
        end
    endtask

endclass