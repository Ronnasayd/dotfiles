// Pluggable eslint-plugin-boundaries config. Copy `eslint/boundaries/` into any repo, then:
//   yarn add -D eslint-plugin-boundaries eslint-import-resolver-typescript
//   import { boundaries } from "./eslint/boundaries/index.mjs";
//   export default defineConfig([ ..., boundaries({ preset: "clean-arch" }) ]);
import boundariesPlugin from "eslint-plugin-boundaries";

import { presets } from "./presets/index.mjs";

const TEST_IGNORES = [
  "**/*.spec.*",
  "**/*.test.*",
  "**/__tests__/**",
  "**/__mocks__/**",
  "**/*.d.ts",
];

/**
 * @param {object} opts - options.
 * @param {keyof typeof presets | ((o: { src: string }) => { elements: object[]; policies: object[] })} opts.preset - preset name or custom factory.
 * @param {string} [opts.src] - source root, relative to cwd.
 * @param {string[]} [opts.files] - globs the rule applies to.
 * @param {string} [opts.tsconfigPath] - tsconfig used to resolve path aliases.
 * @param {"error"|"warn"|"off"} [opts.severity] - rule severity (use "warn" to adopt gradually).
 * @param {object[]} [opts.extraElements] - appended to the preset elements.
 * @param {object[]} [opts.extraPolicies] - appended AFTER the preset policies (later policies win).
 * @returns {object} flat config block.
 */
export function boundaries({
  preset,
  src = "src",
  files = [`${src}/**/*.{ts,tsx,js,jsx}`],
  tsconfigPath = "./tsconfig.json",
  severity = "error",
  extraElements = [],
  extraPolicies = [],
}) {
  const build = typeof preset === "function" ? preset : presets[preset];
  if (!build) throw new Error(`Unknown boundaries preset "${preset}". Use: ${Object.keys(presets).join(", ")}`);
  const { elements, policies } = build({ src });

  return {
    files,
    ignores: TEST_IGNORES,
    plugins: { boundaries: boundariesPlugin },
    settings: {
      "import/resolver": {
        typescript: { alwaysTryTypes: true, project: tsconfigPath },
      },
      "boundaries/elements": [...elements, ...extraElements],
    },
    rules: {
      "boundaries/dependencies": [
        severity,
        { default: "disallow", policies: [...policies, ...extraPolicies] },
      ],
      "boundaries/no-unknown-dependencies": severity,
    },
  };
}

export { presets };
