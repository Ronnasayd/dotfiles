// React Native-specific config. Apply on top of base.mjs + react.mjs.
// yarn add @react-native/eslint-plugin
import reactNative from '@react-native/eslint-plugin';

/**
 * Builds the React Native rules block.
 * @param {object} [opts] - options.
 * @param {string[]} [opts.files] - glob(s) this block applies to.
 * @returns {object} flat config block enabling @react-native rules.
 */
export function reactNativeRules({ files = ['src/**/*.ts', 'src/**/*.tsx'] } = {}) {
  return {
    files,
    plugins: { '@react-native': reactNative },
    rules: {
      '@react-native/no-deep-imports': 'error',
      '@react-native/platform-colors': 'warn',
    },
  };
}
