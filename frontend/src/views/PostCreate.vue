<template>
  <div class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center">
    <form @submit.prevent="handleSubmit" class="space-y-6 w-full max-w-lg sm:w-3/4 bg-white p-6 shadow rounded">
      <label class="block text-xl font-bold text-gray-700">学習ログ投稿</label>
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
        <label for="image" class="text-gray-700 text-lg block mb-1">写真</label>
        <input type="file" id="image" @change="handleImageUpload" accept="image/*"
               class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md py-2 px-3">
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
      <div class="mt-6 flex justify-end space-x-3">
        <button type="submit"
                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">ログを記録</button>
      </div>
       <Error v-if="error" :message="error" />
    </form>
    <LoadingSpinner v-if="loading" />
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import axios from '@/utils/axios';
import { useRouter } from 'vue-router';
import LoadingSpinner from '../components/LoadingSpinner.vue'
import Error from '../components/Error.vue'
import { useStore } from 'vuex';

export default {
  components: {
    LoadingSpinner,
    Error
  },
  setup() {
    const post = ref({
      category_id: '',
      title: '',
      content: '',
      tag_names: '',
    });
    const categories = ref([]);
    const loading = ref(false);
    const error = ref(null);
    const router = useRouter();
    const store = useStore()
    const imageUrl = ref('');  

    const handleSubmit = async () => {
      loading.value = true;
      error.value = null;
      try {
        await axios.post('/api/posts', post.value);
        store.dispatch('setFlashMessage', {message: '投稿しました。', type: 'notice'})
        router.push('/');
      } catch (err) {
        error.value = '投稿の作成に失敗しました。';
        console.error('投稿の作成に失敗しました。', err);
      } finally {
        loading.value = false;
      }
    };

    const fetchCategories = async () => {
      try {
        const response = await axios.get('/api/categories');
        categories.value = response.data;
      } catch (err) {
        error.value = 'カテゴリー情報の取得に失敗しました。';
        console.error('カテゴリー情報の取得に失敗しました。', err);
      }
    };
    const handleImageUpload = async (event) => {
        const file = event.target.files[0];
        if (!file) return;

        const formData = new FormData();
        formData.append('image', file);
        loading.value = true;
        error.value = null;
        try {
            const response = await axios.post('/api/upload', formData, {
                headers: {
                'Content-Type': 'multipart/form-data',
                 },
            });
            imageUrl.value = response.data.url;
            post.value.content += `\n![이미지 설명](${imageUrl.value})\n`;
            console.log("image url=", imageUrl.value);
          } catch (err) {
            error.value = '画像のアップロードに失敗しました。';
            console.error('画像のアップロードに失敗しました。', err);
        } finally {
          loading.value = false;
        }
     };

    onMounted(() => {
      fetchCategories();
    });

    return {
      post,
      categories,
      handleSubmit,
      loading,
      error,
      handleImageUpload,
        imageUrl
    };
  },
};
</script>