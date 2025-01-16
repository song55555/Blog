<template>
    <div class="space-y-6 w-3/4 max-w-lg">
      <label class="block text-xl font-bold text-gray-700">旅行記事</label>
      <div class="items-center justify-center">
        <div v-for="post in posts" :key="post.id" tabindex="0" aria-label="card 1" class="focus:outline-none mb-7 bg-white p-6 shadow rounded">
          <div class="flex items-center border-b border-gray-200 pb-6">
            <div class="flex items-start justify-between w-full">
              <div class="pl-3">
                <p class="focus:outline-none text-lg font-medium leading-5 text-gray-800">
                  <router-link :to="`/posts/${post.id}`">{{ post.title }}</router-link>
                </p>
                <p class="focus:outline-none text-sm leading-normal pt-2 text-gray-500">by {{ post?.user?.nickname }}</p>
                  <p class="focus:outline-none text-sm leading-normal pt-2 text-gray-500">
                  <router-link v-for="tag in post.tags" :key="tag.id" :to="`/tags/${tag.id}`" class="text-blue-500 hover:text-blue-700">
                  {{ tag.name }}
                  </router-link>
                 </p>
              </div>
            </div>
          </div>
          <div class="px-2">
            <p class="focus:outline-none text-sm leading-5 py-4 text-gray-600">{{ post.content }}</p>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
    export default {
      props: {
        posts: {
          type: Array,
          required: true
        }
      },
    };
  </script>