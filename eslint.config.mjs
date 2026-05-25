import eslintConfigPrettier from "eslint-config-prettier";
import { defineConfig } from "eslint/config";
import globals from "globals";

import importPlugin from "eslint-plugin-import-x";
import jsdoc from "eslint-plugin-jsdoc";
import sonarjs from "eslint-plugin-sonarjs";
import unusedImports from "eslint-plugin-unused-imports";
import tseslint from "typescript-eslint";

export default defineConfig([
  // ========================
  // IGNORED PATHS
  // ========================
  {
    ignores: ["dist", "node_modules"]
  },

  // ========================
  // TYPESCRIPT CONFIG
  // ========================
  {
    files: ["**/*.ts", "**/*.tsx"],

    languageOptions: {
      parser: tseslint.parser,
      parserOptions: {
        project: "./tsconfig.json"
      },
      ecmaVersion: 2022,
      sourceType: "module",
      globals: {
        ...globals.node
      }
    },

    plugins: {
      "@typescript-eslint": tseslint.plugin,
      import: importPlugin,
      "unused-imports": unusedImports,
      jsdoc: jsdoc
    },

    extends: [
      tseslint.configs.eslintRecommended,
      ...tseslint.configs.recommendedTypeChecked,
      importPlugin.flatConfigs.recommended,
      sonarjs.configs.recommended,
      jsdoc.configs["flat/recommended-tsdoc"],
      eslintConfigPrettier // MUST be last
    ],

    rules: {
      "sonarjs/no-empty-test-file": "off",
      // ---- Structure
      complexity: ["error", { max: 15 }],
      "max-depth": ["error", 3],
      // max-params disabled at base — DI constructors legitimately exceed 4
      "max-params": "off",

      // ---- TypeScript critical
      "@typescript-eslint/no-explicit-any": "warn",
      "@typescript-eslint/no-floating-promises": "error",
      "@typescript-eslint/no-misused-promises": "error",
      "@typescript-eslint/consistent-type-imports": [
        "warn",
        { prefer: "type-imports" }
      ],
      "@typescript-eslint/no-unnecessary-type-assertion": "warn",
      "@typescript-eslint/no-unused-vars": "off", // handled by unused-imports plugin

      // ---- Clean
      "unused-imports/no-unused-imports": "error",
      "unused-imports/no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],

      // ---- Imports
      "import/order": [
        "warn",
        {
          groups: ["builtin", "external", "internal"],
          "newlines-between": "always",
          alphabetize: { order: "asc", caseInsensitive: true }
        }
      ],
      "import/no-cycle": "error",
      "import/no-unresolved": "off",
      "import-x/no-unresolved": "off",

      // ---- Bug prevention
      "no-console": ["warn", { allow: ["warn", "error"] }],
      "no-debugger": "error",
      eqeqeq: ["error", "always", { null: "ignore" }],
      curly: ["error", "all"],
      "jsdoc/require-description": "error",
      "jsdoc/require-jsdoc": [
        "error",
        {
          require: {
            FunctionDeclaration: true,
            MethodDefinition: true,
            ClassDeclaration: false,
            ArrowFunctionExpression: false,
            FunctionExpression: true
          },
          publicOnly: false
        }
      ],
      "jsdoc/require-param": ["error", { enableFixer: false }],
      "jsdoc/require-param-description": "error",
      "jsdoc/require-param-name": "error",
      "jsdoc/require-returns": ["error", { forceReturnsWithAsync: false }],
      "jsdoc/require-returns-description": "error"
    }
  },

  // ========================
  // TESTS OVERRIDE
  // ========================
  {
    files: ["**/*.spec.ts", "**/*.test.ts", "**/*.spec.js", "**/*.test.js"],
    rules: {
      "sonarjs/cognitive-complexity": "off",
      "sonarjs/no-duplicate-string": "off",
      "@typescript-eslint/no-explicit-any": "off",
      "@typescript-eslint/no-floating-promises": "off",
      "@typescript-eslint/no-misused-promises": "off",
      "jsdoc/require-jsdoc": "off",
      "jsdoc/require-param": "off",
      "jsdoc/require-returns": "off",
      "jsdoc/require-description": "off"
    }
  }
]);
