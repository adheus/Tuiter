//
//  ViewController.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterServices.h"
@interface ViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UITextField *searchField;
@property(nonatomic, retain) TwitterServices *twitterServices;

@end

