# Looking for information on environment variables?
# We don't declare them here — take a look at our docs.
# https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md

FROM nginx:1.15-alpine

RUN apk --no-cache add nodejs

LABEL maintainer="fehguy"

ENV API_KEY "**None**"
ENV SWAGGER_JSON "/app/swagger.json"
ENV PORT 8080
ENV BASE_URL ""

COPY ./docker/nginx.conf ./docker/cors.conf /etc/nginx/

# copy swagger files to the `/js` folder
RUN mkdir /usr/share/nginx/html/apidoc
COPY ./dist/* /usr/share/nginx/html/apidoc/
COPY ./docker/run.sh /usr/share/nginx/
COPY ./docker/configurator /usr/share/nginx/configurator

RUN chmod +x /usr/share/nginx/run.sh

EXPOSE 8080

CMD ["sh", "/usr/share/nginx/run.sh"]
