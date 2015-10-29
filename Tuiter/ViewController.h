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

@property(nonatomic, weak) IBOutlet NSLayoutConstraint *twitterLogoTopConstraint;
@property(nonatomic, weak) IBOutlet NSLayoutConstraint *searchBarBottomConstraint;
@property(nonatomic, weak) IBOutlet NSLayoutConstraint *searchFieldWidthConstraint;


@property(nonatomic, weak) IBOutlet UIImageView *twitterIcon;

@property(nonatomic, weak) IBOutlet UIView *searchBar;
@property(nonatomic, weak) IBOutlet UIView *recentSearchesView;
@property(nonatomic, weak) IBOutlet UIView *trendingNowView;

@property(nonatomic, weak) IBOutlet UITableView *recentSearchesTableView;
@property(nonatomic, weak) IBOutlet UITableView *trendingNowTableView;

@property(nonatomic, retain) TwitterServices *twitterServices;

@property(nonatomic, retain) NSArray *lastSearchedTerms;
@property(nonatomic, retain) NSArray *lastRequestedTrending;

@end

