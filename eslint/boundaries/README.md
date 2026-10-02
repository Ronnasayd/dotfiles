# eslint/boundaries

Config plugável do [eslint-plugin-boundaries](https://github.com/javierbrea/eslint-plugin-boundaries) v7. Copie a pasta para qualquer repo.

```bash
yarn add -D eslint-plugin-boundaries eslint-import-resolver-typescript
```

```js
import { boundaries } from "./eslint/boundaries/index.mjs";

export default defineConfig([
  // ...
  boundaries({ preset: "clean-arch", src: "src", severity: "warn" })
]);
```

## Presets

| Preset           | Estrutura esperada                                                                                   | Regra                                                            |
| ---------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| `modular-clean`  | `src/modules/<m>/{domain,application,infrastructure,presentation}`, `integrations`, `shared`, `main` | Clean Arch por módulo; entre módulos só via `index.ts`           |
| `clean-arch`     | `src/{domain,application,infrastructure,presentation,shared,main}`                                   | dependência aponta para dentro                                   |
| `hexagonal`      | `src/{domain,application,adapters/{in,out},shared,config}`                                           | adapters dependem do core, nunca o inverso                       |
| `mvc`            | `src/{routes,controllers,middlewares,services,repositories,models,views,lib,main}`                   | routes → controllers → services → repositories → models          |
| `layered`        | `src/{presentation,business,data,common,main}`                                                       | presentation → business → data                                   |
| `feature-sliced` | `src/{app,pages,widgets,features,entities,shared}`                                                   | só camadas abaixo; slices irmãos isolados; API pública `index.*` |

## Opções

`preset` (nome ou função `({src}) => ({elements, policies})`), `src`, `files`, `tsconfigPath`,
`severity` (`error` | `warn` | `off`, use `warn` para adoção gradual), `extraElements`, `extraPolicies`.

Specs, `__tests__` e `__mocks__` são ignorados. `default: "disallow"`: o que não está em uma policy é violação.
Um novo preset é um arquivo em `presets/` exportando `({src}) => ({elements, policies})`, registrado em `presets/index.mjs`.
