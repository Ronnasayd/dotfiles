// Default config, shared by every project type (plain TS, React, React Native).
// yarn add eslint-config-prettier eslint globals \
//   eslint-plugin-import-x eslint-plugin-jsdoc eslint-plugin-sonarjs \
//   eslint-plugin-unused-imports eslint-plugin-no-secrets eslint-plugin-unicorn \
//   eslint-plugin-security eslint-plugin-jest @eslint-community/eslint-plugin-eslint-comments \
//   typescript-eslint
import eslintConfigPrettier from 'eslint-config-prettier';
import globals from 'globals';

import eslintComments from '@eslint-community/eslint-plugin-eslint-comments';
import importPlugin from 'eslint-plugin-import-x';
import jest from 'eslint-plugin-jest';
import jsdoc from 'eslint-plugin-jsdoc';
import noSecrets from 'eslint-plugin-no-secrets';
import security from 'eslint-plugin-security';
import sonarjs from 'eslint-plugin-sonarjs';
import unicorn from 'eslint-plugin-unicorn';
import unusedImports from 'eslint-plugin-unused-imports';
import tseslint from 'typescript-eslint';

const TEST_FILES = [
  '**/*.spec.ts',
  '**/*.test.ts',
  '**/*.spec.js',
  '**/*.test.js',
  '**/*.spec.tsx',
  '**/*.test.tsx',
];

export const ignores = {
  ignores: [
    '**/node_modules/**',
    '**/.yarn/**',
    '**/dist/**',
    '**/build/**',
    'jest.env-setup.ts',
    'prisma.config.ts',
  ],
};

/**
 * Builds test-file override block.
 * @param {string} tsconfigPath - path to tsconfig.json used by the parser.
 * @returns {object} flat config block for spec/test files.
 */
export function testOverride(tsconfigPath = './tsconfig.json') {
  return {
    files: TEST_FILES,
    languageOptions: {
      parser: tseslint.parser,
      parserOptions: { project: tsconfigPath },
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: { ...globals.node },
    },
    plugins: {
      '@typescript-eslint': tseslint.plugin,
      'unused-imports': unusedImports,
      jsdoc,
      jest,
    },
    extends: [
      tseslint.configs.eslintRecommended,
      ...tseslint.configs.recommendedTypeChecked,
      sonarjs.configs.recommended,
      jsdoc.configs['flat/recommended-tsdoc'],
      jest.configs['flat/recommended'],
      eslintConfigPrettier,
    ],
    rules: {
      'jest/no-disabled-tests': 'warn',
      'jest/no-focused-tests': 'error',
      'jest/no-identical-title': 'error',
      'jest/no-conditional-expect': 'error',
      'jest/valid-expect': 'error',
      'jest/no-standalone-expect': 'error',
      'sonarjs/cognitive-complexity': 'off',
      'sonarjs/no-duplicate-string': 'off',
      'sonarjs/prefer-specific-assertions': 'off',
      'sonarjs/null-dereference': 'off',
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-floating-promises': 'off',
      '@typescript-eslint/no-misused-promises': 'off',
      '@typescript-eslint/no-unsafe-argument': 'off',
      '@typescript-eslint/no-unsafe-call': 'off',
      // False positive: jest.fn() mocks are always bound — toHaveBeenCalledWith pattern
      '@typescript-eslint/unbound-method': 'off',
      // Safe in tests: .catch((e) => e) pattern for asserting error properties
      '@typescript-eslint/no-unsafe-assignment': 'off',
      '@typescript-eslint/no-unsafe-return': 'off',
      '@typescript-eslint/no-unsafe-member-access': 'off',
      'jsdoc/require-jsdoc': 'off',
      'jsdoc/require-param': 'off',
      'jsdoc/require-returns': 'off',
      'jsdoc/require-description': 'off',
      'max-lines-per-function': 'off',
    },
  };
}

/**
 * Builds the base TypeScript config block, applicable to any project type.
 * @param {object} [opts] - options.
 * @param {string} [opts.files] - glob for files this block applies to.
 * @param {string} [opts.tsconfigPath] - path to tsconfig.json used by the parser.
 * @returns {object} flat config block for non-test TypeScript files.
 */
export function typescriptBase({
  files = ['src/**/*.ts', 'src/**/*.tsx'],
  tsconfigPath = './tsconfig.json',
} = {}) {
  return {
    files,
    ignores: TEST_FILES,

    languageOptions: {
      parser: tseslint.parser,
      parserOptions: { project: tsconfigPath },
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: { ...globals.node },
    },

    plugins: {
      '@typescript-eslint': tseslint.plugin,
      'import-x': importPlugin,
      'unused-imports': unusedImports,
      jsdoc,
      'no-secrets': noSecrets,
      unicorn,
      security,
      'eslint-comments': eslintComments,
    },

    extends: [
      tseslint.configs.eslintRecommended,
      ...tseslint.configs.recommendedTypeChecked,
      importPlugin.flatConfigs.recommended,
      sonarjs.configs.recommended,
      jsdoc.configs['flat/recommended-tsdoc'],
      security.configs.recommended,
      eslintConfigPrettier, // MUST be last
    ],

    rules: {
      'sonarjs/no-skipped-tests': 'off',
      // ---- Reuse: flag copy-pasted logic agents love to duplicate instead of extracting
      'sonarjs/no-identical-functions': 'error',

      // ---- Secrets
      'no-secrets/no-secrets': ['error', { tolerance: 4.2 }],

      // ---- TS suppression comments
      '@typescript-eslint/ban-ts-comment': [
        'error',
        { 'ts-ignore': 'allow-with-description', minimumDescriptionLength: 10 },
      ],

      // ---- Unicorn (curated, non-invasive subset)
      'unicorn/no-array-push-push': 'warn',
      'unicorn/no-useless-promise-resolve-reject': 'error',
      'unicorn/prefer-includes': 'warn',
      'unicorn/prefer-array-find': 'warn',
      'unicorn/no-negated-condition': 'off',
      'unicorn/prevent-abbreviations': 'off',
      'unicorn/filename-case': 'off',

      // ---- Structure
      complexity: ['error', { max: 15 }],
      'max-depth': ['error', 3],
      'max-lines-per-function': ['warn', { max: 60, skipBlankLines: true, skipComments: true }],
      // max-params disabled at base — DI constructors legitimately exceed 4
      'max-params': 'off',

      // ---- TypeScript critical
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/no-floating-promises': 'error',
      '@typescript-eslint/no-misused-promises': 'error',
      '@typescript-eslint/consistent-type-imports': ['warn', { prefer: 'type-imports' }],
      '@typescript-eslint/no-unnecessary-type-assertion': 'error',
      '@typescript-eslint/no-non-null-assertion': 'error',
      '@typescript-eslint/switch-exhaustiveness-check': 'error',
      '@typescript-eslint/require-await': 'error',
      '@typescript-eslint/no-confusing-void-expression': ['error', { ignoreArrowShorthand: true }],
      '@typescript-eslint/no-unused-vars': 'off', // handled by unused-imports plugin
      // Forces agents to declare intended return types instead of letting inference drift silently
      '@typescript-eslint/explicit-module-boundary-types': 'warn',

      // ---- Clean
      'unused-imports/no-unused-imports': 'error',
      'unused-imports/no-unused-vars': [
        'warn',
        { argsIgnorePattern: '^_', varsIgnorePattern: '^_' },
      ],

      // ---- Imports
      'import-x/order': [
        'warn',
        {
          groups: ['builtin', 'external', 'internal'],
          'newlines-between': 'always',
          alphabetize: { order: 'asc', caseInsensitive: true },
        },
      ],
      'import-x/no-unresolved': 'off',
      'import-x/namespace': 'off',
      'import-x/no-cycle': ['warn', { maxDepth: 5, ignoreExternal: true }],
      'import-x/no-duplicates': 'error',
      'import-x/no-extraneous-dependencies': ['error', { devDependencies: TEST_FILES }],

      // ---- File size
      'max-lines': ['warn', { max: 300, skipBlankLines: true, skipComments: true }],

      // ---- Bug prevention
      'no-restricted-imports': [
        'error',
        {
          patterns: [
            {
              regex: '^\\.\\./',
              message:
                'Use path aliases (@src/, @modules/) instead of relative imports that go up directories (../).',
            },
          ],
        },
      ],
      'no-console': ['warn', { allow: ['warn', 'error'] }],
      'no-restricted-syntax': [
        'error',
        {
          selector:
            "CallExpression[callee.object.name='console'] TemplateLiteral > Identifier[name=/token|secret|password|apikey|api_key/i]",
          message: 'Do not log tokens/secrets/passwords, even interpolated into a string.',
        },
      ],
      'no-debugger': 'error',
      eqeqeq: ['error', 'always', { null: 'ignore' }],
      curly: ['error', 'all'],
      'sonarjs/null-dereference': 'off',
      'sonarjs/super-linear-regex': 'off',
      'jsdoc/require-description': 'error',
      'jsdoc/require-jsdoc': [
        'error',
        {
          require: {
            FunctionDeclaration: true,
            MethodDefinition: true,
            ClassDeclaration: false,
            ClassExpression: false,
            ArrowFunctionExpression: false,
            FunctionExpression: true,
          },
          publicOnly: false,
        },
      ],
      'jsdoc/require-param': ['error', { enableFixer: false }],
      'jsdoc/require-param-description': 'error',
      'jsdoc/require-param-name': 'error',
      'jsdoc/require-returns': ['error', { forceReturnsWithAsync: false }],
      'jsdoc/require-returns-description': 'error',
      // Full error is noise-inducing: agents pad throwaway examples just to satisfy lint.
      'jsdoc/require-example': 'warn',
      'no-else-return': ['error', { allowElseIf: false }],
      'no-warning-comments': ['warn', { terms: ['todo', 'fixme', 'xxx'], location: 'anywhere' }],

      // ---- Suppression comments: block agents from silencing lint instead of fixing it
      'eslint-comments/no-unlimited-disable': 'error',
      'eslint-comments/no-unused-disable': 'error',
      'eslint-comments/require-description': ['error', { ignore: [] }],
    },
  };
}
