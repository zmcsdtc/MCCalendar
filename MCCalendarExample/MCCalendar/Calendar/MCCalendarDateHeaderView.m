//
//  MCCalendarDateHeaderView.m
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import "MCCalendarDateHeaderView.h"
#import "UIView+Extension.h"
@interface MCCalendarDateHeaderView ()

@property (strong,nonatomic) UILabel*titleLabel;
@property (strong,nonatomic) UIButton*leftButton;
@property (strong,nonatomic) UIButton*rightButton;
@property (copy,  nonatomic) ChangeMonthBlock block;


@end

@implementation MCCalendarDateHeaderView

+(instancetype)createMCCalendarDateHeaderViewChangeMonthBlock:(ChangeMonthBlock)block {
    MCCalendarDateHeaderView*hmv =  [[MCCalendarDateHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 40) changeMonthBlock:block];
    
    return hmv;
}

- (instancetype)initWithFrame:(CGRect)frame changeMonthBlock:(ChangeMonthBlock)block{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        self.block = block;
    }
    return self;
}

- (void)setupSubviews {
    self.titleLabel.frame = CGRectMake(0, 0, kWindowWidth/3.0, 40);
    self.titleLabel.text = [NSDate getCurrentTimeWwithdateformatter:@"yyyy年MM月"];
    self.titleLabel.mc_centerX = self.mc_width/2.0;
    
    self.leftButton.frame = CGRectMake(15, 0, 100, 40);
    self.rightButton.frame = CGRectMake(self.mc_width - 15 - 100, 0, 100, 40);
}

- (void)clickButton:(UIButton*)btn {
    if (btn.tag == 888) {
        self.block(ChangeMonthLast);
    }
    else {
        self.block(ChangeMonthNext);
    }
}

#pragma mark - setter

- (void)setDate:(NSDate *)date {
    _date = date;
    self.titleLabel.text = [NSDate datestrFromDate:date withDateFormat:@"yyyy年MM月"];
}


#pragma mark - Lazy init

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitle:@"上个月" forState:0];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftButton.tag = 888;
        [_leftButton setTitleColor:[UIColor blueColor] forState:0];
        [self addSubview:_leftButton];
        [_leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitle:@"下个月" forState:0];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightButton.tag = 999;
        [_rightButton setTitleColor:[UIColor blueColor] forState:0];
        [self addSubview:_rightButton];
        [_rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
