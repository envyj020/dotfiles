const capitalize = <T extends string>(s: T) =>
  (s[0].toUpperCase() + s.slice(1)) as Capitalize<typeof s>;

const logosPaths = import.meta.glob("../assets/logos/distros/*.svg", {
  eager: true,
});
const screenshotPaths = import.meta.glob("../assets/screenshots/*.png", {
  eager: true,
});

export const Logos = Object.entries(logosPaths).map(([path, module]) => {
  return {
    name: capitalize(path.split("/").pop()?.split(".")[0]) || "unknown",
    src: module.default.src,
  };
});

export const Screenshots = Object.entries(screenshotPaths).map(
  ([path, module]) => {
    return {
      name: path.split("/").pop()?.split(".")[0] || "unknown",
      src: module.default.src,
    };
  },
);
