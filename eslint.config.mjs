import { defineConfig } from 'eslint/config'
import globals from 'globals'

export default defineConfig([
  {
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: 'module',
      globals: {
        ...globals.node,
        foo: 'readonly'
      }
    },
    rules: {
      // Cyclomatic complexity
      complexity: ['error', { max: 6 }],

      // Limit nesting
      'max-depth': ['error', 3],

      // Limit function size
      'max-lines-per-function': [
        'error',
        {
          max: 30,
          skipBlankLines: true,
          skipComments: true
        }
      ],

      // Limit parameters
      'max-params': ['error', 4],

      // Limit statements per function
      'max-statements': ['error', 10]
    }
  }
])
