// React-specific config (web or RN). Apply on top of base.mjs.
// yarn add eslint-plugin-react-hooks eslint-plugin-jsx-a11y
import jsxA11y from 'eslint-plugin-jsx-a11y';
import reactHooks from 'eslint-plugin-react-hooks';

/**
 * Builds the React hooks rules block.
 * @param {object} [opts] - options.
 * @param {string[]} [opts.files] - glob(s) this block applies to.
 * @returns {object} flat config block enabling react-hooks rules.
 */
export function reactHooksRules({ files = ['src/**/*.tsx'] } = {}) {
  return {
    files,
    plugins: { 'react-hooks': reactHooks },
    rules: {
      'react-hooks/rules-of-hooks': 'error',
      'react-hooks/exhaustive-deps': 'error',
    },
  };
}

/**
 * Builds the JSX accessibility rules block. Web-only — skip for React Native.
 * @param {object} [opts] - options.
 * @param {string[]} [opts.files] - glob(s) this block applies to.
 * @param {string[]} [opts.ignores] - glob(s) excluded from this block.
 * @returns {object} flat config block enabling jsx-a11y recommended rules.
 */
export function jsxA11yRules({ files = ['src/**/*.tsx'], ignores = ['**/*.spec.tsx', '**/*.test.tsx'] } = {}) {
  return {
    files,
    ignores,
    plugins: { 'jsx-a11y': jsxA11y },
    rules: {
      ...jsxA11y.flatConfigs.recommended.rules,
      'max-lines-per-function': ['warn', { max: 100, skipBlankLines: true, skipComments: true }],
    },
  };
}
