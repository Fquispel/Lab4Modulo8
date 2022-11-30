<template>
  <nav>
    <router-link  to="/">Inicio</router-link> |
    <router-link to="/Departamento">Departamentos</router-link> |
    <router-link to="/Categoria">Categoria</router-link> |
    <router-link to="/Activos">Activos Fijos</router-link> |
  </nav>
  <router-view/>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
  background-color: #880400;
}

nav a {
  font-weight: bold;
  color: #d91712;
}

nav a.router-link-exact-active {
  color: #ffffff;
}
</style>
