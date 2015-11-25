gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
sqlite3_include:=/usr/include
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc `pkg-config sqlite3 --cflags --libs`


default : run

run : create-insert
	./$<

create-insert.o : create-insert.m
	@clang -c $< -I$(gnustep_include) -I$(sqlite3_include) $(atmarkstringoption)

create-insert : create-insert.o
	@clang -o $@ $< $(libraries)

clean : 
	$(RM) ./create-insert
	$(RM) *.o
	$(RM) *.db
