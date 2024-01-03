all: update_v update_playground restart_playground restart_nginx

.PHONY: update_v update_playground restart_playground restart_nginx status

update_v: 
	date; cd ~/v/ && git pull && make && v -prod -cc gcc -o vprod cmd/v && mv vprod v && v -prod -cc gcc cmd/tools/vfmt.v && v -prod -cc gcc cmd/tools/vdoctor.v && v -prod -cc gcc cmd/tools/vtest.v

update_playground:
	date; cd ~/playground && git pull && v -cc gcc -g -keepc -skip-unused server/

restart_playground:
	date; cd ~/playground && sudo service playground restart

restart_nginx:
	sudo /etc/init.d/nginx restart

status:
	systemctl --no-pager status playground -l
	systemctl --no-pager status nginx -l

install_crontab:
	crontab ./crontab
