<template>
  <NavBar/>
   <div class="container mx-auto mt-4 flex justify-end px-5">
      <SearchBar @search="handleSearch"/>
  </div>
  <FlashMessage/>
 <router-view></router-view>
</template>

<script setup>
import NavBar from './components/NavBar.vue'
import FlashMessage from './components/FlashMessage.vue'
import SearchBar from './components/SearchBar.vue';
import { useRouter } from 'vue-router';
 import { onMounted } from 'vue';
 import { useStore } from 'vuex';
const router = useRouter();
const store = useStore();
const handleSearch = (searchData) => {
    router.push({query: searchData});
}
  onMounted(() => {
    const userId = localStorage.getItem('userId');
      const authToken = localStorage.getItem('authToken');
    if (userId && authToken) {
      store.commit('SET_USER_INFO', { userId: parseInt(userId), authToken: authToken });
    }
  });
</script>