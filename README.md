# MQL5

MQL5 core and standard library implemented in proper C++ for use with language
servers and modern editors.

## Usage

To use the MQL5 header files, run the following command in your repository with
your expert advisors. This will add this repository as a submodule so you can
easily update when changes are made to type definitions.

```bash
git submodule add https://github.com/mskelton/mql5
```

### Configuring clang

To configure clang to recognize and use the MQL5 core types, create a
`compile_flags.txt` file in the root of your project and add the following to
it.

```
-Imql5/Include
--include=Core/MQL5.mqh
-std=c++11
-xc++
-Wno-write-strings
```

To fix the issue where some included files show a "Too many errors omitted,
stopping now" error, create a `.clangd` file with the following.

```yaml
CompileFlags:
  Add: -ferror-limit=0
```

### Updating type definitions

To update type definitions if there are new changes, simply run the following
command to update the submodule.

```bash
git submodule update --remote mql5
```
