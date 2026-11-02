# Homework 4

## nfib2

```bash
ghc -O2 -threaded -rtsopts hw4-1.hs
./hw4-1 +RTS -N<n> -ls
```

## nfib4

```bash
ghc -O2 -threaded -rtsopts hw4-2.hs
./hw4-2 12 +RTS -N<n> -ls
```

## ThreadScope (WSL)

```bash
threadscope hw4-1.eventlog
threadscope hw4-2.eventlog
```
