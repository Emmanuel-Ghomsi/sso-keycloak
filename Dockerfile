FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest as final

COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
ENV KC_DB=postgres
ENV KC_DB_URL=<DBURL>
ENV KC_DB_USERNAME=<DBUSERNAME>
ENV KC_DB_PASSWORD=<DBPASSWORD>
ENV KC_HOSTNAME=localhost

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# FROM nginx:latest

# Copiez les éléments nécessaires de l'image Keycloak dans le répertoire approprié de Nginx
# COPY --from=final /opt/keycloak/themes /usr/share/nginx/html/themes

# Copiez votre fichier de configuration nginx.conf dans le répertoire approprié de Nginx
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# ENV PORT_KEYCLOAK=4001

# EXPOSE ${PORT_KEYCLOAK}

# CMD ["nginx", "-g", "daemon off;"]