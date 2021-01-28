//
//  MCCalendarDateModel.h
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCCalendarDateModel : NSObject


@property (assign,nonatomic) NSInteger dateDay;
@property (assign,nonatomic) BOOL isCurrentMonth;
@property (assign,nonatomic) BOOL isToday;
@property (assign,nonatomic) BOOL isSelectDate;
@property (strong,nonatomic) NSDate*date;

@end

NS_ASSUME_NONNULL_END
