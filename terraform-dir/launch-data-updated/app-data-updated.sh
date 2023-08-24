#!/bin/bash

git clone https://github.com/Agnes4Him/react-express-mysql-microsvc.git
cd react-express-mysql-microsvc/server
npm install
#... Download a .env file containing database secrets here...
npm run start:dev
