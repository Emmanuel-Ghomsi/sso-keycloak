FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM nginx:latest

# Copiez les éléments nécessaires de l'image Keycloak dans le répertoire approprié de Nginx
COPY --from=builder /opt/keycloak/themes /usr/share/nginx/html/themes
COPY --from=builder /opt/keycloak/welcome-content /usr/share/nginx/html/welcome-content

# Copiez votre fichier de configuration nginx.conf dans le répertoire approprié de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 4001

CMD ["nginx", "-g", "daemon off;"]