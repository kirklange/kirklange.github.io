run :
	@make --no-print-directory kill >/dev/null
	jekyll serve >/dev/null &
	sleep 2s
	sensible-browser localhost:4000

kill :
	@bash -c "if [[ -z \"$$(ps | grep jekyll)\" ]]; then \
		echo \"NOTE: No Jekyll background process found.\"; \
	else \
		echo \"SUCCESS: Killed background Jekyll process.\"; \
		pkill jekyll; \
	fi"
