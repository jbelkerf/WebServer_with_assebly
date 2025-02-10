#!/bin/bash
as -o server.o $1
ld -o server server.o
rm server.o
strace ./server