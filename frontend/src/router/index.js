import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import PostDetail from '../views/PostDetail.vue';
import PostCreate from '../views/PostCreate.vue';
import PostEdit from '../views/PostEdit.vue';
import TagDetail from '../views/TagDetail.vue'
import CategoryDetail from '../views/CategoryDetail.vue'
import Login from '../views/Login.vue'; 
import Register from '../views/Register.vue'; 

const routes = [
  { path: '/', component: Home },
  { path: '/posts/new', component: PostCreate },
  { path: '/posts/:id', component: PostDetail },
  { path: '/posts/:id/edit', component: PostEdit },
  { path: '/tags/:id', component: TagDetail },
  { path: '/categories/:id', component: CategoryDetail },
    { path: '/users/sign_in', component: Login },
    { path: '/register', component: Register }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;