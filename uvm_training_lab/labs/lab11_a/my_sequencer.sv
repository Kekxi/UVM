// uvm_sequencer的作用：
// 启动 sequence
// 将  sequence产生的item发送到UVM组件中(driver中)

// uvm_sequencer是拓展来的   #(my_transation)表示参数化的类
// typedef uvm_sequencer #(my_transaction) my_sequencer; 

//typedef enum uvm_sequencer #(my_transaction) my_sequencer;//参数化的类，指定sequencer传递的transaction类型

`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

class my_sequencer extends uvm_sequencer #(my_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(my_sequencer)
endclass

`endif


