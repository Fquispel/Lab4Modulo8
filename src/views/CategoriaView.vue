<template>
  <div class="categoria">
    </div>
    <h1>Categorias</h1>
    <form @submit.prevent="agregarCategoria()">
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <div class="input-group mb-3 ">
              <div class="input-group-prepend flex-colunm col-6">
                <label for="">Nombre Categoria</label>
                <input type="text" class="form-control col-4" v-model="categoria.nombre" placeholder="Categoria" required
                aria-describedby="button-addon2">
              </div>
            </div>
            <div class="input-group mb-3">
              <button class="btn btn-success " type="submit">Agregar</button>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="input-group mb-3 ">
              <div class="input-group-prepend flex-colunm col-6">
                <label for="">Buscar Categoria</label>
                <input type="text" class="form-control col-4" v-model="catBuscar" placeholder="Buscar Categoria"  aria-describedby="button-addon2">
              </div>
            </div>
            <div class="input-group mb-3 ">
              <button class="btn btn-secondary" @click.prevent="getCategorias()" type="submit">Buscar</button></div>
          </div>
        </div>
      </div>
    </form>
      <div class="col m12 card-panel">
        <table class="table table-bordered ">
        <thead class="table-dark">
          <tr>
            <th scope="col">Codigo</th>
            <th scope="col">Nombre</th>
            <th scope="col">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(cat, index) in categorias">
            <th>{{cat.id}}</th>
            <td>{{cat.nombre}}</td>
            <td>
                <button @click="actualizarCategoria(cat.id)" class="btn btn-warning">Actualizar</button>
                <button @click="borrarCategoria(cat.id)" class="btn btn-danger">Borrar</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
</template>


<script>
import router from "@/router";
    export default {
        name: 'categoriaView',
        data(){
            return {
              catBuscar:"",
                categoria:{
                    nombre:null
                },
                categorias:[]
            }
        },
        methods: {
            agregarCategoria(){
                axios({
                    method: "post",
                    url: "http://localhost:3000/categorias",
                    data: this.categoria
                })
                .then(response => {
                    console.log(response);
                    this.getCategorias()
                })
                .catch(e => console.log(e));
                this.categoria ='';
            },
            actualizarCategoria(categoria_id) {
              this.$router.push({name:'editarCat',params:{id:categoria_id}});
            },
            borrarCategoria(categoria_id){
              if(confirm("Está seguro de eliminar la categoria " + categoria_id + "?"))
                axios({
                    method: "delete",
                    url: "http://localhost:3000/categorias/"+categoria_id,
                    data: this.categorias
                })
                .then(response => {
                    console.log(response);
                    this.getCategorias()
                })
                .catch(e => console.log(e));
            },
            getCategorias(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/categorias/?q="+this.catBuscar,
                })
                .then(response => {
                    this.categorias = response.data;
                console.log(response);
                })
                .catch(e => console.log(e));
                this.categoria ='';
            },

        },
        computed: {
        },
        mounted(){
            this.getCategorias()
        },
        components: {
        }
    }
</script>
<style>

</style>
