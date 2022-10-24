import fs from "node:fs"
import * as readline from "node:readline"
import events from "node:events"

const [file] = process.argv.slice(2)
const path = new URL(file, import.meta.url)

const rl = readline.createInterface({
  input: fs.createReadStream(path, "utf8"),
})

let idx = 0
let colons = false
const lines = []
const blocks = []

rl.on("line", (line) => {
  idx++

  if (line.includes("::")) {
    blocks.push(idx)
    colons = true
  } else if (line.trimEnd().endsWith("{") && !line.startsWith("class ")) {
    if (colons) {
      colons = false
    }

    if (
      !line.endsWith(") {") &&
      !line.endsWith(") const {") &&
      line.trim() !== "do {"
    ) {
      lines.push(line.replace("{", ";"))
    }
  } else if (line.trim().startsWith("}") && blocks.length) {
    blocks.pop()
  } else if (!blocks.length) {
    lines.push(line)
  }
})

await events.once(rl, "close")
lines.push("")
await fs.promises.writeFile(path, lines.join("\n"))
