//
//  MainVC.h
//  ScrollMe
//
//  Created by Nicolas on 05/12/2013.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *mainTableView;
}
@end
