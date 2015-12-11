#include <Foundation/Foundation.h>
#include <sqlite3.h>


@interface MyDatabase : NSObject {
    BOOL dbExists;
    NSString *mFileName;
    NSString *mTableName;
}
- (id) initWithFileName:(NSString *)fileName andTableName:(NSString *)tableName;
- (void) createTable;
- (void) insertKey:(NSString *)key andValue:(NSString *)value;
@end

@implementation MyDatabase

- (id) initWithFileName:(NSString *)fileName andTableName:(NSString *)tableName {
    self = [super init];
    if( self ){
        mFileName = fileName;
        mTableName = tableName;

        NSFileManager *manager = [NSFileManager defaultManager];
        dbExists= [manager fileExistsAtPath:mFileName];
    } 
    return self;
}

- (int) open:(sqlite3 **) db mode:(int) flags {
    return sqlite3_open_v2([mFileName UTF8String], db, flags, NULL);
}

- (void) close:(sqlite3 *) db {
    sqlite3_close(db);
}

- (void) createTable {
    if( dbExists==YES ){
        return ;
    }

    sqlite3 *db = NULL;
    int result = [self open:&db mode:(SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE)];
    if( result==SQLITE_OK ){
        char *errMessage = NULL;
        NSString *cmd = @"create table if not exists %@ (key text, value text);";
        NSString *sql = [NSString stringWithFormat:cmd, mTableName];
        sqlite3_exec(db,[sql UTF8String], NULL, NULL, &errMessage);
        dbExists = YES;
    }

    [self close:db];
}

- (void) insertKey:(NSString *)key andValue:(NSString *)value {
    if( dbExists==NO ){
        return ;
    }
    
    int result = 0;

    sqlite3 *db = NULL;
    result = [self open:&db mode:(SQLITE_OPEN_READWRITE)];
    if( result==SQLITE_OK ){
        sqlite3_stmt *stmt = NULL;
    
        NSString *cmd = @"insert into %@ (key,value) values (?,?)";
        NSString *sql = [NSString stringWithFormat:cmd, mTableName];
        result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
        if( result==SQLITE_OK ){
            sqlite3_bind_text(stmt, 1, [key UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(stmt, 2, [value UTF8String], -1, SQLITE_STATIC);
            sqlite3_step(stmt);
        }
    
        sqlite3_finalize(stmt);
    }
    [self close:db];
}

@end


int main(int argc, const char * argv[]){
    @autoreleasepool {
        MyDatabase *myDb = [[[MyDatabase alloc] initWithFileName:@"hello.db" andTableName:@"hello_tbl"] autorelease];
        [myDb createTable];
        [myDb insertKey:@"hello" andValue:@"world"];
        //[myDb release];
    }
    return (0);
}
