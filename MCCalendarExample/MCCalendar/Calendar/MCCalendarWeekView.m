//
//  MCCalendarWeekView.m
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import "MCCalendarWeekView.h"
#import "UIView+Extension.h"
@implementation MCCalendarWeekView

+(instancetype)createWeekView {
    MCCalendarWeekView*wv = [[MCCalendarWeekView alloc] init];
    wv.frame = CGRectMake(0, 0, kWindowWidth, 44);
    NSArray*array = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    CGFloat width = kWindowWidth/array.count;
    
    
    for (NSString*title in array) {
        NSInteger index = [array indexOfObject:title];
        UILabel*label = [[UILabel alloc] init];
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        [wv addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(index*width, 0, width, 44);
    }
    
    return wv;
}

@end
