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
 const router = useRouter();
 const handleSearch = (searchData) => {
      router.push({query: searchData});
}
 </script>