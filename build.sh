#!/bin/bash

if [ "$1" == "dev" ]; then
        cd isentia-web
	hugo new posts/${CI_JOB_ID}.md
        fortune >> posts/${CI_JOB_ID}.md
        hugo -D
        cd -
        git config --global user.email "gitlab-ci@test.com"
 	git config --global user.name "gitlab-ci"
        git add --all
        git commit -am "Updated content for dev ${CI_JOB_ID}"
        git push -u origin master

elif [ "$1" == "staging" ]; then
	cd isentia-web
	hugo -D
        cd - 
        git config --global user.email "gitlab-ci@test.com"
 	git config --global user.name "gitlab-ci"
        git tag "v${CI_JOB_ID}"
        git add --all
        git commit -am "Updated content for staging ${CI_JOB_ID}"
        git push -u origin master 
        git push -u origin "v${CI_JOB_ID}"

else 
	exit 1
fi
