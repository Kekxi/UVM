// driver 驱动器
// 主要职能有三个：
// 从sequencer获取transaction
// 将transaction 分解为DUT可以接受的PIN级信号
// 将转化之后的PIN级信号按照DUT总线协议的方式驱动给DUT

class my_driver extends uvm_driver #(my_transaction);
    `uvm_component_utils (my_driver)
//                                         uvm_component parent 在实例化时要指定其父对象
    function new(string name= "my_driver",uvm_component parent);
        super.new(name,parent);
    endfunction
                //run_phase()是driver的主要方法
    virtual task run_phase(uvm_phase phase);
        forever begin
            //从sequencer中获取transaction
            seq_item_port.get_next_item(req);
                                    //req.sprint()将获取的transaction打印出来
            `uvm_info("DRV_RUN_PHASE",req.sprint(),UVM_MEDIUM)
            #100;
            //通知sequencer该事务已经处理完毕
            seq_item_port.item_done();
        end
    endtask
endclass