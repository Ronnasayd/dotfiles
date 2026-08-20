// Tailwind/NativeWind className linting. Apply on top of base.mjs.
// pnpm add -D eslint-plugin-tailwindcss
import tailwindcss from 'eslint-plugin-tailwindcss';

/**
 * Builds the Tailwind/NativeWind rules block.
 * @param {object} [opts] - options.
 * @param {string[]} [opts.files] - glob(s) this block applies to.
 * @returns {object[]} flat config blocks enabling tailwindcss rules.
 */
export function tailwindRules({ files = ['src/**/*.tsx'] } = {}) {
  return tailwindcss.configs['flat/recommended'].map((block) => ({ ...block, files }));
}
