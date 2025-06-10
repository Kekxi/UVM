class my_test_da3 extends my_test;
    `uvm_component_utils(my_test_da3)

    function new(string name="",uvm_component parent);
        super.new(name,parent);
    endfunction 

    virtual function void_build_phase(uvm_phase phase);
        super.build_phase(phase); 
        set_type_override_by_type(my_transaction::get_type(),          //被替换的目标类     将my_transaction_da3替换成my_transaction
                                  my_transaction_da3::get_type());     // 替换对象的类型
    endfunction 

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        uvm_factory::get().print();
    endfunction

endclass 