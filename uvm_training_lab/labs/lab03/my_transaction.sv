//定义transaction
class my_transaction extends uvm_sequence_item;  //从uvm_sequence_item拓展
    rand bit [3:0] sa;
    rand bit [3:0] da;
    rand reg [7:0] payload[$];
    
    //UVM 定义的一些宏
    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(sa,UVM_ALL_ON)
        `uvm_field_int(da,UVM_ALL_ON)
        `uvm_field_queue_int(payload,UVM_ALL_ON)
    `uvm_object_utils_end

    //约束项
    constraint Limit{
        sa inside {[0:15]};
        da inside {[0:15]};
        payload.size() inside {[2:4]};
    }

    //实例化函数
    function new(string name = "my_transaction");
        super.new(name);
    endfunction
endclass    