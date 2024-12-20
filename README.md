# Weather app

[![Gitlab CI](https://img.shields.io/badge/GitLabCI-%23181717.svg?style=for-the-badge&logo=gitlab&logoColor=white)](https://docs.gitlab.com/ee/ci/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)
[![EmberJS](https://img.shields.io/badge/ember-1C1E24?style=for-the-badge&logo=ember.js&logoColor=#D04A37)](https://emberjs.com/)
[![SASS](https://img.shields.io/badge/SASS-hotpink.svg?style=for-the-badge&logo=SASS&logoColor=white)](https://sass-lang.com/)
[![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com/)

[![Latest Release](https://gitlab.ad.softier.fr/softier/weather/-/badges/release.svg)](https://gitlab.ad.softier.fr/softier/weather/-/releases)
[![pipeline status](https://gitlab.ad.softier.fr/softier/weather/badges/main/pipeline.svg)](https://gitlab.ad.softier.fr/softier/weather/-/commits/main)
[![API coverage](https://gitlab.ad.softier.fr/softier/weather/badges/main/coverage.svg?job=test:api_rspec&key_text=API%20cov.)](https://gitlab.ad.softier.fr/softier/weather/-/commits/main/api)
[![Front coverage](https://gitlab.ad.softier.fr/softier/weather/badges/main/coverage.svg?job=test:front_ember&key_text=Front%20cov.)](https://gitlab.ad.softier.fr/softier/weather/-/commits/main/front)


## Requirements

- Docker
- IDE
- Browser


## Development tools

L'adresse pour accéder à la documentation Swagger : http://localhost/api-docs/index.html

L'adresse pour accéder au service mailhog : https://localhost/mailhog

L'adresse pour accéder aux mailers : https://localhost/rails/mailers


## Services

Le projet s'articule autour des services suivants :
- PostgreSQL : SGBD relationnel
- [NGINX](nginx/README.md) : serveur web pour les fichiers statiques et proxy vers l'API
- [API Ruby On Rails](api/README.md) : gestion de la logique métier
- [Front EmberJS](front/README.md) : gestion de la GUI


## Documentation générale

Les fichiers .env* sont présents dans le dossier _config/docker/env* pour permettre un démarrage facile du projet   

Copier les fichiers de config :   
```
cp _doc/docker/env .env
cp _doc/docker/env_db .env_db
cp _doc/docker/env_redis .env_redis
```

Lancer le projet :   
```
make build
make up
```

Accéder à l'interface : https://localhost/
