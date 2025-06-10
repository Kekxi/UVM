//创建sequence 
// 当transaction类创建好之后，需要通过某种方式来创建对象
// sequence 需要从uvm_sequence拓展
// sequence 控制并产生一系列transation
// 一种sequence 一般只用来产生一种类型的transation
// sequence中最重要的部分是body()任务
class my_sequence extends uvm_sequence #(my_transaction); // #(my_transation)参数化的类 指定sequence所产生的transaction的类型
    `uvm_object_utils (my_sequence)
    function new(string name = "my_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    virtual task body(); //sequence中最重要的部分是body()任务 
    repeat(10)  begin
        `uvm_do(req) //uvm内建的宏，用来产生transaction。每调用一次产生一个transaction
    end
    #100;
    if(starting_phase != null)
        starting_phase.drop_objection(this);
    endtask

endclass
