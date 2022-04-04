#!/bin/bash

welcomeBashScript() {
  read -p "
Menu Commandes GIT
-------------------------------------------------------
  1 ) - Pour Cloner le Repo
  2 ) - Pour Pousser vos modifs vers le Repo
  3 ) - Pour Récupérer les sources du Repo
  4 ) - Pour Récupérer le remote du Repo
-------------------------------------------------------
Votre réponse : " -n 2 functionName
  if [ $functionName = "1" ]
  then
    echo $functionName
    cloneGitRepoFiles
  elif [ $functionName = "2" ]
  then
    echo $functionName
    sendFilesToGitRepo
  elif [ $functionName = "3" ]
  then
    echo $functionName
    getLastSourceFromGitRepo
  elif [ $functionName = "4" ]
  then
    echo $functionName
    getRemoteRepo
  else
    exit
  fi
}

cloneGitRepoFiles() {
  read -p "Veuillez entrer l'url du repo GIT : " -n 100 gitRepoUrl
  git clone $gitRepoUrl;
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

getRemoteRepo() {
  read -p "Veuillez entrer l'url du remote du repo GIT : " -n 100 gitRepoRemoteUrl
  git remote rm origin;
  git remote add origin $gitRepoRemoteUrl;
  git remote -v;
}

welcomeBashScript