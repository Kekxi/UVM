class my_sequence_lib extends uvm_sequence_library #(my_transaction);
    `uvm_object_utils(my_sequence_lib)

    `uvm_sequence_library_utils(my_sequence_lib)

    function new(string name="my_sequence_lib");
        super.new(name);
        //在sequence library被实例化时 初始化该sequence library
        init_sequence_library();
    endfunction

endclass


class sa6_sequence extends my_sequence;

    `uvm_object_utils(sa6_sequence)
    `uvm_add_to_seq_lib(sa6_sequence, my_sequence_lib)

    function new(string name="sa6_sequence");
        super.new(name);
    endfunction

    my_transaction tr;
    int item_num = 10;    

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num);
    endfunction

    virtual task body();

        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(item_num) begin
            tr = my_transaction::type_id::create("tr");
            start_item(tr);
            tr.randomize() with (tr.sa == 6); // sa6_sequence special
            finish_item(tr);        
            get_response(rsp);
            `uvm_info("SEQ",{"\n","Sequence get the response:\n",rsp.sprint()},UVM_MEDIUM)
        end

    endtask

endclass


class da3_sequence extends my_sequence;

    `uvm_object_utils(da3_sequence)
    `uvm_add_to_seq_lib(da3_sequence, my_sequence_lib)

    function new(string name="da3_sequence");
        super.new(name);
    endfunction

    my_transaction tr;
    int item_num = 10;    

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num);
    endfunction

    virtual task body();

        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(item_num) begin
            tr = my_transaction::type_id::create("tr");
            start_item(tr);
            tr.randomize() with (tr.da == 3); // da3_sequence special
            finish_item(tr);        
            get_response(rsp);
            `uvm_info("SEQ",{"\n","Sequence get the response:\n",rsp.sprint()},UVM_MEDIUM)
        end

    endtask

endclass


class sa6__da3_sequence extends my_sequence;

    `uvm_object_utils(sa6__da3_sequence)
    `uvm_add_to_seq_lib(sa6__da3_sequence, my_sequence_lib)

    function new(string name="sa6__da3_sequence");
        super.new(name);
    endfunction

    my_transaction tr;
    int item_num = 10;    

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num);
    endfunction

    virtual task body();

        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(item_num) begin
            tr = my_transaction::type_id::create("tr");
            start_item(tr);
            tr.randomize() with {(tr.sa == 6) && (tr.da == 3)}; // sa6__da3_sequence special
            finish_item(tr);        
            get_response(rsp);
            `uvm_info("SEQ",{"\n","Sequence get the response:\n",rsp.sprint()},UVM_MEDIUM)
        end

    endtask

endclass