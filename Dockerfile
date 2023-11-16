FROM node:21-alpine
COPY app.js /app/
#COPY node_modules/ /app/node_modules/
COPY msnodesqlv8 /app/node_modules/msnodesqlv8/
COPY package-lock.json /app/
COPY package.json /app/
COPY public /app/public/
COPY views /app/views/
#RUN apk add --no-cache g++ make py3-pip
RUN apk add --no-cache python3 py3-pip make g++
#RUN ls -ltr
RUN apk update
RUN apk add --no-cache make gcc g++ libc6-compat bash python3
RUN yarn global add node-gyp
WORKDIR /app/
RUN npm install
CMD ["node","--watch","app.js"]
#CMD ["nodemon","app.js"]
EXPOSE 5000