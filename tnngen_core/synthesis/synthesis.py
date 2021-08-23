import os
import sys
import subprocess
import pathlib
import shlex
from rich.console import Console 

console = Console()

class synth_support:

	def __init__(self, file_v = None, sv = False, name = None, output = None, lib_path = None, std_lib = None, std_lef = None, std_qrc = None):
		
		if file_v is None:
			raise ValueError("Verilog file arg is missing")
		else:
			self.file_v = file_v
		
		self.lib_path = lib_path
		self.lib = std_lib
		self.lef= std_lef
		self.qrc = std_qrc
		self.name = name
		self.sv = sv
		
		if output is None:
			self.output = os.path.join(pathlib.Path.cwd(),'synth', self.name)
		else:
			self.output = os.path.join(pathlib.Path.cwd(), output, self.name)
		
		if not os.path.exists(self.output):
			os.makedirs(os.path.join(self.output))
			
	def gen_ys_template(self):

		if not os.path.exists(self.output):
				os.makedirs(self.output)

		graph = input("Show design netlist graph; select ''yes'' or ''no'' ") or 'yes'
		console.print("[bold magenta]  -> Selected "+graph)
		# yosys script
		l1 = "\nread_verilog "+self.file_v
		l2 = "\nhierarchy -top "+self.name
		if graph == 'yes':
			l3 = "\nproc; fsm; opt; memory; opt"+"\nshow"
		else:
			l3 = "\nproc; fsm; opt; memory; opt"
		l4 = "\ntechmap; opt"
		l5 = "\ndfflibmap -liberty"
		l6 = "\nabc -liberty"
		l7 = "\nstat -liberty"
		for lib in self.lib:
			l5 = l5+" "+lib
			l6 = l6+" "+lib
			l7 = l7+" "+lib
		l8 = "\nwrite_verilog "+self.file_v
		l9 = "\nclean"

		# file io
		f = open(os.path.join(self.output,'out_synth.ys'), 'w')
		f.writelines([l1, l2, l3, l4, l5, l6, l7, l8, l9])
		f.close() 

	def _exec_ys(self):
		print('\nInitiating Yosys Synthesis')
		cmd = []
		cmd.append('yosys')
		cmd.append(file_v)
		cmd = ' '.join(cmd)
		proc = subprocess.Popen(cmd, shell = True, cwd = './'+self.output, stdout = subprocess.PIPE)
		dis = []
		
		while True:
			data = proc.stdout.readline()
			out = data.decode(sys.getdefaultencoding())
			dis.append(out)
			print(out, end = '')
			if not data:
				break
				
		proc.wait()
		proc.stdout.close()
		dis = ''.join(dis)

	# expand later

	def gen_genus_tcl(self, if_clk = None):
		
		print("\nProvide Tcl file parameters below\n_______________________________________________________")
		gen_eff = input("Synthesis to Generic effort (low, medium or high): ") or 'medium'
		console.print("[bold blue]  -> Selected GEN_EFF: "+gen_eff)
		map_opt_eff = input("Mapping Optimization Effort (low, medium or high): ") or 'medium'
		console.print("[bold blue]  -> Selected MAP_OPT_EFF: "+map_opt_eff)
		lp_clk_gating = input("Enable low power clock gating (yes or no): ") or 'yes'
		console.print("[bold blue]  -> Low power clock gating enabled?: "+gen_eff)
		lp_power_analysis_effort = input("Low power analysis effort (low, medium or high): ") or 'medium'
		console.print("[bold blue]  -> Low power analysis effort: "+lp_power_analysis_effort)
		max_cpus_per_server = input("Max # CPUs per server: ") or None
		if max_cpus_per_server is not None:
			console.print("[bold blue]  -> Selected # CPUs per server: "+max_cpus_per_server)
		lp_default_toggle_rate = input("Low power toggle rate: ") or '0.00002'
		console.print("[bold blue]  -> Selected low power toggle rate: "+lp_default_toggle_rate)
		lec = input("Produce .lec files for conformal checks? (yes or no): ") or 'no'
		console.print("[bold blue]  -> Generate .lec files?: "+gen_eff)

		if not os.path.exists(self.output):
				os.makedirs(self.output)
		
		if max_cpus_per_server is None:
			pass
		else:
			try:
				int(max_cpus_per_server)
			except TypeError:
				print("max_cpus_per_server should be in %d format")
			if int(max_cpus_per_server) not in range(1, 33):
				raise ValueError("For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs")
		
		if isinstance(gen_eff, str) is False:
			raise TypeError("GEN_EFF should be in %s format")
		elif gen_eff not in ('low', 'medium', 'high') is True:
			raise ValueError("GEN_EFF should be low, medium or high")
		
		if isinstance(map_opt_eff, str) is False:
			raise TypeError("MAP_OPT_EFF should be in %s format")
		elif map_opt_eff not in ('low', 'medium', 'high') is True:
			raise ValueError("MAP_OPT_EFF should be low, medium or high")
		
		if isinstance(lp_power_analysis_effort, str) is False:
			raise TypeError("lp_power_analysis_effort should be in %s format")
		elif lp_power_analysis_effort not in ('low', 'medium', 'high') is True:
			raise ValueError("lp_power_analysis_effort should be low, medium or high")
		
		if lp_default_toggle_rate is None:
			pass
		else:
			try:
				float(lp_default_toggle_rate)
			except TypeError:
				print("lp_default_toggle_rate should float value")
			
		if isinstance(lp_clk_gating, str) is False:
			raise TypeError("lp_clk_gating should be of type %s")
		elif lp_clk_gating not in ('yes', 'no'):
			raise ValueError("yes or no are the only valid inputs")
		
		if isinstance(lec, str) is False:
			raise TypeError("lec should be of type %s")
		elif lec not in ('yes', 'no'):
			raise ValueError("yes or no are the only valid inputs")
			
		# file io
		tcl_path = os.path.join(self.output,self.name+".tcl")
		f = open(tcl_path, 'w')
		line = []
				
		line.append("\nif {[file exists /proc/cpuinfo]} {")
		line.append("\n  sh grep \"model name\" /proc/cpuinfo")
		line.append("\n  sh grep \"cpu MHz\" /proc/cpuinfo \n}")
		line.append("\nputs \"Hostname : [info hostname]\"")
		
		line.append("\n\n## Preset global variables and attributes")
		
		line.append("\nset DESIGN "+self.name)
		line.append("\nset GEN_EFF "+gen_eff)
		line.append("\nset MAP_OPT_EFF "+map_opt_eff)
		line.append("\nset DATE [clock format [clock seconds] -format \"%b%d-%T\"]") 
		line.append("\nset _OUTPUTS_PATH "+self.output+"/"+"/output")
		line.append("\nset _REPORTS_PATH "+self.output+"/"+"/report")
		line.append("\nset _LOG_PATH "+self.output+"/"+"/log")
		# l_new = "\nset_db / .init_lib_search_path {"
		# for lib in self.lib_path:
			# l_new = l_new+lib+" "	
		# l_new = l_new+"}"
		# line.append(l_new)
		#line.append("\nset_db / .script_search_path {"+self.output+"}")
		#line.append("\nset_db / .init_hdl_search_path {"+self.file_v+"}")
		if  max_cpus_per_server:
			line.append("\nset_db / .max_cpus_per_server "+max_cpus_per_server)
		line.append("\nset_db / .information_level 7") 
		line.append("\nset_db auto_ungroup none")
		
		line.append("\n\n## Library setup")
		
		if self.lib:
			l1 = "\nread_libs \" \ "
			for lib in self.lib:
				l1 = l1+"\n"+lib+" \ "
			l1 = l1+" \""
			line.append(l1)
		
		if self.lef:
			l2 = "\nread_physical -lef \""
			for lef in self.lef:
				l2 = l2+" "+lef
			l2 = l2+" \""
			line.append(l2)
		if self.qrc:
			l3 = "\nread_qrc "
			for qrc in self.qrc:
				l3 = l3+" "+qrc
			l3 = l3+" \""
			line.append(l3)
		
		line.append("\nset_db / .hdl_generate_index_style %s_%d_")
		if lp_clk_gating == 'yes':
			line.append("\nset_db / .lp_insert_clock_gating true")
		else:
			line.append("\nset_db / .lp_insert_clock_gating false")
		
		line.append("\n\n## Load Design")
		
		if self.sv is False:
			line.append("\nread_hdl "+self.file_v)
		else:
			line.append("\nread_hdl -language sv "+self.file_v)
		
		line.append("\nelaborate $DESIGN")
		line.append("\nputs \"Runtime & Memory after \'read_hdl\'\"")
		line.append("\ntime_info Elaboration")
		line.append("\ncheck_design -unresolved")
		
		line.append("\n\n## Constraints Setup")
		
		if if_clk is not None:
			line.append("\nread_sdc "+self.output+"/chip.sdc")
		line.append("\nputs \"The number of exceptions is [llength [vfind \"design:$DESIGN\" -exception *]]\"")

		line.append("\nif {![file exists ${_LOG_PATH}]} {\n  file mkdir ${_LOG_PATH} \n  puts \"Creating directory ${_LOG_PATH}\"\n}")
		line.append("\n\nif {![file exists ${_OUTPUTS_PATH}]} {\n  file mkdir ${_OUTPUTS_PATH}\n  puts \"Creating directory ${_OUTPUTS_PATH}\"\n}")
		line.append("\n\nif {![file exists ${_REPORTS_PATH}]} {\n  file mkdir ${_REPORTS_PATH}\n  puts \"Creating directory ${_REPORTS_PATH}\"\n}")
		line.append("\ncheck_timing_intent")
		
		line.append("\n\n## Define cost groups (clock-clock, clock-output, input-clock, input-output)")
		
		line.append("\nif {[llength [all_registers]] > 0} {") 
		line.append("\n  define_cost_group -name I2C -design $DESIGN")
		line.append("\n  define_cost_group -name C2O -design $DESIGN")
		line.append("\n  define_cost_group -name C2C -design $DESIGN")
		line.append("\n  path_group -from [all_registers] -to [all_registers] -group C2C -name C2C")
		line.append("\n  path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O")
		line.append("\n  path_group -from [all_inputs]  -to [all_registers] -group I2C -name I2C\n}")
		line.append("\n\ndefine_cost_group -name I2O -design $DESIGN")
		line.append("\npath_group -from [all_inputs]  -to [all_outputs] -group I2O -name I2O")
		
		line.append("\n\n## Synthesizing to generic")
		
		line.append("\nset_db / .syn_generic_effort $GEN_EFF")
		line.append("\nsyn_generic")
		line.append("\nputs \"Runtime & Memory after \'syn_generic\'\"")
		line.append("\ntime_info GENERIC")
		if lp_power_analysis_effort:
			line.append("\nset_db lp_power_analysis_effort "+lp_power_analysis_effort)
		
		line.append("\n\n## Synthesizing to gates")
		
		line.append("\nset_db / .syn_map_effort $MAP_OPT_EFF")
		line.append("\nsyn_map")
		line.append("\nputs \"Runtime & Memory after \'syn_map\'\"")
		line.append("\ntime_info MAPPED")
		line.append("\nreport_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt")
		if lp_default_toggle_rate:
			line.append("\nset_db lp_default_toggle_rate [expr "+lp_default_toggle_rate+"]")
		
		line.append("\n\n## Optimize Netlist")
		
		line.append("\nset_db / .syn_opt_effort $MAP_OPT_EFF")
		line.append("\nsyn_opt")
		line.append("\nputs \"Runtime & Memory after \'syn_opt\'\"")
		line.append("\ntime_info OPT")
		
		line.append("\n\n## write backend file set (verilog, SDC, config, etc.")
		line.append("\nreport_timing -unconstrained > $_REPORTS_PATH/${DESIGN}_timing.rpt")
		line.append("\nreport_power -verbose > $_REPORTS_PATH/${DESIGN}_power.rpt")
		line.append("\nreport_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt")
		line.append("\nwrite_snapshot -outdir $_REPORTS_PATH -tag final")
		line.append("\nreport_summary -directory $_REPORTS_PATH")
		line.append("\nwrite_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v")
		line.append("\nwrite_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script")
		line.append("\nwrite_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc")
		line.append("\nwrite_sdf -timescale ns -precision 3 > ${_OUTPUTS_PATH}/${DESIGN}_m.sdf")
		
		line.append("\n\n## write_do_lec")
		if lec:
			line.append("\nwrite_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do")
			line.append("\nwrite_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do")
		
		#line.append("\nsuspend")
		line.append("\nputs \"Final Runtime & Memory.\"")
		line.append("\ntime_info FINAL")	
		line.append("\nputs \"============================\"")
		line.append("\nputs \"Synthesis Finished .........\"")
		line.append("\nputs \"============================\"")
		line.append("\nfile copy [get_db / .stdout_log] ${_LOG_PATH}/.")
		line.append("\nquit")
		
		f.writelines(line)
		f.close()
		print("\nFinished generating .tcl file")
		
		return tcl_path
		
	def gen_genus_sdf(self, clk_name = None):
		print(clk_name)
		print("\nEnter .sdc file subfields\n_____________________________________")
		period, wave_new, waveform = [], [], []
		idx = 0
		if clk_name is None:
			pass
		else:
			if isinstance(clk_name, tuple) is True:
				for clk in clk_name:
					if clk == 'aclk':
						hw_clk = clk
					period.append(input("Enter clock period for "+clk+" (%d or %f type) : ") or '5555.5556')
					console.print("[bold blue]  -> Selected clock period for "+clk+": "+period[idx])
					waveform.append(input("Enter time for rise and fall edges for "+clk+" in %s type (only two inputs). Ex. \"0 5\" : ") or '0 5')
					console.print("[bold blue]  -> Selected rise and fall edges for "+clk+": ("+waveform[idx]+")")
					idx = idx+1
				for wave in waveform:
					wave_new.append(tuple(map(int, wave.split(' '))))
				
				if clk_name is None or not period:
					pass
				else:
					for p in period:
						try:
							float(p)
						except TypeError:
							print("Clock period should be of type %f")
		
				if not wave_new or clk_name is None:
					pass
				else:
					for wave in wave_new:
						if len(wave) != 2:
							raise ValueError("Provide two fields")
						else:
							for w in wave:
								try:
									float(w)
								except TypeError:
									print("Waveform fields should of type %d or %f")
									
			elif isinstance(clk_name, str) is True:
				hw_clk = clk_name
				period = input("Enter clock period for "+clk_name+" (%d or %f type) : ") or '5555.5556'
				console.print("[bold blue]  -> Selected clock period for "+clk_name+": "+str(period))
				waveform = input("Enter time for rise and fall edges for "+clk_name+" in %s type (only two inputs). Ex. \"0 5\" : ") or '0 5'
				console.print("[bold blue]  -> Selected rise and fall edges for "+clk_name+": ("+waveform+")")
				wave_new = tuple(map(int, waveform.split(' ')))
				
				if clk_name is None:
					pass
				else:
					try:
						float(period)
					except TypeError:
						print("Clock period should be of type %f")
		
				if clk_name is None:
					pass
				else:
					if len(wave_new) != 2:
							raise ValueError("Provide two fields")
					else:
						for wave in wave_new:
							try:
								float(wave)
							except TypeError:
								print("Waveform fields should of type %d or %f")
				
			uncertainity = input("Enter uncertainity in clock network in %f form; btw 0.0 and 1.0 : ") or '0.1'
			console.print("[bold blue]  -> Selected clock network uncertainity : "+uncertainity)
			fall_transition = input("Fall transition in %f form; btw 0.0 and 1.0 : ") or '0.15'
			console.print("[bold blue]  -> Selected fall transition: "+fall_transition)
			rise_transition = input("Rise transition in %f form; btw 0.0 and 1.0 : ") or '0.15'
			console.print("[bold blue]  -> Selected rise transition: "+rise_transition)
			ip_delay = input("Set input delay in %f form : ") or '2.0'
			console.print("[bold blue]  -> Selected input delay: "+ip_delay)
			op_delay = input("Set output delay in %f form : ") or '2.0'
			console.print("[bold blue]  -> Selected output delay: "+op_delay)
		
		set_load = input("Set the capacitive load in %f form : ") or '15.0'
		console.print("[bold blue]  -> Selected load : "+set_load)
		
		f_sdc = open(os.path.join(self.output,"chip.sdc"), 'w')
		cmd = []
		
		if clk_name is None:
			pass
		else:
			idx = 0
			l1 =""
			if isinstance(clk_name, tuple) is True:
				for clk in clk_name:
					l1 = l1+"\ncreate_clock [get_ports "+clk+"]  -period "+period[idx]
					l1 = l1+" -waveform {" 
					for w in wave_new[idx]:
						l1 = l1+str(w)+" "
					l1= l1+"}"			
					l1 = l1+" -name "+clk+"\n"
					idx = idx+1
			elif isinstance(clk_name, str) is True:
				l1 = l1+"\ncreate_clock [get_ports "+clk_name+"]  -period "+str(period)
				l1 = l1+" -waveform {" 
				l1 = l1+str(waveform)+" "
				l1= l1+"}"			
				l1 = l1+" -name "+clk_name+"\n"
			cmd.append(l1)	
			
			if uncertainity is None or clk_name is None:
				pass
			else:
				try:
					float(uncertainity)
				except TypeError:
					print("uncertainity should be of type %d or %f")
					
			if ip_delay is None or clk_name is None:
				pass
			else:
				try:
					float(ip_delay)
				except TypeError:
					print("ip_delay  should be of type %d or %f")
			
			if fall_transition is None or clk_name is None:
				pass
			else:
				try:
					float(fall_transition)
				except TypeError:
					print("fall_transition should be of type %d or %f")
			
			if rise_transition is None or clk_name is None:
				pass
			else:
				try:
					float(rise_transition)
				except TypeError:
					print("rise_transition should be of type %d or %f")
					
			if op_delay is None or clk_name is None:
				pass
			else:
				try:
					float(op_delay)
				except TypeError:
					print("op_delay should be of type %d or %f")
		
		if set_load is None:
			pass
		else:
			try:
				float(set_load)
			except TypeError:
				print("set_load should be of type %d or %f")
		
		if clk_name is not None:
			if uncertainity:
				cmd.append("\nset_clock_uncertainty "+uncertainity+" [get_clocks "+hw_clk+"]")
			if fall_transition:
				cmd.append("\nset_clock_transition -fall "+fall_transition+" [get_clocks "+hw_clk+"]")
			if rise_transition:
				cmd.append("\nset_clock_transition -rise "+rise_transition+" [get_clocks "+hw_clk+"]")
			if ip_delay:
				cmd.append("\nset_input_delay "+ip_delay+" -clock "+hw_clk+" [remove_from_collection [all_inputs] "+hw_clk+"]")
			if op_delay:
				cmd.append("\nset_output_delay "+op_delay+" -clock "+hw_clk+" [all_outputs]")
		else:
			if set_load:
				cmd.append("\nset_load "+set_load+" [all_outputs]")
		
		f_sdc.writelines(cmd)
		f_sdc.close()
		print("\nFinished generating .sdc file\n___________________________________________________")
	
	def _exec_genus(self, file = None):
		print("\nInitiating Genus Synthesis")
		cmd = []
		cmd.append('genus -f')
		cmd.append(file)
		cmd = ' '.join(cmd)
		proc = subprocess.Popen(cmd, shell = True, cwd = self.output, stdout = subprocess.PIPE)
		dis = []
		
		while True:
			data = proc.stdout.readline()
			out = data.decode(sys.getdefaultencoding())
			dis.append(out)
			print(out, end = '')
			if not data:
				break
		proc.communicate()
		proc.stdout.close()
		dis = ''.join(dis)
