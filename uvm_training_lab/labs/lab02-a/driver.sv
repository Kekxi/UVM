// driver 驱动器
// 主要职能有三个：
// 从sequencer获取transaction
// 将transaction 分解为DUT可以接受的PIN级信号
// 将转化之后的PIN级信号按照DUT总线协议的方式驱动给DUT

class my_driver extends uvm_driver #(my_transcation);
    `uvm_component_utils (my_driver)
//  uvm_component parent 在实例化时要指定其父对象
    function new(string name= "my_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    // reset_phase 先于 configure_phase执行
    virtual task reset_phase(uvm_phase phase);
        // 必须在执行消耗仿真时间之前raise_objection 才能保证info执行
        // phase.raise_objection(this);
        #100;
        `uvm_info("DRV_RESET_PHASE","Now driver reset the DUT ...",UVM_MEDIUM)
        // 如果不加drop_objection会导致下面的configure_phase无法执行
        // phase.drop_objection(this);
    endtask

    //添加raise_objection 和drop_objection才能保证info语句被执行
    virtual task configure_phase(uvm_phase phase);
        phase.raise_objection(this);
        #100;
        `uvm_info("DRV_CONFIGURE_PHASE","Now driver config the DUT ...",UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
                //run_phase()是driver的主要方法
    virtual task run_phase(uvm_phase phase);
        #3000;
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