import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import path from 'path';

export default defineConfig({
    plugins: [
        vue(),
    ],
    resolve: {
        alias: {
            '@': path.resolve(__dirname, './src'),
        },
    },
    server: {
        watch: {
            usePolling: true
        },
        hmr: {
            host: 'localhost',
            protocol: 'ws',
        },
        cors: {
            origin: 'http://localhost:3000',
            methods: ['GET', 'POST', 'PUT', 'DELETE'],
            allowedHeaders: ['Content-Type', 'Authorization'],
        },
        proxy: {
             '/api': {
                target: 'http://localhost:3000',
                changeOrigin: true,
             },
          }
    },
    build: {
        outDir: 'frontend/public',
        emptyOutDir: true,
        manifest: true,
        rollupOptions: {
            input: 'src/main.js',
            output: {
                assetFileNames: (assetInfo) => {
                   let extType = assetInfo.name.split('.').pop();
                      if (extType === 'css'){
                         return `assets/css/[name]-[hash][extname]`;
                   }
                    return `assets/[name]-[hash][extname]`;
                },
           },
      },
    },
    optimizeDeps: {
         include: ['@rails/ujs'],
    },
});