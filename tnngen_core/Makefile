.PHONY: clean
clean:
	rm -rf ./out_rtl/ ./out_test/ yosys_synth/  __pycache__ uut.vcd a.out*
	find . -maxdepth 1 -type d | grep "./" | xargs -I {} make clean -C {}
