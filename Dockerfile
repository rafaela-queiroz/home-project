FROM node:14.17.0 as build

WORKDIR /app

COPY . .

RUN npm ci --silent

# caso necessario um path diferente do "localhost" no angular,
# como por exemplo "http://localhost/angular" troque a linha que está comentada pela descomentada

# RUN npx ng build -- --deploy-url /angular/
RUN npx ng build

FROM nginx

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/dist/home-project /usr/share/nginx/html
