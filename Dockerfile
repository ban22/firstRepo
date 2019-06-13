# Stage 0, "build-stage", based on Node.js, to build and compile Angular
FROM node:10-alpine as build-stage

WORKDIR /app

COPY package*.json /app/

RUN npm install

RUN npm ci

#Add this package only if your code need it.
#RUN ng add @progress/kendo-angular-editor 

COPY ./ /app/

#[Enviornment_name] should be same as you specified in property file of angualar
ARG configuration=[Enviornment_name]

#Use if needed
RUN npm rebuild node-sass

#dist can be replace by output path specified in angular.json
RUN npm run build -- --output-path=./dist  --configuration=$configuration

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.15

#if you are using context path then only speciy same context path else dist folder can be copy under html(i.e. without context path)
COPY --from=build-stage /app/dist/ /usr/share/nginx/html/[context_path]
