.PHONY: clean
clean:
	rm -rf !(*.py)
	find . -maxdepth 1 -type d | grep "./" | xargs -I {} make clean -C {}
