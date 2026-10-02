// Modular monolith, Clean Architecture per module (this repo).
//   <src>/modules/<module>/{domain,application,infrastructure,presentation}
//   <src>/integrations/<integration>/...   <src>/shared/...   <src>/main/... (composition root)
// Modules talk to each other ONLY through `<module>/index.ts` (public facade).

/** @param {{ src: string }} o */
export default function modularClean({ src }) {
  const sameModule = {
    captured: { module: "{{ from.element.captured.module }}" },
  };
  const otherModuleFacade = {
    type: "module",
    captured: { module: "!{{ from.element.captured.module }}" },
    fileInternalPath: "index.ts",
  };

  return {
    elements: [
      // order matters: the first matching descriptor wins (layers before the module root)
      { type: "domain", pattern: `${src}/modules/*/domain`, capture: ["module"] },
      { type: "application", pattern: `${src}/modules/*/application`, capture: ["module"] },
      { type: "infrastructure", pattern: `${src}/modules/*/infrastructure`, capture: ["module"] },
      { type: "presentation", pattern: `${src}/modules/*/presentation`, capture: ["module"] },
      { type: "module", pattern: `${src}/modules/*`, capture: ["module"] },
      { type: "integration", pattern: `${src}/integrations/*`, capture: ["integration"] },
      { type: "shared", pattern: `${src}/shared` },
      { type: "main", pattern: `${src}/main` },
      { type: "seeds", pattern: `${src}/seeds` },
    ],
    policies: [
      { from: { element: { type: "shared" } }, allow: { to: { element: { type: "shared" } } } },
      {
        from: { element: { type: "domain" } },
        allow: { to: { element: [{ type: "domain", ...sameModule }, { type: "shared" }] } },
      },
      {
        from: { element: { type: "application" } },
        allow: {
          to: {
            element: [
              { types: { anyOf: ["domain", "application"] }, ...sameModule },
              { type: "shared" },
              otherModuleFacade,
              { type: "integration" },
            ],
          },
        },
      },
      {
        from: { element: { type: "infrastructure" } },
        allow: {
          to: {
            element: [
              { types: { anyOf: ["domain", "application", "infrastructure"] }, ...sameModule },
              { type: "shared" },
              otherModuleFacade,
              { type: "integration" },
            ],
          },
        },
      },
      {
        from: { element: { type: "presentation" } },
        allow: {
          to: {
            element: [
              { types: { anyOf: ["application", "presentation"] }, ...sameModule },
              { type: "shared" },
              otherModuleFacade,
              { type: "integration" },
            ],
          },
        },
      },
      // module root (index.ts facade) exposes application + wires infrastructure
      {
        from: { element: { type: "module" } },
        allow: {
          to: {
            element: [
              { types: { anyOf: ["domain", "application", "infrastructure", "presentation"] }, ...sameModule },
              { type: "shared" },
              otherModuleFacade,
            ],
          },
        },
      },
      {
        from: { element: { type: "integration" } },
        allow: { to: { element: [{ type: "integration" }, { type: "shared" }, otherModuleFacade] } },
      },
      // composition root and seeds may wire anything
      { from: { element: { types: { anyOf: ["main", "seeds"] } } }, allow: { to: { element: { isUnknown: false } } } },
    ],
  };
}
