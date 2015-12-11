
#include <Foundation/Foundation.h>
#import "NSData+Base64.h"

@interface PngToBase64 : NSObject {
}
- (void) proc1;
- (void) proc2;
@end

@implementation PngToBase64

// ローカルにあるPNG画像を base64文字列に変換
- (void) proc1
{
	NSFileManager *manager = [NSFileManager defaultManager];

	NSString *path = @"input.png";
	BOOL r = [manager fileExistsAtPath:path];
	if( r ){
		// TODO
		NSData *pngData = [[[NSData alloc] initWithContentsOfFile:path] autorelease];
		NSString *base64String = [pngData base64EncodedString];
		NSLog(@"pngData %@", base64String);
	}
	else {
		NSLog(@"%@ file not found.", path);
	}
}

// ネット上にあるPNG画像を base64文字列に変換
- (void) proc2
{
	NSString *path = @"http://www.mindboardapps.com/blog/imgs/fractal-ginkgo-leaf.png";
	NSURL *url = [NSURL URLWithString:path];
	NSData *pngData = [NSData dataWithContentsOfURL:url];
	NSString *base64String = [pngData base64EncodedString];
	NSLog(@"pngData %@", base64String);
}
@end


int main(int argc, const char * argv[]){
    @autoreleasepool {
		PngToBase64 *pngToBase64 = [[[PngToBase64 alloc] init] autorelease];
		[pngToBase64 proc1];
		[pngToBase64 proc2];
	}
   	return (0);
}
