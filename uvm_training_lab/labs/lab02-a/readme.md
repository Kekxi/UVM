UVM package 包含三个主要的类

1. uvm_component 
    用来构建UVM testbench层次结构最基本的类

2. uvm_object
    作为UVM的一种数据结构，可作为配置对象来配置测试平台

3. uvm_transcation
    用来产生激励和收集响应。

本实验为1.uvm_component
  平台组件拓展于uvm_component
  组件包含了task和function phases
  通过parent传递对象句柄 层层构建uvm结构树

  uvm_component 包含：  uvm_test uvm_env uvm_agent uvm_driver uvm_sequencer  uvm_monitor  uvm_scoreboard