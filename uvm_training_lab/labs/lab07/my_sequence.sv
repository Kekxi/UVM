class my_sequence extends uvm_sequence #(my_transaction); // #(my_transation)参数化的类 指定sequence所产生的transaction的类型
    `uvm_object_utils (my_sequence)

    int item_num = 10; //添加控制变量
    function new(string name = "my_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer,"","item_num",item_num); //使用get()获取控制变量item_num的配置
    endfunction

    virtual task body(); //sequence中最重要的部分是body()任务 
    my_transaction tr;
    if(starting_phase != null)
        starting_phase.raise_objection(this);
    repeat(item_num)  begin
        // `uvm_do(req) //uvm内建的宏，用来产生transaction。每调用一次产生一个transaction
        tr = my_transaction::type_id::create("tr");
        start_item(tr);
        tr.randomize();
        finish_item(tr);
        //获取响应
        get_response(rsp);
        `uvm_info("SEQ",{"\n","Sequence get the response:\n",rsp.sprint()},UVM_MEDIUM)
    end
    #100;
    endtask

endclass
