// SearchBar.vue
  <template>
    <div class="flex items-center space-x-2 flex-col sm:flex-row">
      <select v-model="selectedCategory" class="border border-gray-300 rounded px-2 py-1 text-sm mb-2 sm:mb-0">
        <option value="">カテゴリー</option>
        <option v-for="category in categories" :key="category.id" :value="category.id">{{ category.name }}</option>
      </select>
      <input type="text" v-model="searchTerm" placeholder="検索キーワードを入力" class="border border-gray-300 rounded px-2 py-1 text-sm mb-2 sm:mb-0">
      <button @click="searchPosts" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-3 rounded text-sm">検索</button>
    </div>
  </template>

  <script setup>
  import { ref, onMounted } from 'vue';
  import axios from 'axios';

  const categories = ref([]);
  const selectedCategory = ref('');
  const searchTerm = ref('');

  onMounted(async () => {
    try {
      const response = await axios.get('/api/categories');
      categories.value = response.data;
    } catch (error) {
      console.error('카테고리를 가져오는 중 오류 발생', error);
    }
  });

  const emit = defineEmits(['search']);
  const searchPosts = () => {
    emit('search', {
      category: selectedCategory.value,
      term: searchTerm.value,
    });
  };
  </script>