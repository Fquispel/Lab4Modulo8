<template>
  <div class="departamento">
    <h1>Departamentos</h1>
  </div>
  <form @submit.prevent="agregarArea()">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="input-group mb-3">
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="areaReg.nombreArea" placeholder="Area" required
              aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3">
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="areaReg.nombreEncargado" placeholder=" Nombre del Encargado" required
              aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3 ">
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="areaReg.numeroFuncionarios" placeholder="Numero de Funcionarios" required
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
              <label for="">Buscar Departamento</label>
              <input type="text" class="form-control col-4" v-model="areaBuscar" placeholder="Buscar Area"  aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3 ">
            <button class="btn btn-secondary" @click.prevent="getArea()" type="submit">Buscar</button></div>
        </div>
      </div>
    </div>
  </form>
  <div class="col m12 card-panel">
    <table class="table table-bordered ">
      <thead class="table-dark">
        <tr>
          <th scope="col">Codigo</th>
          <th scope="col">Area</th>
          <th scope="col">Nombre Encargado</th>
          <th scope="col">Numero de Funcionarios</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(departamento, index) in area">
          <th>{{ departamento.id }}</th>
          <td>{{ departamento.nombreArea}}</td>
          <td>{{ departamento.nombreEncargado}}</td>
          <td>{{ departamento.numeroFuncionarios}}</td>
          <td>
            <button @click="actualizarArea(departamento.id)" class="btn btn-warning">Actualizar</button>
            <button @click="borrarArea(departamento.id)" class="btn btn-danger">Borrar</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
    export default {
        name: 'departamentoView',
        data(){
            return {
              areaBuscar:"",
                areaReg:{
                  nombreArea:null,
                  nombreEncargado:null,
                  numeroFuncionarios:null
                },
                area:[]
            }
        },
        methods: {
            agregarArea(){
                axios({
                    method: "post",
                    url: "http://localhost:3000/area",
                    data: this.areaReg
                })
                .then(response => {
                    console.log(response);
                    this.getArea()
                })
                .catch(e => console.log(e));
                this.areaReg ='';
            },
            actualizarArea(area_id) {
              this.$router.push({name:'editarDepto',params:{id:area_id}});
            },
            borrarArea(area_id){
              if (confirm("Está seguro de eliminar el Departamento " + area_id + "?"))
                axios({
                    method: "delete",
                    url: "http://localhost:3000/area/"+area_id,
                    data: this.area
                })
                .then(response => {
                    console.log(response);
                    this.getArea()
                })
                .catch(e => console.log(e));
            },
            getArea(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/area/?q="+this.areaBuscar,
                })
                .then(response => {
                    this.area = response.data;
                console.log(response);
                })
                .catch(e => console.log(e));
            },
        },
        computed: {
        },
        mounted(){
            this.getArea()
        },
        components: {
        }
    }
</script>
<style>

</style>
