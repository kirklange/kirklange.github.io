# TODO: Get this working on Windows also. (Low priority tbh.)



ifneq (, $(shell uname -s | grep -E _NT))
	CULT = windows
	OPEN = cmd //c start "${@//&/^&}"
endif
ifneq (, $(shell uname -s | grep -E Linux))
	CULT = linux
	OPEN = xdg-open
endif
ifneq (, $(shell uname -s | grep -E Darwin))
	CULT = macos
	# TODO: test on MacOS
endif



run :
	@make --no-print-directory kill >/dev/null
	jekyll serve >/dev/null &
	sleep 2s
	$(OPEN) localhost:4000

kill :
	@bash -c "if [[ -z \"$$(ps | grep jekyll)\" ]]; then \
		echo \"NOTE: No Jekyll background process found.\"; \
	else \
		echo \"SUCCESS: Killed background Jekyll process.\"; \
		pkill jekyll; \
	fi"
