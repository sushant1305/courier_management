FROM node:18-alpine
COPY app.js /app/
COPY msnodesqlv8 /app/msnodesqlv8/
#COPY node_modules/ /app/node_modules/
#COPY package-lock.json /app/
COPY package.json /app/
COPY public /app/public/
COPY views /app/views/
WORKDIR /app/
RUN apk --update add unixodbc
#RUN apk add --no-cache python3
RUN npm update
CMD ["node","--watch","app.js"]