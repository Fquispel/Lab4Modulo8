<template>
  <form @submit.prevent="guardar()">
    <h1>{{titulo}}:{{$route.params.id}}</h1>
          <div class="input-group mb-3 justify-content-center" >
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="areaUpdate.nombreArea" placeholder="Area" required
              aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3 justify-content-center" >
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="areaUpdate.nombreEncargado" placeholder=" Nombre del Encargado" required
              aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3 justify-content-center">
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="areaUpdate.numeroFuncionarios" placeholder="Numero de Funcionarios" required
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
        name: 'editarDeptoView',
        data() {
            return {
                titulo: 'Editar Departamento',
                areaUpdate: {
                  nombreArea:null,
                  nombreEncargado:null,
                  numeroFuncionarios:null
                }
            }
        },
        methods: {
            getArea(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/area/"+this.$route.params.area_id
                })
                .then(response => {
                    this.areaUpdate = response.data;
                console.log(response);
                })
                .catch(e => console.log(e));
            },
            guardar(){
                axios({
                    method: "patch",
                    url: "http://localhost:3000/area/"+this.$route.params.id,
                    data: this.areaUpdate
                })
                .then(response => {
                    this.$store.state.mensaje = {
                        texto: "El Departamento se Actualizo Correctamente",
                        tipo: "exito"
                    };
                    this.$store.dispatch('addMensajeAction');
                    this.$router.push({name: 'Departamento'});
                })
                .catch(e => console.log(e));
            }
        },
        computed: {
        },
        mounted() {
            this.getArea();
        },
        components: {
        }
    }
</script>
