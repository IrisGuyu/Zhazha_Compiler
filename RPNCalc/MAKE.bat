@echo off
del a.exe
del I.exe
del lex.yy.cc
del rpncalc.tab.c
del rpncalc.tab.h
bison -d rpncalc.y
flex rpncalc.l
g++ -o I.exe lex.yy.cc rpncalc.tab.c
pause