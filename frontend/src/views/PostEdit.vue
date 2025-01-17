<template>
  <div class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center">
  <form @submit.prevent="handleSubmit" class="space-y-6 w-full max-w-lg sm:w-3/4 bg-white p-6 shadow rounded">
      <label class="block text-xl font-bold text-gray-700">学習ログ編集</label>
      <div class="mt-4">
          <label for="category_id" class="text-gray-700 text-lg block mb-1">カテゴリー</label>
          <select v-model="post.category_id" id="category_id"
              class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm placeholder-gray-400 border border-gray-300 rounded-md py-2 px-3">
              <option v-for="category in categories" :key="category.id" :value="category.id">
                  {{ category.name }}
              </option>
          </select>
      </div>
      <div class="mt-4">
          <label for="title" class="text-gray-700 text-lg block mb-1">タイトル</label>
          <input v-model="post.title" type="text" id="title"
              class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm placeholder-gray-400 border border-gray-300 rounded-md py-2 px-3"
              placeholder="Railsチュートリアル1章を完了">
      </div>
      <div class="mt-4">
          <label for="content" class="text-gray-700 text-lg block mb-1">本文</label>
          <textarea v-model="post.content" rows="5" id="content"
              class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm placeholder-gray-400 border border-gray-300 rounded-md py-2 px-3"
              placeholder="環境構築を無事に終えることができた！"></textarea>
      </div>
      <div class="mt-4">
          <label for="tag_names" class="text-gray-700 text-lg block mb-1">タグ</label>
          <input v-model="post.tag_names" type="text" id="tag_names"
              class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm placeholder-gray-400 border border-gray-300 rounded-md py-2 px-3"
              placeholder="タグを入力">
      </div>
      <p class="mt-2 text-sm text-gray-500">
          旅行に関する経験を教えてください！<br>
      </p>
      <Error v-if="error" :message="error" />
      <div class="mt-6 flex justify-end space-x-3">
          <button type="submit"
                  class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">更新</button>
          <router-link :to="`/posts/${post.id}`"
              class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">キャンセル</router-link>
      </div>
  </form>
  <LoadingSpinner v-if="loading" />
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import axios from '@/utils/axios';
import { useRouter, useRoute } from 'vue-router';
import LoadingSpinner from '../components/LoadingSpinner.vue';
import Error from '../components/Error.vue'

export default {
  components: {
      LoadingSpinner,
      Error
  },
  setup(){
      const post = ref({
          category_id: '',
          title: '',
          content: '',
          tag_names: ''
      })
      const categories = ref([])
      const router = useRouter()
      const route = useRoute()
      const postId = route.params.id
      const loading = ref(false);
      const error = ref(null);


      const handleSubmit = async () => {
          loading.value = true;
          error.value = null;
          try {
              await axios.put(`/api/posts/${postId}`, post.value);
              localStorage.setItem('flashMessage', '記事の修正しました。')
              localStorage.setItem('flashType', 'notice')
              router.push(`/posts/${postId}`)
          } catch (err) {
              error.value = '記事の修正に失敗しました。';
              console.error('記事の修正に失敗しました。', err);
          } finally {
              loading.value = false;
          }
      };

      const fetchPost = async () => {
          loading.value = true;
          error.value = null;
          try {
              const response = await axios.get(`/api/posts/${postId}`);
              post.value = response.data;
          } catch (err) {
              error.value = '記事の情報の取得に失敗しました。';
              console.error('記事の情報の取得に失敗しました。', err);
          }  finally {
              loading.value = false;
          }
      }

      const fetchCategories = async () => {
          try {
              const response = await axios.get('/api/categories')
              categories.value = response.data
          } catch (err) {
              error.value = 'カテゴリー情報の取得に失敗しました。';
              console.error('カテゴリー情報の取得に失敗しました。', err);
          }
      }

      onMounted(async ()=> {
          await fetchPost()
          await fetchCategories()
      })

      return {
          post,
          categories,
          handleSubmit,
          loading,
          error
      }
  }
}
</script>