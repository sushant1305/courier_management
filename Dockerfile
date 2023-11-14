FROM node:18-alpine
COPY app.js /app/
COPY msnodesqlv8 /app/msnodesqlv8/
COPY node_modules/ /app/node_modules/
COPY package-lock.json /app/
COPY package.json /app/
COPY public /app/public/
COPY views /app/views/
WORKDIR /app/
#RUN apk --update add python
RUN ls -ltr
RUN npm install
CMD ["node","--watch","app.js"]