<template>
  <div class="q-gutter-md" style="max-width: 400px">
    <q-form @submit="onSubmit" class="q-gutter-md">
      <q-input v-model="first_name" label="First Name" />
      <q-input v-model="last_name" label="Last Name" />
      <q-input v-model="email" label="Email" type="email" />
      <q-input v-model="address" label="Address" />
      <q-input v-model="phone_number" label="Phone Number" type="tel" />
      <q-btn label="Submit" color="primary" type="submit" />
    </q-form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import router from '../router'

const first_name = ref('')
const last_name = ref('')
const email = ref('')
const address = ref('')
const phone_number = ref('')

const onSubmit = () => {
  const myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");

const raw = JSON.stringify({
  "first_name": first_name.value,
  "last_name": last_name.value,
  "email": email.value,
  "address": address.value,
  "phone_number": phone_number.value
});

const requestOptions = {
  method: "POST",
  headers: myHeaders,
  body: raw,
  redirect: "follow"
};

fetch("http://localhost:8800/api/v1/customers", requestOptions)
  .then((response) => response.json())
  .then((result) => {
    alert(result.message);
    if (result.status === "ok"){
        router.push('/')
    }
  })
  .catch((error) => console.error(error));
}
</script>
