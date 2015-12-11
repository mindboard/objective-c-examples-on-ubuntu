gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc

default : run

run : main
	./$<

main.o : main.m
	clang -c $< -I$(gnustep_include) $(atmarkstringoption)

main : main.o
	#clang -o $@ $< NSData+Base64.o $(libraries)
	clang -o $@ $^ $(libraries)

clean : 
	$(RM) ./main
	$(RM) *.o
