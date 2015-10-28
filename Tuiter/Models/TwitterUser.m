//
//  TwitterUser.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "TwitterUser.h"

@implementation TwitterUser

+(TwitterUser *) fromDictionary:(id) dictionary {
    TwitterUser *user = [[TwitterUser alloc] init];
    user.name = [dictionary objectForKey:@"name"];
    user.profileImageURL = [dictionary objectForKey:@"profile_image_url"];
    
    return user;
}

@end
