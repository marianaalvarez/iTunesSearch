//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTunesManager.h"

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property iTunesManager *itunes;
@property UITextField *texto;

@end

