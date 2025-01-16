<template>
  <div class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center flex-col">
      <LoadingSpinner v-if="loading" />
      <Error v-else-if="error" :message="error" />
      <div v-else class="w-full flex flex-col items-center">
          <h1 class="text-2xl font-bold mb-4">タグ: {{ tag.name }}</h1>
          <PostList :posts="posts" />
         <Pagination
              :currentPage="currentPage"
              :totalPages="totalPages"
              @pageChange="handlePageChange"
           />
      </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';
import PostList from '../components/PostList.vue';
import LoadingSpinner from '../components/LoadingSpinner.vue';
import Error from '../components/Error.vue';
import Pagination from '../components/Pagination.vue';

const route = useRoute();
const tagId = route.params.id;
const posts = ref([]);
const loading = ref(true);
const error = ref(null);
const tag = ref({});
const currentPage = ref(1);
const totalPages = ref(1);
const perPage = ref(5);

const fetchTag = async () => {
  try {
      const tagResponse = await axios.get(`/api/tags/${tagId}`);
      tag.value = tagResponse.data;
  } catch (err) {
       error.value = 'タグ情報の取得に失敗しました。';
    console.error('タグ情報の取得に失敗しました。', err);
  }
}

const fetchPosts = async (page = 1) => {
  loading.value = true;
  error.value = null;
try {
  const response = await axios.get(`/api/tags/${tagId}/posts`, { params: { page: page, per_page: perPage } });
  posts.value = response.data.posts;
   totalPages.value = Math.ceil(response.data.total_count / perPage.value);
} catch (err) {
    error.value = 'タグ別記事データの取得に失敗しました。';
  console.error('タグ別記事データの取得に失敗しました。', err);
} finally {
  loading.value = false;
}
};

const handlePageChange = (newPage) => {
currentPage.value = newPage;
};

onMounted(async () => {
   await fetchTag()
  await fetchPosts();
});
watch(currentPage, (newCurrentPage)=> {
   fetchPosts(newCurrentPage);
});
</script>