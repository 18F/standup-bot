FROM node:6

ENV APP /app

RUN mkdir $APP

WORKDIR $APP
COPY package.json $APP/
RUN npm install
ADD . $APP

ARG NODE_ENV=production
ENV NODE_ENV ${NODE_ENV}

CMD npm start
