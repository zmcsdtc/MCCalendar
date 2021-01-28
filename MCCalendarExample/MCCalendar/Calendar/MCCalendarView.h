//
//  MCCalendarView.h
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import <UIKit/UIKit.h>
#import "MCCalendarCell.h"
#import "MCCalendarDateModel.h"
#import "MCCalendarWeekView.h"
#import "MCCalendarDateHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MCCalendarView : UIView

//default is NO
@property (assign,nonatomic) BOOL canMulSelect;

- (void)reloadDate;

@end

NS_ASSUME_NONNULL_END
