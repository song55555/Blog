<template>
    <div class="text-red-500">
      {{ message }}
    </div>
  </template>
  <script setup>
  const props = defineProps({
    message: String,
  });
  </script>