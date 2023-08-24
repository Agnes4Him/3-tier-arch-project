#!/bin/bash

git clone https://github.com/Agnes4Him/react-express-mysql-microsvc.git
cd react-express-mysql-microsvc/client
npm install
npm run build
npm install -g serve
serve -s build