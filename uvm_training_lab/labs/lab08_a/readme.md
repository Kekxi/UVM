set函数配置资源 
 uvm_config_db#(int)::set(my_sequencer,"","item_num",item_num); //四个参数 详见飞书

 uvm_config_db#(int)::get(my_sequencer,"","item_num",item_num);



1.配置sequence产生transaction数量

2.配置interface

3.传递对象