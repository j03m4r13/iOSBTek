
#import "SensorSchedule.h"

@implementation SensorSchedule

-(id)initWithStartTime:(long)theStartTime withEndTime:(long)theEndTime withMeasFreq:(long)theMeasFreq withDays:(NSString *)theDays{
    if(self = [super init]){
        startTime = theStartTime;
        endTime = theEndTime;
        measuremeantFrequency = theMeasFreq;
        days = theDays;
    }
    return self;

}


-(long)getStartTime{
    return startTime;
}


-(void)setStartTime:(long)theStartTime{
    if(theStartTime >= 0 && theStartTime <= 86400000){
        startTime = theStartTime;
    }else{
        startTime = 0;
    }
}


-(long)getEndTime{
    return endTime;
}


-(void)setEndTime:(long)theEndTime{
    if(theEndTime >= 0 && theEndTime <= 86400000){
        endTime = theEndTime;
    }
}


-(long)getMeasurementFrequency{
    return measuremeantFrequency;
}


-(void)setMeasurementFrequency:(long)theMeasurementFrequency{
    measuremeantFrequency = theMeasurementFrequency;
}


-(NSString*)getDays{
    return days;
}


-(void)setDays:(NSString*)theDays{
    days = [theDays lowercaseString];
}


@end
