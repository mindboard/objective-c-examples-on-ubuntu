gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
objc_include:=/usr/lib/gcc/x86_64-linux-gnu/7/include
cairo_include:=/usr/include/cairo
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc -lcairo


default : run

run : draw-triangle
	./$<

draw-triangle.o : draw-triangle.m
	clang -c $< -I$(cairo_include) -I$(gnustep_include) -I$(objc_include) $(atmarkstringoption)

draw-triangle : draw-triangle.o
	clang -o $@ $< $(libraries) 


clean :
	$(RM) draw-triangle
	$(RM) *.png
	$(RM) *.o
