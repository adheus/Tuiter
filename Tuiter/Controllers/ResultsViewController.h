//
//  ResultsViewController.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property (nonatomic, weak) UITableView *resultsTableView;
@property (nonatomic, retain) NSArray *results;
@end
