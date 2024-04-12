# Docker Keycloak avec PostgreSQL et Nginx Reverse Proxy

## Description

Ce repository contient les fichiers Dockerfile et docker-compose nécessaires pour déployer un conteneur Keycloak sur un serveur. Keycloak est un logiciel open source qui permet de mettre en place une méthode d'authentification unique via la gestion des identités et des accès. Le déploiement utilise également une base de données PostgreSQL et un fichier de configuration Nginx pour faciliter le reverse proxy.

## Fonctionnalités

- Déploiement simple et rapide d'un conteneur Keycloak avec Docker.
- Intégration avec une base de données PostgreSQL pour le stockage des données.
- Configuration d'un reverse proxy Nginx pour faciliter l'accès à Keycloak depuis l'extérieur du conteneur.

## Instructions

1. Assurez-vous d'avoir Docker et Docker Compose installés sur votre serveur.
2. Clonez ce repository sur votre serveur.
3. Personnalisez les fichiers `docker-compose.yml`, `nginx.conf` selon vos besoins (par exemple, changez les ports si nécessaire).
4. Exécutez `docker-compose up -d` pour démarrer les services Keycloak, PostgreSQL et Nginx.
5. Accédez à Keycloak via votre navigateur en utilisant l'URL de votre serveur.

## Auteur

Emmanuel GHOMSI GHOMSI

## Licence

Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.