malicious:
	mkdir -p malicious
whitelist:
	mkdir -p whitelist
antivirus: malicious whitelist 
	./antivirusd.sh dir malicious 5

restore: malicious whitelist
	./restore.sh dir malicious