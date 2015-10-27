//
//  Tweet.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterUser.h"

@interface TwitterStatus : NSObject

@property(nonatomic) NSString *id;
@property(nonatomic) NSString *text;
@property(nonatomic) TwitterUser *user;


+(TwitterStatus *) fromDictionary:(id) dictionary;

@end
