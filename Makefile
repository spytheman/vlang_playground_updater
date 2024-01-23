all:    update_v update_playground restart_playground restart_nginx

.PHONY: update_v update_playground restart_playground restart_nginx status install_crontab

update_v: 
	date; cd ~/v/ && git pull && nice make && v cmd/tools/vfmt.v && v cmd/tools/vdoctor.v && v cmd/tools/vtest.v

update_playground:
	date; cd ~/playground && git pull && v -g -keepc -skip-unused -d trace_request_url server/

restart_playground:
	date; cd ~/playground && sudo service playground restart

restart_nginx:
	sudo /etc/init.d/nginx restart

status:
	systemctl --no-pager status playground -l
	systemctl --no-pager status nginx -l

install_crontab:
	crontab ./crontab
