//
//  TwitterTrend.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterTrend : NSObject

@property(nonatomic, retain) NSString *name;

+(TwitterTrend *) fromDictionary:(id) dictionary;

@end
