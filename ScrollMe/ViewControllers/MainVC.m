//
//  MainVC.m
//  ScrollMe
//
//  Created by Nicolas on 05/12/2013.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@property (nonatomic) int score;
@property (nonatomic) int highScore;
@property (nonatomic) int lives;
@property (nonatomic) int step;

@property (nonatomic, strong) UILabel *highScoreLabel;
@property (nonatomic, strong) UILabel *stepLabel;

@end

@implementation MainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:24],
                                                           }];
    
    [self.navigationController.navigationBar addSubview:self.highScoreLabel];
    [self.navigationController.navigationBar addSubview:self.stepLabel];
    

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.highScore = [prefs integerForKey:@"highScore"];

    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    mainTableView.transform = CGAffineTransformMakeRotation(-M_PI);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [mainTableView setContentOffset:CGPointZero animated:YES];
}

- (UILabel *)highScoreLabel
{
    if (!_highScoreLabel) {
        _highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 45)];
        _highScoreLabel.textAlignment = NSTextAlignmentRight;
        _highScoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    }
    
    return _highScoreLabel;
}

- (UILabel *)stepLabel
{
    if (!_stepLabel) {
        _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 45)];
        _stepLabel.textAlignment = NSTextAlignmentLeft;
        _stepLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    }
    
    return _stepLabel;
}

- (void)setScore:(int)score
{
    _score = score;
    
   [self setTitle:[@(score) stringValue]];

}

- (void)setHighScore:(int)highScore
{
    _highScore = highScore;
    
    self.highScoreLabel.text = [@(highScore) stringValue];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:highScore forKey:@"highScore"];
    
}

- (void)setStep:(int)step
{
    _step = step;
    
    self.stepLabel.text = [@(step) stringValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return mainTableView.frame.size.height - self.navigationController.navigationBar.frame.size.height -20.f;
    } else {
        return 70;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:24];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"ScrollMe"];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:48];
        
    } else if (indexPath.row == 100) {
        cell.textLabel.text = @"Beau début";
        cell.backgroundColor = COLOR_GREEN;

    } else if (indexPath.row == 200) {
        cell.textLabel.text = @"Pas mal...";
        cell.backgroundColor = COLOR_GREEN;

    } else if (indexPath.row == 300) {
        cell.textLabel.text = @"PALIER - 300";
        cell.backgroundColor = COLOR_ORANGE;
        
        self.step = 300;
        
    } else if (indexPath.row == 500) {
        cell.textLabel.text = @"Continue !";
        cell.backgroundColor = COLOR_GREEN;
        
    } else if (indexPath.row == 750) {
        cell.textLabel.text = @"PALIER - 750";
        cell.backgroundColor = COLOR_ORANGE;
        
        self.step = 750;


    } else if (indexPath.row == 1000) {
        cell.textLabel.text = @"PALIER - 1000";
        cell.backgroundColor = COLOR_ORANGE;
        
        self.step = 1000;

    } else {
        cell.textLabel.text = [@(indexPath.row) stringValue];
        // cell.backgroundColor = [self colorForIndex:indexPath.row];
        cell.backgroundColor = [UIColor clearColor];

    }
    
    // score
    if (indexPath.row > self.score) {
        self.score = indexPath.row;
    }
    
    cell.transform = CGAffineTransformMakeRotation(M_PI);

    return cell;
    
}

/*
- (UIColor*)colorForIndex:(int)index
{
    int center = 4;
    int width = 230;
  //  int len = 25;
    int frequency = 0.3;
    
            int red = sin(frequency*index + 0) * width + center;
            int grn = sin(frequency*index + 2) * width + center;
            int blu = sin(frequency*index + 4) * width + center;

    NSString *colorString = [NSString stringWithFormat:@"0x%02x%02x%02x", (unsigned int) red, (unsigned int) grn, (unsigned int) blu];

    NSLog(@"%d  %d : %02x  //  %d : %02x  //  %d : %02x", index, red, (unsigned int) red, grn, (unsigned int) grn, blu, (unsigned int) blu);
    
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    unsigned int colorInt;
    [scanner scanHexInt:&colorInt];
    
    
    return UIColorFromRGB(colorInt);
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    mainTableView.backgroundColor = [UIColor clearColor];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
     scrollView.userInteractionEnabled = NO;
    // [scrollView setContentOffset:CGPointZero animated:YES];
    
    [mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.step inSection:0]
                         atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    if (self.score > self.highScore) {
        self.highScore = self.score;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = NO;
    // [scrollView setContentOffset:CGPointZero animated:YES];
    
    [mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.step inSection:0]
                         atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
   
    mainTableView.backgroundColor = COLOR_ORANGE;
    
    self.score = self.step;

    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(clearBackground)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)clearBackground
{
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.userInteractionEnabled = YES;

}

@end
