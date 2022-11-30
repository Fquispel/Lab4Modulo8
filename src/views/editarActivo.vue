<template>
  <form @submit.prevent="guardar()">
  <h1>{{titulo}}:{{$route.params.id}}</h1>
  <div class="input-group mb-3  justify-content-center">
    <div class="input-group-prepend flex-colunm col-6">
      <select class="form-select" v-model="activosUpdate.categoria">
        <option value="undefined" disabled>Seleccione Una Categoria</option>
        <option v-for="selectCategorias in categorias" :value="selectCategorias.id">
          {{selectCategorias.nombre}}
        </option>
      </select>
    </div>
  </div>
  <div class="input-group mb-3  justify-content-center">
    <div class="input-group-prepend flex-colunm col-6">
      <input type="text" class="form-control col-6" v-model="activosUpdate.marca" placeholder="Marca"
      aria-describedby="button-addon2">
    </div>
  </div>
  <div class="input-group mb-3  justify-content-center">
    <div class="input-group-prepend flex-colunm col-6">
      <input type="text" class="form-control col-6" v-model="activosUpdate.modelo" placeholder="Modelo"
      aria-describedby="button-addon2">
    </div>
  </div>
  <div class="input-group mb-3  justify-content-center">
    <div class="input-group-prepend flex-colunm col-6">
      <select  class="form-select" v-model="activosUpdate.estado">
        <option :value="{}" disabled>Seleccione Un Estado
        </option>
        <option v-for = "estado in estados " >{{estado.nombreEstado}}</option>
      </select>
    </div>
  </div>
  <div class="input-group mb-3  justify-content-center">
    <div class="input-group-prepend flex-colunm col-6">
      <select class="form-select"  v-model="activosUpdate.area">
        <option value="0" disabled>Seleccione Un departamento</option>
        <option v-for="selectArea in area" :value="selectArea.id" >
          {{selectArea.nombreArea}}</option>
        </select>
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
        name: 'editarActivoView',
        data() {
            return {
                titulo: 'Editar Activo',
                activosUpdate: {
                  categoria:null,
                  marca:null,
                  modelo: null,
                  estado:null,
                  area:null
                },
                selectEstado: '',
                estados: [
                  {nombreEstado: 'Nuevo'},
                  {nombreEstado: 'Usado'},
                  {nombreEstado: 'Desuso'}
                ],
                categorias:[],
                area:[],
                activos:[]
            }
        },
        methods: {
            getActivosFijos(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/activos/"+this.$route.params.activos_id
                })
                .then(response => {
                    this.activosUpdate = response.data;
                console.log(response);
                })
                .catch(e => console.log(e));
            },
            getCategorias(){
              axios({
                method: "get",
                url: "http://localhost:3000/categorias",
              })
              .then(response => {
                this.categorias = response.data;
                console.log(response);
              })
              .catch(e => console.log(e));
            },
            getArea(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/area"
                })
                .then(response => {
                    this.area = response.data;
                console.log(response);
                })
                .catch(e => console.log(e));
            },
            guardar(){
                axios({
                    method: "patch",
                    url: "http://localhost:3000/activos/"+this.$route.params.id,
                    data: this.activosUpdate
                })
                .then(response => {
                    this.$store.state.mensaje = {
                        texto: "El Activo se Actualizo Correctamente",
                        tipo: "exito"
                    };
                    this.$store.dispatch('addMensajeAction');
                    this.$router.push({name: 'Activos'});
                })
                .catch(e => console.log(e));
            }
        },
        computed: {
        },
        mounted() {
            this.getActivosFijos();
            this.getCategorias()
            this.getArea()
        },
        components: {
        }
    }
</script>
