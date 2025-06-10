program automatic test;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "transaction.sv"
    `include "sequence.sv"
    `include "sequencer.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "agent.sv"
    `include "environment.sv"
    `include "testcase.sv"
    `include "transaction_da3.sv"
    `include "testcase_da3.sv"
    
    initial begin
        run_test("testcase_da3");
    end

endprogram
