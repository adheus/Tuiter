//
//  TwitterUser.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterUser : NSObject

@property(nonatomic) NSString *profileImageURL;
@property(nonatomic) NSString *name;

+(TwitterUser *) fromDictionary:(id) dictionary;

@end
