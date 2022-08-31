import { defineConfig } from "vite";
import { svelte } from "@sveltejs/vite-plugin-svelte";
import { minify } from "html-minifier";
import { resolve } from "path";
function minifyHtml() {
  return {
    name: "html-transform",
    transformIndexHtml(html) {
      return minify(html, {
        collapseWhitespace: true,
      });
    },
  };
}

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const isProduction = mode === "production";
  return {
    plugins: [svelte(), isProduction && minifyHtml()],
    base: "./",
    resolve: {
      alias: {
        "@assets": resolve("./src/assets"),
        "@components": resolve("./src/components"),
        "@providers": resolve("./src/providers"),
        "@store": resolve("./src/store"),
        "@utils": resolve("./src/utils"),
        "@base": resolve("./src/components/base"),
        "@shared": resolve("./src/components/shared"),
        "@apps": resolve("./src/components/apps"),
      },
    },
    build: {
      minify: isProduction,

      emptyOutDir: true,
      outDir: "../html",
      assetsDir: "./",
      rollupOptions: {
        output: {
          entryFileNames: `js/[name].js`,
          chunkFileNames: `js/[name].js`,
          assetFileNames: `assets/[name].[ext]`,
        },
      },
    },
  };
});
