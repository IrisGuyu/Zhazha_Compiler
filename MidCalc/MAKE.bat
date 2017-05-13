@echo off
del a.exe
del I.exe
del lex.yy.cc
del MidCalc.tab.c
del MidCalc.tab.h
bison -d MidCalc.y
flex MidCalc.l
g++ -o I.exe lex.yy.cc MidCalc.tab.c
pause