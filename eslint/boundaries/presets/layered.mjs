// N-tier / layered: presentation -> business -> data. Strict (no layer skipping upwards).
//   <src>/{presentation|api|web, business|services|domain, data|persistence|repositories, common|shared}

/** @param {{ src: string }} o */
export default function layered({ src }) {
  const allow = (from, ...to) => ({
    from: { element: { type: from } },
    allow: { to: { element: { types: { anyOf: [from, ...to] } } } },
  });
  return {
    elements: [
      { type: "presentation", pattern: `${src}/{presentation,api,web,ui}` },
      { type: "business", pattern: `${src}/{business,services,domain}` },
      { type: "data", pattern: `${src}/{data,persistence,repositories,dal}` },
      { type: "common", pattern: `${src}/{common,shared,lib,utils,config}` },
      { type: "main", pattern: `${src}/{main,app}` },
    ],
    policies: [
      allow("common"),
      allow("data", "common"),
      allow("business", "data", "common"),
      allow("presentation", "business", "common"),
      allow("main", "presentation", "business", "data", "common"),
    ],
  };
}
