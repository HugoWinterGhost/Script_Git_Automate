#!/bin/bash

welcomeBashScript() {
    echo "### Script Bash pour automatiser les commandes Git :) ###"
    read -p "Veuillez rentrer un email : " -n 100 mail
    read -p "Veuillez saisir un nom d'utilisateur : " -n 100 userName
    git config --global user.email "$mail"
    git config --global user.name "$userName"

    echo "Quelle fonction souhaitez vous executer (1/2)
(1 : sendFilesToGitRepo) (2 : getLastSourceFromGitRepo)" 
    read -p "votre réponse (1/2) : " -n 2 functionName
    if [ $functionName = "1" ]
    then
        echo $functionName
        sendFilesToGitRepo
    elif [ $functionName = "2" ]
    then
        echo $functionName
        getLastSourceFromGitRepo
    else
        exit
    fi
}

sendFilesToGitRepo() {
	git status 
	read -p "Souhaitez vous continuer (y/n) : " -n 2 scriptProgressAnswer
	echo $scriptProgressAnswer
    if [ $scriptProgressAnswer = "y" ]
    then
	    git add .
	    git status
	    read -p "Veuillez rentrer un nom de commit : " -n 100 commitName
        echo $commitName
        git commit -m "$commitName"
        read -p "Sur quelle branche souhaitez vous mettre vos modifications : " -n 100 branchName
        echo $branchName
        git push origin $branchName
        git log --oneline -n 5 
    else
        exit
    fi
}

getLastSourceFromGitRepo() {
    read -p "Quelle branche souhaitez vous mettre a jour : " -n 100 branchName
    echo $branchName
    git checkout $branchName
    git fetch origin
    git rebase origin
    git pull origin $branchName
    git log --oneline -n 5
    read -p "Souhaitez vous continuer (y/n) : " -n 2 scriptProgressAnswer
    echo $scriptProgressAnswer
    if [ $scriptProgressAnswer = "y" ]
    then
        getLastSourceFromGitRepo
    else
        exit
    fi
}

welcomeBashScript