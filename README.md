 SFLL-HD is a tool (executable) that implements Stripped Functionality Logic Locking.



------------
Directory Structure (required): 

/Code

/Data

/Results

---------

Instructions: 
1. Dependencies

	a. Python Bitstring  module (install the module and comment line 7 in SFLL_HD.py)
	
	b. synopsys dc compiler (for synthesizing the gate level netlist)
	
	c. NangateOpenCellLibrary (change target_library and link_library path in the file "Code/rtl.tcl" )
	
	d. ABC logic synthesis tool (Available: https://people.eecs.berkeley.edu/~alanmi/abc/)
	

2. Load the bench-format circuit(s) to lock (encrypt) in "Data" directory 

3. In the "Code" dirctory, run ./SFLL_HD (params: circuit_name.bench, keysize, h)
 
In the example below: circuit_name = c7552.bench, keysize= 32, Hamming distance h=1  

	./SFLL_HD c7552.bench	32	1  > log_c7552_32_1   
	
The locked circuit will be created in the "Results" directory 




Cite: 


Yasin, Muhammad, Abhrajit Sengupta, Mohammed Thari Nabeel, Mohammed Ashraf, Jeyavijayan JV Rajendran, and Ozgur Sinanoglu. "Provably-secure logic locking: From theory to practice." In Proceedings of ACM SIGSAC Conference on Computer and Communications Security, pp. 1601-1618. ACM, 2017.







