FROM node:10.24.1-alpine
WORKDIR /app
COPY . .
RUN npm install
#RUN npm install pm2 -g
RUN npm install sequelize-cli -g
RUN npx sequelize db:migrate
EXPOSE 5000
CMD ["npm","start"]

