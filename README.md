# cinemapedia

# Dev

1. Copiar el .env.template y renombrarlo a .env
2. Cambiar las variables de entorno (TheMovieDB)
3. Para construir los cambios de entidad ejecutar:

```
flutter pub run build_runner build
```

# Prod

1. Cambiar el nombre de la aplicación
```
flutter pub run change_app_package_name:main io.davidrodriguez.cinemapedi
```

2. Generar iconos de la app

```
flutter pub run flutter_launcher_icons
```
