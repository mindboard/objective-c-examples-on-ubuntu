gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
objc_include:=/usr/lib/gcc/x86_64-linux-gnu/7/include
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc

default : run

run : main
	./$<

main.o : main.m
	clang -c $< -I$(gnustep_include) -I$(objc_include) $(atmarkstringoption)

main : main.o
	clang -o $@ $< $(libraries)

clean : 
	$(RM) ./main
	$(RM) *.o
