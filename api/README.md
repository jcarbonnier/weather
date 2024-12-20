# README

Le service de météo utilisé est le suivant : https://www.weatherapi.com/   

L'API s'appuie sur une architecture Model - Controller - Services   

Le controller application_controller.rb gère les actions CRUD communes à tous les autres controllers   
Les autres controllers s'appuient dessus, tant en gardant la possibilité de surcharger les méthodes par défaut
pour des besoins spécifiques.

Des concerns controller ont été créés pour la gestion des logiques suivantes :
- Authentication : gestion de l'authentification via un token JWT
- Params : gestion des strong parameters définis dans les policies

Les controllers de l'API sont séparés en 2 familles : 
- Public : aucune authentification n'est nécessaire
- Private : authentification requise

Les policies sont gérées en s'appuyant sur le gem Pundit et séparées par famille de controller
pour une meilleure lisibilité des restrictions.

Chaque action d'écriture sur la DB est gérée par un service dédié utilisé permettant d'appliquer 
la logique métier.   
Par ex. services/record/weather_location/create_service.rb   

Les services du dossier external permettent de communiquer avec des API tierces : 
- external/net_http : envoie des requêtes HTTP vers l'extérieur
- external/weather_api : envoie des requêtes HTTP du service de météo

Les tests ont été écris à l'aide des gem rspec et swagger, qui fournit une documentation accessible en ligne.
