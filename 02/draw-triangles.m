#include <Foundation/Foundation.h>
#include <cairo.h>

typedef struct {
    float x;
    float y;
} point_t;



@interface Triangle : NSObject {
    cairo_t *mCairo;
}
- (id) 
    initWithContext: (cairo_t *) cairo;
- (void)
    drawWithTop    : (point_t) topPoint 
    andLeftBottom  : (point_t) leftBottomPoint 
    andRightBottom : (point_t) rightBottomPoint; 
@end

@implementation Triangle

- (id)
    initWithContext: (cairo_t *) cairo {

    self = [super init];
    if( self ){
           mCairo = cairo;
    }
    return (self);
} 

- (void)
    drawWithTop    : (point_t) topPoint 
    andLeftBottom  : (point_t) leftBottomPoint 
    andRightBottom : (point_t) rightBottomPoint {

    cairo_set_source_rgb (mCairo, 0, 0, 0);

    cairo_move_to( mCairo, topPoint.x,         topPoint.y);
    cairo_line_to( mCairo, leftBottomPoint.x,  leftBottomPoint.y);
    cairo_line_to( mCairo, rightBottomPoint.x, rightBottomPoint.y);
    cairo_close_path ( mCairo );

    cairo_set_line_width (mCairo, 1.0);
    cairo_stroke ( mCairo );
}

@end


@interface ManyTriangleMaker : NSObject {
    cairo_t *mCairo;
}
- (id)
    initWithContext: (cairo_t *) cairo;
- (void) 
    drawWithWidth     : (float) width
    andHeight         : (float) height
    andRecursionCount : (int) count ;
@end

@implementation ManyTriangleMaker

+ (void)
    drawTriangle    : (Triangle *) triangle
    andCounter      : (int) counter
    andStartPoint   : (point_t) startPoint
    andLengthOfSide : (int) lengthOfSide {

    // 1) check counter
    if( counter<0 ){
        return ;
    }

    // 2) draw triangle
    point_t bottomLeftPoint  = { startPoint.x - lengthOfSide/2, startPoint.y + lengthOfSide }; 
    point_t bottomRightPoint = { startPoint.x + lengthOfSide/2, startPoint.y + lengthOfSide }; 

    [triangle
        drawWithTop:startPoint
        andLeftBottom:bottomLeftPoint
        andRightBottom:bottomRightPoint];

    // 3) recursion
    [ManyTriangleMaker
        drawTriangle   : triangle
        andCounter     : counter-1
        andStartPoint  : startPoint
        andLengthOfSide: lengthOfSide/2 ];
    [ManyTriangleMaker
        drawTriangle   : triangle
        andCounter     : counter-1
        andStartPoint  : bottomLeftPoint
        andLengthOfSide: lengthOfSide/2 ];
    [ManyTriangleMaker
        drawTriangle   : triangle
        andCounter     : counter-1
        andStartPoint  : bottomRightPoint
        andLengthOfSide: lengthOfSide/2 ];
}

- (id)
    initWithContext: (cairo_t *) cairo {

    self = [super init];
    if( self ){
        mCairo = cairo;
    }
    return (self);
} 

- (void) 
    drawWithWidth     : (float) width
    andHeight         : (float) height
    andRecursionCount : (int) count {

    Triangle *triangle = [[Triangle alloc] initWithContext:mCairo];
    point_t startPt = {width/2, 0};
    [ManyTriangleMaker
        drawTriangle    : triangle
        andCounter      : count
        andStartPoint   : startPt
        andLengthOfSide : width/2];
}

@end



int main(int argc, const char * argv[]){

    // 0)
    float width  = 420;
    float height = 420;

    // 1) create cairo
    cairo_surface_t *surface = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, width, height);
    cairo_t *cairo           = cairo_create (surface);

    // 2) draw triangles
    ManyTriangleMaker *manyTriangleMaker = [[ManyTriangleMaker alloc] initWithContext:cairo];
    [manyTriangleMaker drawWithWidth:width andHeight:height andRecursionCount:8];
    [manyTriangleMaker release];

    cairo_destroy (cairo);

    // 3) save cairo
    NSString *outputPngPath = @"result.png";
    cairo_surface_write_to_png (surface, [outputPngPath UTF8String]);

    // 4)
    cairo_surface_destroy (surface);

    return (0);
}
