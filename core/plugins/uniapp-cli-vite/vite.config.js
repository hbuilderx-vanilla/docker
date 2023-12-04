import { defineConfig } from "vite";
import uni from "@dcloudio/vite-plugin-uni";

/**
 * @type {import('vite').UserConfig}
 */
export default defineConfig({
  plugins: [uni()],
});
