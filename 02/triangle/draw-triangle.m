#include <Foundation/Foundation.h>
#include <cairo.h>

typedef struct {
    float x;
    float y;
} point_t;

int main(int argc, const char * argv[]){
    // 0)
    float width  = 150;
    float height = 150;

    // 1) create cairo
    cairo_surface_t *surface = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, width, height);
    cairo_t *cairo           = cairo_create (surface);

    // 2) draw a triangle
    point_t topPoint         = {width/2, 0};
    point_t leftBottomPoint  = {0,       height};
    point_t rightBottomPoint = {width,   height};

    cairo_move_to( cairo, topPoint.x,         topPoint.y);
    cairo_line_to( cairo, leftBottomPoint.x,  leftBottomPoint.y);
    cairo_line_to( cairo, rightBottomPoint.x, rightBottomPoint.y);
    cairo_close_path ( cairo );

    cairo_set_source_rgb (cairo, 0, 0, 0);
    cairo_set_line_width (cairo, 1.0);
    cairo_stroke ( cairo );

    cairo_destroy (cairo);

    // 3) save 
    cairo_surface_write_to_png (surface, "result.png");

    // 4)
    cairo_surface_destroy (surface);

    return (0);
}