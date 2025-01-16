<template>
    <div class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center">
        <form @submit.prevent="handleSubmit" class="space-y-6 w-full max-w-md">
            <div>
                <label for="nickname" class="block text-sm font-medium text-gray-700">ニックネーム</label>
                <div class="mt-1">
                    <input v-model="user.nickname" type="text" required id="nickname" name="nickname" autocomplete="nickname"
                        class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
                </div>
            </div>
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">メールアドレス</label>
                <div class="mt-1">
                    <input v-model="user.email" type="email" required id="email" name="email" autocomplete="email"
                        class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
                </div>
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">パスワード</label>
                <div class="mt-1">
                    <input v-model="user.password" type="password" required id="password" name="password" autocomplete="new-password"
                        class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
               </div>
            </div>
             <div>
                <label for="password_confirmation" class="block text-sm font-medium text-gray-700">パスワード確認</label>
                <div class="mt-1">
                     <input v-model="user.password_confirmation" type="password" required id="password_confirmation" name="password_confirmation" autocomplete="new-password"
                       class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
               </div>
             </div>
            <div>
                <button type="submit"
                    class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                  登録
               </button>
               <div class="mt-2 text-sm text-gray-500">
                    アカウントをお持ちの場合は<router-link to="/users/sign_in" class="text-blue-500 hover:underline">こちら</router-link>からログインしてください。
                </div>
            </div>
              <LoadingSpinner v-if="loading" />
              <Error v-if="error" :message="error" />
        </form>
    </div>
</template>

<script>
import { ref } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';
import { useStore } from 'vuex';
import LoadingSpinner from '../components/LoadingSpinner.vue';
import Error from '../components/Error.vue';

export default {
   components: {
    LoadingSpinner,
    Error,
  },
  setup() {
    const user = ref({
      nickname: '',
      email: '',
      password: '',
      password_confirmation: '',
     });
    const loading = ref(false);
    const error = ref(null);
    const router = useRouter();
    const store = useStore();
    const handleSubmit = async () => {
         loading.value = true;
         error.value = null;
         try {
            const response = await axios.post('/api/users', { user: { ...user.value } });
            const { user: userData, token, success } = response.data;
             if(success) {
                 localStorage.setItem('userId', userData.id);
                 localStorage.setItem('auth-token', token)
                 store.dispatch('setUserInfo', {userId: userData.id, authToken: token})
                 router.push('/');
             } else {
                 error.value = response.data.errors.full_messages[0]
              }
         } catch (err) {
             error.value = '会員登録に失敗しました。';
             console.error('会員登録に失敗しました。', err)
        } finally {
              loading.value = false;
        }
    };
   return {
      user,
        handleSubmit,
        loading,
          error
    };
  },
};
</script>