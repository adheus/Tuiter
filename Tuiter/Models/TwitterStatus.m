//
//  Tweet.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "TwitterStatus.h"

@implementation TwitterStatus

+(TwitterStatus *)fromDictionary:(id)dictionary {
    TwitterStatus *status = [[TwitterStatus alloc] init];
    status.id = [dictionary objectForKey:@"id"];
    status.text = [dictionary objectForKey:@"text"];
    status.user = [TwitterUser fromDictionary:[dictionary objectForKey:@"user"]];
    return status;
}

@end
