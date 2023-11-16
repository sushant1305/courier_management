FROM node:21-alpine
COPY app.js /app/
COPY msnodesqlv8 /app/msnodesqlv8/
#COPY node_modules/ /app/node_modules/
#COPY package-lock.json /app/
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
RUN apk --update add unixodbc
#RUN apk add --no-cache python3
RUN npm update
CMD ["node","--watch","app.js"]