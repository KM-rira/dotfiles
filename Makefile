.PHONY: vscode

vscode:
	@sed -n '/# start/,/# end/ { \
		/# start/b; \
		/# end/b; \
		p; \
	}' sample.txt > copy.txt
