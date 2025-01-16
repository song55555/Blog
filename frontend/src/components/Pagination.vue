<template>
  <div class="flex justify-center mt-4">
    <button
      @click="emit('pageChange', currentPage - 1)"
      :disabled="currentPage === 1"
      class="px-4 py-2 mx-1 border rounded hover:bg-gray-100 disabled:opacity-50 text-sm"
    >
      前へ
    </button>
    <span class="px-4 py-2 text-sm">
      {{ currentPage }} / {{ totalPages }}
    </span>
    <button
      @click="emit('pageChange', currentPage + 1)"
      :disabled="currentPage === totalPages"
      class="px-4 py-2 mx-1 border rounded hover:bg-gray-100 disabled:opacity-50 text-sm"
    >
      次へ
    </button>
  </div>
</template>

<script setup>
const props = defineProps({
  currentPage: {
    type: Number,
    required: true,
  },
  totalPages: {
    type: Number,
    required: true,
  },
});
const emit = defineEmits(['pageChange']);
</script>