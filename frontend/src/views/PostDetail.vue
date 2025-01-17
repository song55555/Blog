<template>
  <LoadingSpinner v-if="loading" />
  <Error v-else-if="error" :message="error" />
  <div v-else-if="post" class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center flex-col">
    <div class="space-y-6 w-11/12 max-w-lg sm:w-3/4">
      <label class="block text-xl font-bold text-gray-700">旅行記事詳細</label>
      <div class="items-center justify-center">
        <div tabindex="0" aria-label="card 1" class="focus:outline-none mb-7 bg-white p-6 shadow rounded">
          <div class="flex items-center border-b border-gray-200 pb-6">
            <div class="flex items-start justify-between w-full flex-col sm:flex-row">
              <div class="flex-1 text-left mb-2 sm:mb-0">
                <p class="focus:outline-none text-3xl font-bold leading-5 text-gray-800">{{ post.title }}</p>
              </div>
              <div class="flex-1 text-right">
                <p class="text-lg font-bold" :style="{ color: post.category ? '#007bff' : 'inherit' }">
                    <router-link v-if="post.category" :to="`/categories/${post.category.id}`">
                      {{ post.category?.name }}
                    </router-link>
                    <span v-else>カテゴリー未設定</span>
                   </p>
              </div>
            </div>
          </div>
          <div class="px-2">
            <p class="focus:outline-none text-lg leading-5 py-4 text-gray-600">{{ post.content }}</p>
            <p class="focus:outline-none text-sm leading-5 py-4 text-gray-600">
              <strong>タグ:</strong>
              <router-link v-for="(tag, index) in post.tags" :key="tag.id" :to="`/tags/${tag.id}`"
                class="text-blue-500 hover:text-blue-700">
                {{ tag.name }}
                <span v-if="index < post.tags.length - 1">,</span>
              </router-link>
            </p>
            <div class="flex items-center justify-between"> 
              <p class="focus:outline-none text-sm leading-normal pt-2 text-gray-500">by {{ post?.user?.nickname }}</p>
              <div v-if="isAuthor" class="inline-flex space-x-2">
                <router-link :to="`/posts/${post.id}/edit`"
                  class="text-sm bg-transparent hover:bg-blue-500 text-blue-700 hover:text-white py-1 px-3 border border-blue-500 hover:border-transparent rounded">
                  編集
                </router-link>
                <button @click="handleDelete"
                  class="text-sm bg-transparent hover:bg-blue-500 text-blue-700 hover:text-white py-1 px-3 border border-blue-500 hover:border-transparent rounded">
                  削除
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue';
import axios from '@/utils/axios';
import { useRoute, useRouter } from 'vue-router';
import LoadingSpinner from '../components/LoadingSpinner.vue';
import Error from '../components/Error.vue';
import { useStore } from 'vuex';

export default {
  components: {
    LoadingSpinner,
    Error
  },
  setup() {
    const route = useRoute();
    const router = useRouter();
    const postId = route.params.id;
    const post = ref(null);
    const loading = ref(true);
    const error = ref(null);
    const store = useStore();

    const isAuthor = computed(() => {
        const userId = store.state.userId;
         if (!userId || !post.value) {
            return false;
         }
         return post.value.user_id === parseInt(userId, 10);
    });

    const fetchPost = async () => {
      loading.value = true;
      error.value = null;
      try {
        const response = await axios.get(`/api/posts/${postId}`);
        post.value = response.data;
      } catch (err) {
         error.value = '記事詳細データの取得に失敗しました。';
        console.error('記事詳細データの取得に失敗しました。', err);
      } finally {
        loading.value = false;
      }
    };

    const handleDelete = async () => {
      try {
        await axios.delete(`/api/posts/${postId}`);
        router.push('/');
      } catch (err) {
         error.value = '記事削除に失敗しました。';
        console.error('記事削除に失敗しました。', err);
      }
    };

    onMounted(() => {
      fetchPost();
    });

    return {
      post,
      isAuthor,
      handleDelete,
      loading,
      error
    };
  },
};
</script>