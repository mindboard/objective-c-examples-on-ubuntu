gnustep_include:=`gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS`
objc_include:=/usr/lib/gcc/x86_64-linux-gnu/7/include
cairo_include:=/usr/include/cairo
atmarkstringoption:=-fconstant-string-class=NSConstantString
libraries:=-lgnustep-base -lobjc -lcairo


default : run

run : draw-triangles
	./$<

draw-triangles.o : draw-triangles.m
	clang -c $< -I$(cairo_include) -I$(gnustep_include) -I$(objc_include) $(atmarkstringoption)

draw-triangles : draw-triangles.o
	clang -o $@ $< $(libraries) 


clean :
	$(RM) draw-triangles
	$(RM) *.png
	$(RM) *.o
