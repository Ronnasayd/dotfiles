import { defineConfig } from 'eslint/config'
import globals from 'globals'

import importPlugin from 'eslint-plugin-import'
import sonarjs from 'eslint-plugin-sonarjs'
import unusedImports from 'eslint-plugin-unused-imports'
import tseslint from 'typescript-eslint'

export default defineConfig([
  // ========================
  // BASE (shared)
  // ========================
  {
    ignores: ['dist', 'node_modules']
  },

  // ========================
  // JAVASCRIPT CONFIG
  // ========================
  {
    files: ['**/*.js', '**/*.mjs', '**/*.cjs'],

    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        ...globals.node
      }
    },

    plugins: {
      import: importPlugin,
      'unused-imports': unusedImports,
      sonarjs
    },

    rules: {
      // ---- Structure (keep yours, slightly relaxed)
      complexity: ['error', { max: 8 }],
      'max-depth': ['error', 3],
      'max-params': ['error', 4],

      // ---- Clean code
      'unused-imports/no-unused-imports': 'error',
      'unused-imports/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],

      // ---- Imports
      'import/order': [
        'error',
        {
          groups: ['builtin', 'external', 'internal'],
          'newlines-between': 'always',
          alphabetize: { order: 'asc', caseInsensitive: true }
        }
      ],
      'import/no-cycle': 'error',

      // ---- Bug prevention
      'no-console': ['warn', { allow: ['warn', 'error'] }],
      'no-debugger': 'error',
      eqeqeq: ['error', 'always'],
      curly: ['error', 'all'],

      // ---- Maintainability
      'sonarjs/cognitive-complexity': ['warn', 15]
    }
  },

  // ========================
  // TYPESCRIPT CONFIG
  // ========================
  {
    files: ['**/*.ts', '**/*.tsx'],

    languageOptions: {
      parser: tseslint.parser,
      parserOptions: {
        project: './tsconfig.json'
      },
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        ...globals.node
      }
    },

    plugins: {
      '@typescript-eslint': tseslint.plugin,
      import: importPlugin,
      'unused-imports': unusedImports,
      sonarjs
    },

    rules: {
      // ---- Structure
      complexity: ['error', { max: 8 }],
      'max-depth': ['error', 3],
      'max-params': ['error', 4],

      // ---- Replace size rules with real metric
      'sonarjs/cognitive-complexity': ['warn', 15],

      // ---- TS critical (main difference)
      '@typescript-eslint/no-floating-promises': 'error',
      '@typescript-eslint/await-thenable': 'error',
      '@typescript-eslint/no-misused-promises': [
        'error',
        { checksVoidReturn: false }
      ],
      '@typescript-eslint/consistent-type-imports': 'error',

      // ---- Clean
      '@typescript-eslint/no-unused-vars': 'off',
      'unused-imports/no-unused-imports': 'error',
      'unused-imports/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],

      // ---- Imports
      'import/order': [
        'error',
        {
          groups: ['builtin', 'external', 'internal'],
          'newlines-between': 'always',
          alphabetize: { order: 'asc', caseInsensitive: true }
        }
      ],
      'import/no-cycle': 'error',

      // ---- Bug prevention
      'no-console': ['warn', { allow: ['warn', 'error'] }],
      'no-debugger': 'error',
      eqeqeq: ['error', 'always'],
      curly: ['error', 'all'],

      // ---- Code quality
      'sonarjs/no-duplicate-string': 'warn'
    }
  },

  // ========================
  // TESTS OVERRIDE
  // ========================
  {
    files: ['**/*.test.ts', '**/*.test.js'],
    rules: {
      'sonarjs/cognitive-complexity': 'off',
      '@typescript-eslint/no-explicit-any': 'off'
    }
  }
])
