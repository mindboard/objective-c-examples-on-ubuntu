gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
cairo_include:=/usr/include/cairo
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc -lcairo


default : run

run : draw-triangle
	./$<

draw-triangle.o : draw-triangle.m
	clang -c $< -I$(cairo_include) -I$(gnustep_include) $(atmarkstringoption)

draw-triangle : draw-triangle.o
	clang -o $@ $< $(libraries) 


clean :
	$(RM) draw-triangle
	$(RM) *.png
	$(RM) *.o
