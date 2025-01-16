<template>
  <div v-if="loading" class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center">로딩중...</div>
  <Error v-else-if="error" :message="error" />
  <div v-else class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center flex-col">
    <h1 class="text-2xl font-bold mb-4">カテゴリー: {{ category.name }}</h1>
    <PostList :posts="posts" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';
import PostList from '../components/PostList.vue';
import LoadingSpinner from '../components/LoadingSpinner.vue';
import Error from '../components/Error.vue';


const route = useRoute();
const categoryId = route.params.id;
const posts = ref([]);
const loading = ref(true);
const error = ref(null);
const category = ref({});

onMounted(async () => {
  loading.value = true;
  error.value = null;
  try {
    const categoryResponse = await axios.get(`/api/categories/${categoryId}`);
    category.value = categoryResponse.data;
    const response = await axios.get(`/api/categories/${categoryId}/posts`);
    posts.value = response.data;
  } catch (err) {
    error.value = 'カテゴリー別記事データの取得に失敗しました。';
    console.error('カテゴリー別記事データの取得に失敗しました。', err);
  } finally {
    loading.value = false;
  }
});
</script>