
#include <Foundation/Foundation.h>
#import "NSData+Base64.h"

@interface PngToBase64 : NSObject {
}
- (void) proc;
@end

@implementation PngToBase64
- (void) proc
{
	//NSLog(@"hello World!");
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

	//NSLog(@"hello World! %@", manager);
}
@end


int main(int argc, const char * argv[]){
    @autoreleasepool {
		PngToBase64 *pngToBase64 = [[[PngToBase64 alloc] init] autorelease];
		[pngToBase64 proc];
		NSLog(@"hello World! %@", pngToBase64);
	}
   	return (0);

   	//return (0);
}
