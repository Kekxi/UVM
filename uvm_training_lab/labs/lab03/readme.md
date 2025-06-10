UVM factory机制

UVM工厂机制可以使用户在不更改代码的情况下实现不同对象的替换
工厂是UVM的一种数据结构。它的作用范围是整个平台空间，它有且仅有一个实例化对象(即单实例类)。它是一个多态构造器，可仅仅使用一个函数让用户实例化很多不同类型的对象。

原理
可以将UVM factory理解为两点内容：
1.包含了两张查找表
2.对这两张查找表的解释
例如 之前里面使用的宏 ：`uvm_component_utils (my_driver)

factory机制的运作步骤：
1.将用户自定义的类向factory的注册表进行注册。
2.要使用“class_name::type_id::create()”来代替new实例化对象。
3.根据具体要求向替换表添加替换条目
4.在运行仿真时，UVM会根据两张表自动实现factory机制。


`uvm_component_utils() 对uvm_component类进行注册
`uvm_object_utils()    对uvm_object类进行注册
使用宏将类注册到注册表中
 

宏的作用如下：
为注册的类创建一个代理类： type_id
     这个类在注册类的内部，起到间接实例化对象的代理作用
     创建一个注册类的对象并将对象向factory注册
     type_id内建create函数
创建一个静态函数 get_type()      //如果不使用宏注册，没有静态函数
创建一个函数 get_object_type()

factory机制要与override机制结合使用

override函数有两个（常用）：
    set_type_override_by_type(original_class_name::get_type(),     //被替换的目标类    
                               target_class_name::get_type());     // 替换对象的类型

    // 替换部分目标类
    set_inst_override_by_type( "original_inst_path",
                               original_class_name::get_type(),
                               target_class_name::get_type());

