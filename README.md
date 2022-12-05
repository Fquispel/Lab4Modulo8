# Laboratorio 4
## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

## Ejecutar docker-compose 

```
docker-compose up -d json-server´
```
```
docker-compose up -d frontend
```
## Para Verificar que la base de datos se levanto correctamente podemos probar en:
```
localhost:3000
```
## Para levantar la app en vue ejecutamos el siguiente comando y copiamos la direccion que nos muestre en network
```
docker run -p 5000:8080 lab4-frontend
```
