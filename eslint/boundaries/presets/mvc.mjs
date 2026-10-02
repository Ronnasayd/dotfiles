// MVC (Express/Rails/Laravel style):
//   routes -> controllers -> services -> repositories -> models ; views/serializers read models.

/** @param {{ src: string }} o */
export default function mvc({ src }) {
  const allow = (from, ...to) => ({
    from: { element: { type: from } },
    allow: { to: { element: { types: { anyOf: [from, ...to] } } } },
  });
  return {
    elements: [
      { type: "routes", pattern: `${src}/{routes,router}` },
      { type: "controllers", pattern: `${src}/controllers` },
      { type: "middlewares", pattern: `${src}/middlewares` },
      { type: "services", pattern: `${src}/services` },
      { type: "repositories", pattern: `${src}/repositories` },
      { type: "models", pattern: `${src}/{models,entities}` },
      { type: "views", pattern: `${src}/{views,serializers,presenters}` },
      { type: "lib", pattern: `${src}/{lib,utils,helpers,config,types}` },
      { type: "main", pattern: `${src}/{main,app,server}` },
    ],
    policies: [
      allow("lib"),
      allow("models", "lib"),
      allow("repositories", "models", "lib"),
      allow("services", "repositories", "models", "lib"),
      allow("views", "models", "lib"),
      allow("middlewares", "services", "models", "lib"),
      allow("controllers", "services", "models", "views", "lib"),
      allow("routes", "controllers", "middlewares", "lib"),
      allow("main", "routes", "controllers", "middlewares", "services", "repositories", "models", "views", "lib"),
    ],
  };
}
