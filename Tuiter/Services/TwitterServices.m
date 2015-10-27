//
//  TwitterServices.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "TwitterServices.h"
#import "TwitterStatus.h"

@implementation TwitterServices

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFTwitterSessionManager alloc] init];
    }
    return self;
}


- (void)searchTweets:(NSString *) search callback:(void (^)(BOOL success, NSArray *twitterStatuses))callback {
    
    [self.manager GET:[NSString stringWithFormat:@"/1.1/search/tweets.json?q=%@", search] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         // Success
         NSLog(@"Success: %@", responseObject);
         
         id statuses = [responseObject objectForKey:@"statuses"];
         if (statuses != nil) {
             NSMutableArray *twitterStatuses = [NSMutableArray array];
             for (id status in statuses) {
                 [twitterStatuses addObject:[TwitterStatus fromDictionary:status]];
             }
             callback(YES, twitterStatuses);
             return;
         }
         
         callback(NO, nil);
     }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         // Failure
         NSLog(@"Failure: %@", error);
         callback(NO, nil);
     }];
}



@end
