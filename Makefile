commit:
	git add .
	@echo "Please write the commit message: "; \
    read MESSAGE ;\
	git commit -m "$$MESSAGE"
	git push