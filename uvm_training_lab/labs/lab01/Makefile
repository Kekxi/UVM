UVM_HOME = /home/zhangqi/synopsys/vcs/O-2018.09-SP2/etc/uvm-1.2


all: clean compile sim

compile:
	$(VCS) +incdi+. top_tb.sv

sim:
	$(SIMV)

VCS = vcs -full64 -debug_access+all -cpp g++ -cc gcc -LDFLAGS -Wl,--no-as-needed -sverilog -debug_all -timescale=1ns/1ps  +acc +vpi +define+UVM_OBJECT_MUST_HAVE_CONSTRUCOR +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -f filelist.f

#VCS1 = vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -sverilog -debug_all -timescale=1ns/1ps  +acc +vpi +define+UVM_OBJECT_MUST_HAVE_CONSTRUCOR +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv $(UVM_HOME)/src/dpi/uvm_dpi.cc +define+UVM_NO_DPI $(UVM_HOME)/src/uvm_pkg.sv top_tb.sv

SIMV = ./simv -l vcs.log

URG = urg -format test -dir simv.vdb

CHECK = \
	@$(TEST) \(`grep -c `UVM_ERROR: $(N_ERRS)'vcs.log` -eq 1\) -a \
		 \(`grep -c `UVM_FATAL: $(N_FATALS)' vcs.log` -eq 1\)

clean:
	rm -rf *~ core csrc simv* vc_hdrs.h ucli.key urg* *.log

dve:
	dve&
