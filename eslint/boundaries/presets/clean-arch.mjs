// Classic single-app Clean Architecture (dependency rule points inwards):
//   <src>/{domain,application,presentation|interface,infrastructure,shared,main}

/** @param {{ src: string }} o */
export default function cleanArch({ src }) {
  const allow = (from, ...to) => ({
    from: { element: { type: from } },
    allow: { to: { element: { types: { anyOf: [from, ...to] } } } },
  });
  return {
    elements: [
      { type: "domain", pattern: `${src}/domain` },
      { type: "application", pattern: `${src}/application` },
      { type: "infrastructure", pattern: `${src}/infrastructure` },
      { type: "presentation", pattern: `${src}/{presentation,interface,interfaces}` },
      { type: "shared", pattern: `${src}/shared` },
      { type: "main", pattern: `${src}/{main,app}` },
    ],
    policies: [
      allow("shared"),
      allow("domain", "shared"),
      allow("application", "domain", "shared"),
      allow("infrastructure", "domain", "application", "shared"),
      allow("presentation", "application", "shared"),
      allow("main", "domain", "application", "infrastructure", "presentation", "shared"),
    ],
  };
}
