# Homework 4

## Environment

### Install ThreadScope on WSL Ubuntu

```bash
cd ~ && curl -LO https://github.com/haskell/ThreadScope/releases/download/v0.2.15.1/threadscope-ghc-9.10-ubuntu-latest.tar.xz
tar -xJf threadscope-ghc-9.10-ubuntu-latest.tar.xz && mkdir -p ~/.local/bin && mv threadscope ~/.local/bin/ && chmod +x ~/.local/bin/threadscope
```

## Build

```bash
stack build
```

## Run

### nfib2

```bash
stack exec -- hw4-1 +RTS -N<n> -s
```

### nfib4

```bash
stack exec -- hw4-2 <depth> +RTS -N<n> -s
```

## Test

### Generate Logs

```bash
stack exec -- hw4-1 +RTS -N20 -ls
stack exec -- hw4-2 4 +RTS -N20 -ls
```

### View on WSL

```bash
threadscope hw4-1.EXE.eventlog
threadscope hw4-2.EXE.eventlog
```
