#import "UserService.h"

@interface UserService ()

@end

@implementation UserService

@synthesize userIdentity;
@synthesize userId;
@synthesize userCountry;


-(BOOL) checkUserLogin {
    if (userId != nil) {
        return YES;
    }
    return NO;
}

-(BOOL) checkUserIdentity {
    if (userIdentity != 0) {
        return YES;
    }
    return NO;
}

@end
