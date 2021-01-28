//
//  ViewController.m
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import "ViewController.h"
#import "MCCalendarView.h"
#import "UIView+Extension.h"
@interface ViewController ()

@property (strong,nonatomic)MCCalendarView*mv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//    MCCalerdarDateButton*btn = [MCCalerdarDateButton createMCCalerdarDateButtonFrame:CGRectMake(100, 100, 100, 100) title:@"button" clickBlock:^(MCCalerdarDateButton * _Nonnull btn) {
//        NSLog(@"button = %@",btn);
//    }];
//    [self.view addSubview:btn];
    MCCalendarView*mv = [[MCCalendarView alloc] initWithFrame:CGRectMake(0, 100, kWindowWidth, kWindowHeigth)];
    [self.view addSubview:mv];
    self.mv = mv;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mv reloadDate];
}

@end
