#!/bin/bash

<< task
deploy a react js app
and handle the code for errors
task

code_clone () {
  echo "Cloning the React JS app..."
  git clone https://github.com/universet/web-server.git
}

install_requirements () {
  echo "Installing dependencies"
#  sudo apt-get install docker.io nginx -y
#  cd web-server/ || exit
  npm install
}

required_restarts () { # when system reboots
  sudo systemctl enable docker
  sudo systemctl enable nginx
}

deploy () {
#  docker build -t web-app .
#  docker run -d -p 3000:3000 web-app:latest
  npm start
}

echo "*************** DEPLOYMENT STARTED ***************"

if ! code_clone ; then
  echo "The code directory already cloned and exists"
  cd web-server/ || exit
fi

if ! install_requirements ; then
  echo "Error while installing deployments"
fi

#required_restarts

if ! deploy ; then
  echo "Error while deploying the project"
  exit 1
fi

echo "*************** DEPLOYMENT DONE *******************"
