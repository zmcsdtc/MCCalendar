//
//  MCCalendarCell.m
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import "MCCalendarCell.h"
#import "UIView+Extension.h"
@interface MCCalendarCell ()

@property (strong,nonatomic) MCCalerdarDateButton*bgButton;


@end

@implementation MCCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.bgButton = [MCCalerdarDateButton createMCCalerdarDateButtonFrame:self.contentView.bounds title:@"10" clickBlock:^(MCCalerdarDateButton * _Nonnull btn) {
        if (self.delegate) {
            [self.delegate didSelectMCCalendarCell:self];
        }
    }];
    [self.contentView addSubview:self.bgButton];
}


#pragma mark - setting

- (void)setModel:(MCCalendarDateModel *)model {
    _model = model;
    self.bgButton.selected = NO;
    
    if (!model.isCurrentMonth) {
        self.bgButton.enabled = NO;
    }
    else {
        self.bgButton.enabled = YES;
        
        if (model.isToday) {
            self.bgButton.titleColor = [UIColor redColor];
        }
        else {
            self.bgButton.titleColor = [UIColor blackColor];
        }
    }
    if (model.dateDay) {
        self.bgButton.title = [NSString stringWithFormat:@"%zd",model.dateDay];
    }
    else {
        self.bgButton.title =@"空";
    }
    if (model.isSelectDate) {
        self.bgButton.selected = YES;
    }
    else {
        self.bgButton.selected = NO;
    }
    
}

#pragma mark - lazy init


@end


@interface MCCalerdarDateButton ()

@property (strong, nonatomic) CALayer *selectLayer;



@end


@implementation MCCalerdarDateButton

+(instancetype)createMCCalerdarDateButtonFrame:(CGRect)frame title:(NSString*)title clickBlock:(MCCalerdarDateButtonBlock)block {
    return [[MCCalerdarDateButton alloc] initWithFrame:frame title:title clickBlock:block];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title clickBlock:(MCCalerdarDateButtonBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleColor = [UIColor blackColor];
        self.selected = NO;
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        self.block = block;
        self.selectBgColor = [UIColor orangeColor];
        self.title = title;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setTitleColor:(UIColor*)titleColor {
    [self setTitleColor:titleColor forState:0];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
//        self.backgroundColor = self.selectBgColor;
//        self.layer.cornerRadius = self.bounds.size.width/2.0;
        [self addLayerAnimaiton];
        
    }
    else {
//        self.backgroundColor = [UIColor whiteColor];
//        self.layer.cornerRadius = 0;
        [self removeLayerAnimation];
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (!enabled) {
        self.titleColor = [UIColor lightGrayColor];
    }
    else {
        self.titleColor = [UIColor blackColor];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:0];
}

- (void)clickButton:(MCCalerdarDateButton*)btn {
    if (self.selected) {
        self.selected = NO;
    }
    else {
        self.selected = YES;
    }
    if (self.block) {
        self.block(btn);
    }
}

#pragma mark - animation

- (void)addLayerAnimaiton {
//    self.shapeLayer.frame = self.bounds;
    CALayer*layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0.25*self.mc_width, 0.25*self.mc_width, 0.5*self.mc_width, 0.5*self.mc_width);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:layer];
    [self.layer insertSublayer:layer atIndex:0];
    layer.masksToBounds = YES;
    layer.cornerRadius = self.mc_width/4.0;
    self.selectLayer = layer;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 0.25f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.selectLayer addAnimation:scaleAnimation forKey:@"animation"];
    
}

- (void)removeLayerAnimation {
    [self.selectLayer removeAllAnimations];
    [self.selectLayer removeFromSuperlayer];
    self.selectLayer = nil;
}



#pragma mark - lazy init

@end
