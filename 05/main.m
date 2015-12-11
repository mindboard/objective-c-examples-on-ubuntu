#include <Foundation/Foundation.h>

int main(int argc, const char * argv[]){
    @autoreleasepool {
		NSString *jsonString = @"{\"apple\":\"200\",\"orange\":\"150\"}";
		NSLog(@"json %@",jsonString);

		NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

		NSError *error = nil;
		id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

		if( error ){
			NSLog(@"obj %@",error);
		}
		else {
			if([object isKindOfClass:[NSDictionary class]]){
				NSDictionary *map = object;
				NSArray *array = [map allKeys];
				for( NSString *key in array ){
					id value = [map valueForKey:key];
					NSLog(@"(k,v) = (%@,%@)",key,value);
				}
			}
		}
	}
   	return (0);
}
