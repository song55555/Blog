// NavBar.vue
 <template>
   <nav class="bg-gray-800 p-4">
     <div class="container mx-auto flex justify-between items-center">
       <router-link to="/" class="text-white font-bold text-xl">Blog</router-link>
       <div class="flex items-center md:space-x-4">
         <button @click="toggleMenu" class="md:hidden text-gray-300 hover:text-white focus:outline-none">
           <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
             <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
           </svg>
         </button>
           <div :class="{'hidden md:flex': !showMenu, 'flex flex-col md:flex-row md:space-x-4 mt-4 md:mt-0' : showMenu}" >
               <router-link to="/" class="text-gray-300 hover:text-white block p-2 md:p-0 md:mr-4">記事一覧</router-link>
               <router-link v-if="isLoggedIn" to="/posts/new" class="text-gray-300 hover:text-white block p-2 md:p-0 md:mr-4">新規投稿</router-link>
               <span v-if="isLoggedIn" class="text-gray-300 hover:text-white cursor-pointer block p-2 md:p-0 md:mr-4"  @click="handleLogout">
                   ログアウト
               </span>
               <router-link v-else to="/users/sign_in" class="text-gray-300 hover:text-white block p-2 md:p-0 md:mr-4">ログイン</router-link>
               <router-link to="/register" class="text-gray-300 hover:text-white block p-2 md:p-0">会員登録</router-link>
           </div>
       </div>
     </div>
   </nav>
 </template>

 <script>
 import axios from 'axios';
 import { useRouter } from 'vue-router';
 import {  computed, onMounted, ref } from 'vue';
 import { useStore } from 'vuex';

  export default {
    setup(){
        const store = useStore();
       const router = useRouter()
        const isLoggedIn = computed(()=> store.state.isLoggedIn);
        const showMenu = ref(false);

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
         const toggleMenu = () => {
             showMenu.value = !showMenu.value
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
                 handleLogout,
                 toggleMenu,
                 showMenu
             }
       }
   }
 </script>