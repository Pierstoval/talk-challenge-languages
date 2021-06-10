SHELL:=bash

_TITLE := "\033[32m %s\033[0m"
_ERROR := "\033[31m %s\033[0m"

.DEFAULT_GOAL=all

COUNT=0

.PHONY: all
all: clean
	@printf $(_TITLE) "🚀 Running all of them!"
	@echo "0" > .count
	@$(call check_hello_world,"  👉 C",c)
	@$(call check_hello_world,"  👉 C++",cpp)
	@$(call check_hello_world,"  👉 Cobol",cobol)
	@$(call check_hello_world,"  👉 Fortran",fortran)
	@$(call check_hello_world,"  👉 Go",go)
	@$(call check_hello_world,"  👉 Haskell",haskell)
	@$(call check_hello_world,"  👉 Java",java)
	@$(call check_hello_world,"  👉 Javascript\(Node.js\)",js)
	@$(call check_hello_world,"  👉 Julia",julia)
	@$(call check_hello_world,"  👉 Lua",lua)
	@$(call check_hello_world,"  👉 Lisp",lisp)
	@$(call check_hello_world,"  👉 OCaml",ocaml)
	@$(call check_hello_world,"  👉 Perl",perl)
	@$(call check_hello_world,"  👉 PHP",php)
	@$(call check_hello_world,"  👉 Python",python)
	@$(call check_hello_world,"  👉 Ruby",ruby)
	@$(call check_hello_world,"  👉 Rust",rust)
	@$(call check_hello_world,"  👉 Typescript\(Deno\)",ts_deno)
	@$(call check_hello_world,"  👉 Typescript\(Node.js\)",ts)
	@$(call check_hello_world,"  👉 V",v)
	@echo ""
	@$(MAKE) -s clean

define check_hello_world
	@ \
	 	COUNTER=$$(cat .count) \
	 	&& COUNTER=$$((COUNTER+1)) \
	 	&& (echo "$$COUNTER" > .count) \
	 	&& printf "\n" \
	 	&& DISPLAYCNT=$$(printf "%3s" "$$COUNTER") \
		&& printf "% -65s" "$$(printf $(_TITLE) "$$DISPLAYCNT $(1)")" \
		&& TMPFILE=".tmp$$RANDOM.output" \
		&& ( \
			($(MAKE) -s $(2) >$$TMPFILE) \
			&& (printf "Exit code: ✔") \
			|| (printf $(_ERROR) "Exit code: ❌") \
		) \
		&& FILECNT="Hello world!" \
		&& OUTPUT=$$(cat $$TMPFILE) \
		&& if [[ "$$FILECNT" == "$$(cat $$TMPFILE)" ]] ; then \
			printf "\tSTDOUT: ✔"; \
		else \
			printf "\t"$(_ERROR) "STDOUT: ❌. Expected \"$$FILECNT\", got this instead:    $$OUTPUT"; \
		fi;
endef

.PHONY: clean
clean:
	@printf $(_TITLE)"\n" "🧹 Cleaning output files"
	@rm -rf .count *.out *.jar *.class node_modules .tmp*.output main.hi main.o main.cmi main.cmo

.PHONY: c
c:
	@gcc main.c -o main.c.out
	@./main.c.out

.PHONY: cpp
cpp:
	@g++ main.cpp -o main.cpp.out
	@./main.cpp.out

.PHONY: go
go:
	@go build -o main.go.out main.go
	@./main.go.out

.PHONY: java
java:
	@javac main.java
	@jar -m main.java.manifest -c -f main.jar main.class
	@java -jar main.jar

.PHONY: php
php:
	@php main.php

.PHONY: python
python:
	@python main.py

.PHONY: ruby
ruby:
	@ruby main.rb

.PHONY: rust
rust:
	@rustc main.rs -o main.rs.out
	@./main.rs.out

.PHONY: ts_deno
ts_deno:
	@deno compile -q --unstable -o main.deno.out main.deno.ts
	@./main.deno.out

.PHONY: ts
ts:
	@npm i --save-dev @types/node > /dev/null 2>&1
	@tsc main.ts --outFile main.ts.out
	@node main.ts.out

.PHONY: js
js:
	@node main.js

.PHONY: v
v:
	@~/vlang/v main.v -o main.v.out
	@./main.v.out

.PHONY: cobol
cobol:
	@cobc -free -x -o main.cbl.out main.cbl
	@./main.cbl.out

.PHONY: haskell
haskell:
	@ghc -o main.hs.out main.hs >/dev/null 2>&1
	@./main.hs.out

.PHONY: fortran
fortran:
	@gfortran-9 -o main.f90.out main.f90
	@./main.f90.out

.PHONY: ocaml
ocaml:
	@ocamlc -o main.ml.out main.ml
	@./main.ml.out

.PHONY: julia
julia:
	@julia main.jl

.PHONY: perl
perl:
	@perl main.perl

.PHONY: lua
lua:
	@lua main.lua

.PHONY: lisp
lisp:
	@sbcl --script main.lisp
