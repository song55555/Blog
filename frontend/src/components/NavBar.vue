<template>
  <nav class="bg-gray-800 p-4">
      <div class="container mx-auto flex justify-between items-center">
          <router-link to="/" class="text-white font-bold text-xl">
              Blog
          </router-link>
           <div class="space-x-4">
               <router-link to="/" class="text-gray-300 hover:text-white">
                  記事一覧
               </router-link>
               <router-link v-if="isLoggedIn" to="/posts/new" class="text-gray-300 hover:text-white">
                  新規投稿
               </router-link>
               <span v-if="isLoggedIn" class="text-gray-300 hover:text-white cursor-pointer"  @click="handleLogout">
                  ログアウト
               </span>
                <a v-else href="/users/sign_in"  class="text-gray-300 hover:text-white">
                  ログイン
                </a>
               <router-link to="/register" class="text-gray-300 hover:text-white">
                  会員登録
               </router-link>
          </div>
      </div>
  </nav>
</template>

<script>
import axios from 'axios';
import { useRouter } from 'vue-router';
import {  computed, onMounted } from 'vue';
import { useStore } from 'vuex';

 export default {
   setup(){
       const store = useStore();
      const router = useRouter()
       const isLoggedIn = computed(()=> store.state.isLoggedIn);

            const handleLogout = async() => {
                try {
                  if (!store.state.authToken) return;
                    await axios.delete('/api/users/sign_out', {
                         headers: {
                           'Authorization': store.state.authToken
                         }
                      })
                   store.dispatch('clearUserInfo');
                   router.push('/')
                 } catch (error) {
                    console.error(error);
               }
            }
              onMounted(() => {
                   const userId = localStorage.getItem('userId');
                   const authToken = localStorage.getItem('auth-token');
                   if(userId && authToken){
                       store.dispatch('setUserInfo', {userId: parseInt(userId), authToken: authToken})
                    }
              })

            return {
                isLoggedIn,
                handleLogout
            }
      }
  }
</script>