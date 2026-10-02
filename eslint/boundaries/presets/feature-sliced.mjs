// Feature-Sliced Design: app > pages > widgets > features > entities > shared.
// A layer imports only from layers below; slices of the same layer must not import each other;
// a slice is consumed through its public API (index.*) from other layers.

/** @param {{ src: string }} o */
export default function featureSliced({ src }) {
  const order = ["app", "pages", "widgets", "features", "entities", "shared"];
  const sliced = new Set(["pages", "widgets", "features", "entities"]);
  const publicApi = { fileInternalPath: "index.{ts,tsx,js,jsx}" };

  return {
    elements: order.map((type) =>
      sliced.has(type)
        ? { type, pattern: `${src}/${type}/*`, capture: ["slice"] }
        : { type, pattern: `${src}/${type}` },
    ),
    policies: order.map((type, i) => {
      const below = order.slice(i + 1);
      const to = [
        // same slice: free; same layer other slice: forbidden (not listed)
        ...(sliced.has(type) ? [{ type, captured: { slice: "{{ from.element.captured.slice }}" } }] : [{ type }]),
        ...below.map((t) => (t === "shared" ? { type: t } : { type: t, ...publicApi })),
      ];
      return { from: { element: { type } }, allow: { to: { element: to } } };
    }),
  };
}
