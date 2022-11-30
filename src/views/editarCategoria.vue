<template>
  <form @submit.prevent="guardar()">
  <h1>{{titulo}}:{{$route.params.id}}</h1>
    <div class="input-group mb-3 justify-content-center">
      <div class="input-group-prepend flex-colunm col-6">
        <label for="">Nombre Categoria</label>
        <input type="text" class="form-control col-4" v-model="categoria.nombre"  placeholder="Categoria" required
        aria-describedby="button-addon2">
      </div>
    </div>
    <div class="input-group mb-3 justify-content-center">
      <button class="btn btn-success" type="submit">Agregar</button>
      <button class="btn btn-light">Cancelar</button>
    </div>
  </form>
</template>
<script>
    export default {
        name: 'editarCategoriaView',
        data() {
            return {
                titulo: 'Editar Categoria',
                categoria: {
                    nombre: null
                }
            }
        },
        methods: {
            getCategorias(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/categorias/"+this.$route.params.categoria_id
                })
                .then(response => {
                    this.categoria = response.data;
                console.log(response);
                })
                .catch(e => console.log(e));
            },
            guardar(){
                axios({
                    method: "patch",
                    url: "http://localhost:3000/categorias/"+this.$route.params.id,
                    data: this.categoria
                })
                .then(response => {
                    this.$store.state.mensaje = {
                        texto: "La Categoria se Actualizo Correctamente",
                        tipo: "exito"
                    };
                    this.$store.dispatch('addMensajeAction');
                    this.$router.push({name: 'Categoria'});
                })
                .catch(e => console.log(e));
            }
        },
        computed: {
        },
        mounted() {
            this.getCategorias();
        },
        components: {
        }
    }
</script>
