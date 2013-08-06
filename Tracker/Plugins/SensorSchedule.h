

#import <Foundation/Foundation.h>



@interface SensorSchedule : NSObject{
    long startTime;
    long endTime;
    long measuremeantFrequency;
    NSString *days;
    
    
}

-(id)initWithStartTime:(long)theStartTime withEndTime:(long)theEndTime withMeasFreq:(long)theMeasFreq withDays:(NSString*)theDays;
-(long)getStartTime;
-(void)setStartTime:(long)theStartTime;
-(long)getEndTime;
-(void)setEndTime:(long)theEndTime;
-(long)getMeasurementFrequency;
-(void)setMeasurementFrequency:(long)theMeasurementFrequency;
-(NSString*)getDays;
-(void)setDays:(NSString*)theDays;
@end