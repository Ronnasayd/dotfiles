import { defineConfig } from "eslint/config";

import { ignores, testOverride, typescriptBase } from "./eslint/base.mjs";
import { reactNativeRules } from "./eslint/react-native.mjs";
import { jsxA11yRules, reactHooksRules } from "./eslint/react.mjs";

export default defineConfig([
  ignores,
  testOverride(),
  typescriptBase(),
  reactHooksRules(),
  jsxA11yRules(),
  reactNativeRules(),

  // ========================
  // INFRASTRUCTURE OVERRIDES
  // ========================
  {
    // declare global { namespace Express } is the only correct way to augment Express types
    files: ["src/**/infrastructure/**/*.ts", "src/**/integrations/**/*.ts"],
    rules: {
      "@typescript-eslint/no-namespace": "off"
    }
  }
]);
