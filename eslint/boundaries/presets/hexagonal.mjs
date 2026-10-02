// Ports & Adapters: <src>/{domain,application,adapters/{in|inbound|driving},adapters/{out|outbound|driven},config}
// Adapters depend on the core; the core never depends on adapters.

/** @param {{ src: string }} o */
export default function hexagonal({ src }) {
  const allow = (from, ...to) => ({
    from: { element: { type: from } },
    allow: { to: { element: { types: { anyOf: [from, ...to] } } } },
  });
  return {
    elements: [
      { type: "domain", pattern: `${src}/domain` },
      { type: "application", pattern: `${src}/{application,ports}` },
      { type: "adapter-in", pattern: `${src}/adapters/{in,inbound,driving}` },
      { type: "adapter-out", pattern: `${src}/adapters/{out,outbound,driven}` },
      { type: "shared", pattern: `${src}/shared` },
      { type: "config", pattern: `${src}/{config,main,app}` },
    ],
    policies: [
      allow("shared"),
      allow("domain", "shared"),
      allow("application", "domain", "shared"),
      allow("adapter-in", "application", "domain", "shared"),
      allow("adapter-out", "application", "domain", "shared"),
      allow("config", "domain", "application", "adapter-in", "adapter-out", "shared"),
    ],
  };
}
