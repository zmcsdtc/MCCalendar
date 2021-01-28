//
//  MCCalendarDateHeaderView.h
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import <UIKit/UIKit.h>
#import "NSDate+Mcdate.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ChangeMonth) {
    ChangeMonthLast,
    ChangeMonthNext
};

typedef void(^ChangeMonthBlock)(ChangeMonth changeMonth);

@interface MCCalendarDateHeaderView : UIView

+(instancetype)createMCCalendarDateHeaderViewChangeMonthBlock:(ChangeMonthBlock)block;

@property (strong,nonatomic) NSDate*date;



@end

NS_ASSUME_NONNULL_END
