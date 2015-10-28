//
//  TwitterTrend.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "TwitterTrend.h"

@implementation TwitterTrend

+(TwitterTrend *) fromDictionary:(id) dictionary {
    TwitterTrend *trend = [[TwitterTrend alloc] init];
    trend.name = [dictionary objectForKey:@"name"];
    return trend;
}

@end
