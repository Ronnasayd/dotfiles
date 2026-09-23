// @ts-check
/** @type {import('@stryker-mutator/api/core').PartialStrykerOptions} */
const config = {
  testRunner: "jest",
  plugins: [
    "@stryker-mutator/jest-runner",
    "@stryker-mutator/typescript-checker",
    "./stryker-plugins/logger-ignorer.mjs",
    "./stryker-plugins/openapi-ignorer.mjs",
  ],
  ignorers: ["loggerCalls", "openapiCalls"],
  jest: {
    projectType: "custom",
    configFile: "jest.config.js",
  },
  checkers: ["typescript"],
  tsconfigFile: "tsconfig.stryker.json",
  typescriptChecker: {
    prioritizePerformanceOverAccuracy: true,
  },
  mutate: [
    "src/**/*.ts",
    "src/**/*.tsx",
    "!src/**/*.test.ts",
    "!src/**/*.spec.ts",
    "!src/**/*.d.ts",
    "!src/__mocks__/**",
    "!src/**/__mocks__/**",
    "!src/**/MockLogger.ts",
    "!src/modules/auth/presentation/openapi/**",
    "!src/seeds/**",
    "!src/main/**",
  ],
  ignorePatterns: [
    ".claude",
    ".git",
    "android",
    "assets",
    "coverage",
    "docs",
    "node_modules",
    ".stryker",
    "**/CONTEXT.md",
  ],
  disableTypeChecks: "src/**/*.{js,jsx,ts,tsx}",
  reporters: ["html", "json", "clear-text", "progress"],
  coverageAnalysis: "all",
  tempDirName: ".stryker",
  timeoutMS: 10000,
  concurrency: 4,
  incremental: true,
};

export default config;
