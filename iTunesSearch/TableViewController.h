//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTunesManager.h"
#import "DetailViewController.h"

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) DetailViewController *detailVC;
@property (nonatomic, strong) TableViewController *tableVC;
@property UITextField *texto;
@property NSMutableArray *array;
@property iTunesManager *itunes;

@end

