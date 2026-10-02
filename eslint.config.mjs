import { defineConfig } from "eslint/config";

import { ignores, testOverride, typescriptBase } from "./eslint/base.mjs";
import { boundaries } from "./eslint/boundaries/index.mjs";

export default defineConfig([
  ignores,
  testOverride(),
  typescriptBase(),
  // warn: existing drift (sync->auth internals, application->infrastructure) still to be fixed
  boundaries({ preset: "modular-clean", severity: "warn" }),
  // reactHooksRules(),
  // jsxA11yRules(),
  // reactNativeRules(),

  // ========================
  // INFRASTRUCTURE OVERRIDES
  // ========================
  {
    // declare global { namespace Express } is the only correct way to augment Express types
    files: ["src/**/infrastructure/**/*.ts", "src/**/integrations/**/*.ts"],
    rules: {
      "@typescript-eslint/no-namespace": "off",
    },
  },
  {
    files: ["src/**/*.spec.ts", "src/**/*.test.ts"],
    rules: {
      "sonarjs/no-skipped-tests": "off",
      "sonarjs/assertions-in-tests": "off",
      "sonarjs/no-hardcoded-passwords": "off",
    },
  },
]);
