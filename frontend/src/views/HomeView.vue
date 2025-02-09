<template>
  <div class="q-pa-md">
    <div class="q-pa-md">
      <q-btn icon="add" @click="onCreate"/>
    </div>
    <q-table
      title="Treats"
      :rows="rows"
      :columns="columns"
      row-key="name"                                                                                                            
    >
    <template v-slot:body-cell-actions = "props">
      <q-td :props="props">
        <q-btn
          flat
          dense
          round
          icon="edit"
          @click="onEdit(props.row.customer_id)"
        />
        <q-btn
        flat
          dense
          round
          icon="delete"
          @click="onDelete(props.row.customer_id)"
        />
      </q-td>
    </template>
  </q-table>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import router from '../router'
const columns = [
  { name: 'customer_id', align: 'center', label: 'รหัสลูกค้าจ้า', field: 'customer_id', sortable: true },
  { name: 'first_name', align: 'center', label: 'first_name', field: 'first_name', sortable: true },
  { name: 'last_name', align: 'center', label: 'last_name', field: 'last_name', sortable: true },
  { name: 'email', align: 'center', label: 'email', field: 'email', sortable: true },
  { name: 'address', align: 'center', label: 'address', field: 'address', sortable: true },
  { name: 'phone_number', align: 'center', label: 'phone_number', field: 'phone_number', sortable: true },
  { name: 'actions', align: 'center', label: 'id', field: 'id', sortable: true }
]

const rows = ref([])

const fetchData = async () => {
  fetch('http://localhost:8800/api/v1/customers')
    .then(res => res.json())
    .then(result => {
      rows.value = result
    })
}
fetchData()

const onCreate = () => {
  router.push('/create')
}

const onEdit = (id) => {
  router.push('update/' + id)
  console.log(id)
}

const onDelete = (id) => {
  const myHeaders = new Headers();
  myHeaders.append("Content-Type", "application/json");

  const requestOptions = {
  method: "DELETE",
  headers: myHeaders,
  redirect: "follow"
};

fetch(`http://localhost:8800/api/v1/customers/${id}`, requestOptions)
  .then((response) => response.json()) 
  .then((result) => {
    alert(result.message)
    console.log(result)
    if (result.status === 'ok') {
        router.push('/')
    }
    fetchData()
    })
  .catch((error) => console.log('error', error));
}

</script>