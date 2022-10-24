import fs from "node:fs"
import path from "node:path"
import * as readline from "node:readline"
import events from "node:events"

const [file] = process.argv.slice(2)
const rl = readline.createInterface({
  input: fs.createReadStream(file, "utf8"),
})

const blocks = []
const lines = []

rl.on("line", (line) => {
  // console.log(blocks.length, line)

  // Don't add classes or enums to the list of blocks
  if (
    line.startsWith("class") ||
    line.startsWith("enum") ||
    line.startsWith("struct")
  ) {
    lines.push(line)
    return
  }

  // Only keep the line if it's outside a block
  if (!blocks.length) {
    // Throw away implementations
    if (!line.includes("::")) {
      let content = line
        .replace(/:.+/, ";")
        .replace(/\{\}?/, ";")
        .replace(/\&(.+?)\[\]/g, (group) => group.substring(1))
        .replace("[];", ";")

      if (content.trimStart().startsWith("#include")) {
        content = content.replace(/\\/g, "/")
      }

      lines.push(content)
    } else {
      // Class method implementations are removed completely. Add a "fake" block
      blocks.push("::")

      // Remove template decl
      if (lines.at(-1).trimStart().startsWith("template <typename")) {
        lines.pop()
      }
    }
  }

  // Class methods can be on the same or different lines
  if (/\{\}?$/.test(line.trimEnd())) {
    // Replace the fake block
    if (blocks.at(-1) === "::") {
      blocks.pop()
    }

    if (!line.trimEnd().endsWith("}")) {
      blocks.push("{")
    }
  }

  // End of block
  if (line.trimStart().startsWith("}")) {
    blocks.pop()
  }
})

await events.once(rl, "close")
lines.push("")
const content = lines.join("\n")

const newPath = file.replace("IncludeOriginal", "Include")
await fs.promises.mkdir(path.dirname(newPath), { recursive: true })
await fs.promises.writeFile(newPath, content)
