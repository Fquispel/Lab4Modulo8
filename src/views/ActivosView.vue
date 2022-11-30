<template>
  <div class="activos">
  </div>
  <h1>Activos Fijos</h1>
  <form @submit.prevent="agregarActivos()">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="input-group mb-3 ">
            <div class="input-group-prepend flex-colunm col-6">
              <select class="form-select" v-model="activosReg.categoria">
                <option value="undefined" disabled>Seleccione Una Categoria</option>
                <option v-for="selectCategorias in categorias" :value="selectCategorias.id">
                  {{selectCategorias.nombre}}
                </option>
              </select>
            </div>
          </div>
          <div class="input-group mb-3">
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="activosReg.marca" placeholder="Marca"
              aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3">
            <div class="input-group-prepend flex-colunm col-6">
              <input type="text" class="form-control col-6" v-model="activosReg.modelo" placeholder="Modelo"
              aria-describedby="button-addon2">
            </div>
          </div>
          <div class="input-group mb-3 ">
            <div class="input-group-prepend flex-colunm col-6">
              <select  class="form-select" v-model="activosReg.estado">
                <option :value="{}" disabled>Seleccione Un Estado
                </option>
                <option v-for = "estado in estados " >{{estado.nombreEstado}}</option>
              </select>
            </div>
          </div>
          <div class="input-group mb-3">
            <div class="input-group-prepend flex-colunm col-6">
              <select class="form-select"  v-model="activosReg.area">
                <option value="0" disabled>Seleccione Un departamento</option>
                <option v-for="selectArea in area" :value="selectArea.id" >
                  {{selectArea.nombreArea}}</option>
                </select>
              </div>
            </div>
            <div class="input-group mb-3 justify-content-center">
              <button class="btn btn-success " type="submit">Agregar</button>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="input-group mb-3 ">
              <div class="input-group-prepend flex-colunm col-6">
                <label for="">Buscar Activo</label>
                <input type="text" class="form-control col-4" v-model="activosBuscar" placeholder="Buscar Activo"  aria-describedby="button-addon2">
              </div>
            </div>
            <div class="input-group mb-3 ">
              <button class="btn btn-secondary" @click.prevent="getActivosFijos()" type="submit">Buscar</button></div>
          </div>
        </div>
      </div>
  </form>
  <div class="col m12 card-panel">
    <table class="table table-bordered ">
      <thead class="table-dark">
        <tr>
          <th scope="col ">Codigo</th>
          <th scope="col">Categoria</th>
          <th scope="col">Marca</th>
          <th scope="col">Modelo</th>
          <th scope="col">Estado</th>
          <th scope="col">Área</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="activosFijos in activos" :key="activosFijos.categoria">
          <th>{{activosFijos.id }}</th>
          <td>{{activosFijos.categoria}}</td>
          <td>{{activosFijos.marca}}</td>
          <td>{{activosFijos.modelo}}</td>
          <td>{{activosFijos.estado}}</td>
          <td>{{activosFijos.area}}</td>
          <td>
            <button @click="actualizarActivo(activosFijos.id)" class="btn btn-warning">Actualizar</button>
            <button @click.prevent="borrarActivos(activosFijos.id)" class="btn btn-danger">Borrar</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
    export default {
        name: 'activosView',
        data(){
            return {
              activosBuscar:"",
                activosReg:{
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
            agregarActivos(){
                axios({
                    method: "post",
                    url: "http://localhost:3000/activos",
                    data: this.activosReg
                })
                .then(response => {
                    console.log(response);
                    this.getActivosFijos()
                })
                .catch(e => console.log(e));
                this.activosReg='';
            },
            getActivosFijos(){
                axios({
                    method: "get",
                    url: "http://localhost:3000/activos/?q="+this.activosBuscar,
                })
                .then(response => {
                    this.activos = response.data;

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
            actualizarActivo(activo_id) {
              this.$router.push({name:'editarActivos',params:{id:activo_id}});
            },
            borrarActivos(activos_id) {
              if(confirm("Está seguro de eliminar el activo " + activos_id + "?"))
              axios({
                method:"delete",
                url: "http://localhost:3000/activos/"+activos_id,
                data:this.activos
              })
              // Borramos de la lista
              .then(response => {
                  this.getActivosFijos();
              console.log(response);
              })
              .catch(e => console.log(e));

            },
        },
        computed: {
        },
        mounted(){
            this.getActivosFijos()
            this.getCategorias()
            this.getArea()
        },
        components: {
        }
    }
</script>
<style>

</style>
