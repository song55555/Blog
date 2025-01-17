<template>
  <div class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center">
    <form @submit.prevent="handleSubmit" class="space-y-6 w-full max-w-md">
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700">メールアドレス</label>
        <div class="mt-1">
          <input v-model="user.email" type="email" required id="email"
            class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
        </div>
      </div>
      <div>
        <label for="password" class="block text-sm font-medium text-gray-700">パスワード</label>
        <div class="mt-1">
          <input v-model="user.password" type="password" required id="password"
            class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
        </div>
      </div>
      <div>
        <button type="submit"
          class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          ログイン
        </button>
        <div class="mt-2 text-sm text-gray-500">
          アカウントをお持ちでない場合は<router-link to="/register" class="text-blue-500 hover:underline">こちら</router-link>から登録してください。
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
      email: '',
      password: '',
    });
    const loading = ref(false);
    const error = ref(null);
    const router = useRouter();
    const store = useStore();
    const handleSubmit = async () => {
      loading.value = true;
      error.value = null;
      try {
        const response = await axios.post('/api/users/sign_in', { user: { ...user.value } });
        console.log('Response Data:', response.data); 

        const { user: userData, success, token } = response.data;
        if (success) {
          localStorage.setItem('userId', userData.id);
           localStorage.setItem('authToken', token);
          store.dispatch('setUserInfo', { userId: userData.id, authToken: token });
          router.push('/');
          console.log('Router.push() called'); 
        } else {
          error.value = response.data.error;
        }
      } catch (err) {
        error.value = 'ログインに失敗しました。';
        console.error('ログインに失敗しました。', err);
      } finally {
        loading.value = false;
      }
    };
    return {
      user,
      handleSubmit,
      loading,
      error,
    };
  },
};
</script>