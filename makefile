malicious:
	mkdir -p malicious



antivirus: malicious 
	./antivirusd.sh dir malicious 5

restore: malicious 
	./restore.sh dir malicious