//
//  AFTwitterSessionManager.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface AFTwitterSessionManager : AFHTTPSessionManager

@property(nonatomic) NSString *bearerToken;
@end
