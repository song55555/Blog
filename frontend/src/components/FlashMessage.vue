<template>
  <div v-if="message" class="fixed top-5 left-1/2 -translate-x-1/2" role="alert">
      <div v-if="type === 'notice'" class="p-4 mt-3 mb-4 mx-3 text-sm text-blue-700 bg-blue-100 rounded-lg dark:bg-blue-200 dark:text-blue-800" >
          <p class="font-bold">
             {{ message }}
           </p>
          <button class="absolute top-0 right-0 p-2" @click="clearMessage">
             X
          </button>
       </div>
       <div v-else class="p-4 mt-3 mb-4 mx-3 text-sm text-red-700 bg-red-100 rounded-lg dark:bg-red-200 dark:text-red-800">
           <p class="font-bold">
             {{ message }}
            </p>
           <button class="absolute top-0 right-0 p-2" @click="clearMessage">
              X
           </button>
       </div>
  </div>
</template>

<script>
 import {  computed } from 'vue'
 import { useStore } from 'vuex';
   export default {
     setup(){
         const store = useStore();
            const message = computed(()=> store.state.flashMessage.message)
          const type = computed(()=> store.state.flashMessage.type)
         const clearMessage = ()=> {
             store.dispatch('clearFlashMessage')
         }

         return {
           message,
           type,
           clearMessage
         }
     },
   }
 </script>