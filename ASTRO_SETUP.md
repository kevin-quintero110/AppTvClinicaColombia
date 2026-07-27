# @astrojs/node

An Astro adapter for Node.js to use in SSR mode.

## Usage

Add `@astrojs/node` to your project's dependencies using your preferred package manager. If you're using npm or unsure, run this in the terminal:

```bash
npm install @astrojs/node
```

Then, add this adapter to your `astro.config.*` file:

```js
import node from "@astrojs/node";

export default {
  output: "server",
  adapter: node(),
};
```

For additional options, please read our full [Node.js Adapter documentation](https://docs.astro.build/en/guides/integrations-guide/node/).
