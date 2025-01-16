<template>
  <div class="container mx-auto mt-20 py-8 px-5 flex items-center justify-center flex-col">
      <LoadingSpinner v-if="loading" />
      <Error v-else-if="error" :message="error" />
      <div v-else class="w-full flex flex-col items-center">
          <PostList :posts="posts" />
            <Pagination
              :currentPage="currentPage"
              :totalPages="totalPages"
             @pageChange="handlePageChange"
              />
      </div>
  </div>
</template>

<script>
  import { ref, onMounted, watch } from 'vue';
  import PostList from '../components/PostList.vue';
  import axios from 'axios';
  import LoadingSpinner from '../components/LoadingSpinner.vue';
  import Error from '../components/Error.vue';
  import Pagination from '../components/Pagination.vue';
  import { useRoute } from 'vue-router';

  export default {
      components: {
          PostList,
          LoadingSpinner,
          Error,
          Pagination
      },
      setup(){
          const posts = ref([]);
          const loading = ref(true);
          const error = ref(null);
          const currentPage = ref(1);
          const totalPages = ref(1);
          const perPage = ref(5)
          const route = useRoute();

          const fetchPosts = async (category = null, term = null, page = 1) => {
               loading.value = true;
               error.value = null;
               try {
                  let url = '/api/posts';
                   const params = { page: page, per_page: perPage.value };
                 if(category) {
                      params.category_id = category;
                  }
                   if(term){
                      params.q = term
                  }
                  const response = await axios.get(url, { params });
                   posts.value = response.data.posts;
                  totalPages.value = Math.ceil(response.data.total_count / perPage.value);
               } catch (err) {
                     error.value = '記事データの取得に失敗しました。';
                    console.error('記事データの取得に失敗しました。', err);
               } finally {
                   loading.value = false;
               }
            };

            const handlePageChange = (newPage) => {
                 currentPage.value = newPage
             }

            watch(
                 ()=> route.query,
                (newQuery)=> {
                    fetchPosts(newQuery.category, newQuery.term, 1)
                  },
                 { immediate: true }
            )
              watch(currentPage, (newCurrentPage)=> {
                  fetchPosts(route.query.category, route.query.term, newCurrentPage);
                 })
            onMounted(()=> {
                fetchPosts()
              })
          return {
             posts,
             handlePageChange,
              currentPage,
               totalPages,
                loading,
                   error
            }
          }
      }
</script>