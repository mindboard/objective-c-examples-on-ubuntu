gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
sqlite3_include:=/usr/include
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc `pkg-config sqlite3 --cflags --libs`


default : run

run : create-insert-select
	./$<

create-insert-select.o : create-insert-select.m
	@clang -c $< -I$(gnustep_include) -I$(sqlite3_include) $(atmarkstringoption)

create-insert-select : create-insert-select.o
	@clang -o $@ $< $(libraries)

clean : 
	$(RM) ./create-insert-select
	$(RM) *.o
	$(RM) *.db
