# Stage 1

FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true

ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=keycloak

WORKDIR /opt/keycloak

# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

RUN /opt/keycloak/bin/kc.sh build

# Stage 2

FROM quay.io/keycloak/keycloak:latest

COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
ENV KC_DB=keycloak

ENV KC_DB_URL=jdbc:postgresql://195.35.25.116:5432/keycloak

ENV KC_DB_USERNAME=root

ENV KC_DB_PASSWORD=hkdigitals

ENV KC_HOSTNAME=https://sso.surrency.co/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# Stage 3
FROM nginx:1.22.0-alpine

COPY --from=builder /opt/keycloak/ /usr/share/nginx/html/

COPY --from=builder /opt/keycloak/ /var/www

# Supprimez le fichier de configuration par défaut de Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiez votre fichier de configuration personnalisé dans le conteneur
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf

ENV PORT_KEYCLOAK=4001

EXPOSE ${PORT_KEYCLOAK}

CMD nginx -g 'daemon off;'