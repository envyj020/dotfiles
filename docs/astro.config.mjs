// @ts-check
import { defineConfig, fontProviders } from "astro/config";
import Icons from "starlight-plugin-icons";
import NovaTheme from "starlight-theme-nova";
import UnoCSS from "unocss/astro";

// https://astro.build/config
export default defineConfig({
  site: "https://envyj020.github.io",
  base: import.meta.env.PROD ? "/dotfiles" : "/",
  integrations: [
    UnoCSS(),
    Icons({
      sidebar: true,
      extractSafelist: true,
      starlight: {
        plugins: [NovaTheme()],
        expressiveCode: true,
        title: "Yes, yet another dotfiles",
        favicon: "favicon.png",
        lastUpdated: true,
        logo: {
          dark: "./src/assets/logos/home/100x100-dark.png",
          light: "./src/assets/logos/home/100x100-light.png",
          replacesTitle: false,
        },
        editLink: {
          baseUrl: "https://github.com/envyj020/dotfiles/edit/main/",
        },
        customCss: [
          "@fontsource/jetbrains-mono/400.css",
          "@fontsource/jetbrains-mono/600.css",
          "@fontsource/jetbrains-mono/800.css",
          "./src/css/custom.css",
        ],
        social: [
          {
            icon: "github",
            label: "GitHub",
            href: "https://github.com/envyj020/dotfiles",
          },
        ],
        sidebar: [
          {
            label: "Guides",
            items: [
              {
                icon: "i-catppuccin:batch",
                label: "Desktop Overview",
                link: "guides/overview",
              },
              {
                icon: "i-catppuccin:rokit",
                label: "Installation",
                link: "guides/installation",
              },
            ],
          },
          {
            label: "Keybindings",
            items: [
              {
                icon: "i-catppuccin:vim",
                label: "Neovim",
                link: "keybindings/neovim",
              },
              {
                icon: "i-catppuccin:taskfile",
                label: "i3wm",
                link: "keybindings/i3",
              },
              {
                icon: "i-catppuccin:bash",
                label: "GNU Readline",
                link: "keybindings/readline",
              },
            ],
          },
        ],
      },
    }),
  ],
});
