//
//  ViewController.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/26/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterServices.h"
@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) IBOutlet UITextField *searchField;


@property(nonatomic, weak) IBOutlet UITableView *recentSearchesTableView;
@property(nonatomic, weak) IBOutlet UITableView *trendingNowTableView;

@property(nonatomic, retain) TwitterServices *twitterServices;

@property(nonatomic, retain) NSArray *lastSearchedTerms;
@property(nonatomic, retain) NSArray *lastRequestedTrending;

@end

