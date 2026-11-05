# Homework 4

## Build

```bash
stack build
```

## nfib2

```bash
stack exec -- hw4-1 +RTS -N<n> -ls
```

## nfib4

```bash
stack exec -- hw4-2 12 +RTS -N<n> -ls
```

## ThreadScope (WSL)

```bash
threadscope hw4-1.EXE.eventlog
threadscope hw4-2.EXE.eventlog
```
