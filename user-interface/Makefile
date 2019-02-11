build:
		npm run build

registry:
		docker build -t eu.gcr.io/my-project-tattoor/user-interface:latest .
		gcloud docker -- push eu.gcr.io/my-project-tattoor/user-interface:latest

deploy:
	npm run build
	sed "s/{{ UPDATED_AT }}/$(shell date)/g" ./deployments/deployment.tmpl > ./deployments/deployment.yml
	git add --all
	git diff-index --quiet HEAD || git commit -a -m 'fix'
	git push origin master
	docker build -t eu.gcr.io/my-project-tattoor/user-interface:latest .
	gcloud docker -- push eu.gcr.io/my-project-tattoor/user-interface:latest
	kubectl replace -f ./deployments/deployment.yml