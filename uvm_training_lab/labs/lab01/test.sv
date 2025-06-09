program automatic test;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "transcation.sv"
    `include "sequence.sv"
    `include "sequencer.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "environment.sv"
    `include "agent.sv"
    `include "testcase.sv"
    
    initial begin
        run_test();
    end

endprogram
