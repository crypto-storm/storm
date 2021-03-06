#!/usr/bin/env node

const path = require('path')
const esbuild = require('esbuild')
const rails = require('esbuild-rails')

const clients = []

const config = {
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  bundle: true,
  entryPoints: ["application.js"],
  outdir: path.join(process.cwd(), "app/assets/builds"),
  plugins: [rails()],
  sourcemap: process.env.RAILS_ENV != "production"
};

async function builder() {
  const chokidar = require('chokidar')
  const http = require('http')

  http.createServer((req, res) => {
    return clients.push(
      res.writeHead(200, {
        "Content-Type": "text/event-stream",
        "Cache-Control": "no-cache",
        "Access-Control-Allow-Origin": "*",
        Connection: "keep-alive",
      }),
    );
  }).listen(8082);

  let result = await require("esbuild").build({
    ...config,
    incremental: true,
    banner: {
      js: ' (() => new EventSource("http://localhost:8082").onmessage = () => location.reload())();',
    }
  })

  chokidar.watch(["./app/javascript/**/*.js", "./app/views/**/*.html.erb", "./app/assets/stylesheets/*.css"]).on('all', (event, path) => {
    if (path.includes("javascript")) {
      result.rebuild()
    }
    clients.forEach((res) => res.write('data: update\n\n'))
    clients.length = 0
  });
}

if (process.argv.includes("--watch")) {
  builder()
} else {
  esbuild.build({
    ...config,
    minify: process.env.RAILS_ENV == "production",
  }).catch(() => process.exit(1));
}
