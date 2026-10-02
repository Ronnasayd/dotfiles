import cleanArch from "./clean-arch.mjs";
import featureSliced from "./feature-sliced.mjs";
import hexagonal from "./hexagonal.mjs";
import layered from "./layered.mjs";
import modularClean from "./modular-clean.mjs";
import mvc from "./mvc.mjs";

export const presets = {
  "modular-clean": modularClean,
  "clean-arch": cleanArch,
  hexagonal,
  mvc,
  layered,
  "feature-sliced": featureSliced,
};
