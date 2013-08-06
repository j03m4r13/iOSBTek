
#import "SensorProfileBase.h"
#import "SensorSchedule.h"
@implementation SensorProfileBase
-(id)initWithSensorType:(NSString*)theSensorType withSensorEnable:(bool)theSensorEnabled{
    sensorType = theSensorType;
    sensorEnabled = theSensorEnabled;
}
-(NSString*)getSensorType{
    return sensorType;
}
-(void)setSensorType:(NSString*)theSensorType{
    sensorType = [theSensorType lowercaseString];
}
-(bool)isSensorEnabled{
    return sensorEnabled;
}
-(void)setSensorEnabled:(bool)enabled{
    sensorEnabled = enabled;
}
-(bool)processSettingsConfig:(NSString*)settingsStr{
    NSLog(@"ProcessSettingsCOnfig...");
    return true;
}
-(bool)processSchedulesConfig:(NSString*)schedulesStr{
    @try{
        NSError *error;
        NSData *nData = [schedulesStr dataUsingEncoding:NSUTF8StringEncoding];
                         
        NSDictionary *schedulesArr = [NSJSONSerialization JSONObjectWithData:nData options:kNilOptions error: &error];
         
        NSEnumerator *keyEnum = [schedulesArr keyEnumerator];
        id key;
        while ((key = [keyEnum nextObject]))
        {
            id value = [schedulesArr objectForKey:key];
            SensorSchedule *sched = [[SensorSchedule alloc] init];
            [sched setStartTime: [[value objectForKey:@"startTimeMS"] longValue]];
            [sched setEndTime: [[value objectForKey:@"endTimeMS"] longValue]];
            [sched setStartTime: [[value objectForKey:@"startTimeMS"] longValue]];
            [schedules addObject: sched];
                    
            
        
            /*
            if (DEBUG) {
                long startOfDay = ProfileMgr.GetTimeAtStartOfDay();
                Log.d(TAG, "Shedule info:");
                Log.d(TAG, "Start of day: " + ProfileMgr.GetTimeStr(startOfDay));
                Log.d(TAG, "Start of schedule: " + ProfileMgr.GetTimeStr(startOfDay + sched.getStartTime()));
                Log.d(TAG, "End of schedule: " + ProfileMgr.GetTimeStr(startOfDay + sched.getEndTime()));
                Log.d(TAG, "Days: " + sched.getDays());
                Log.d(TAG, "Frequency: " + sched.getMeasurementFrequency());
            }
            */
            //schedules.add(sched);
        
        }
    }
    @catch (NSException *exp) {
        NSLog(@"processSchedulesConfig exception");
        
    }
}
-(bool)processHandlersConfig:(NSString*)handlersStr{
    return true;
}
-(bool)isScheduledToday{
    if(![self isSensorEnabled]){
        return false;
    }
    
    //Check each schedule, first one to match today wins
   // long timeNowMS = ProfileMgr.GetTimeNow();
   // SimpleDateFormat sdf = new SimpleDateFormat("EEE", Locale.getDefault());
   // String today = sdf.format(timeNowMS).toLowerCase();
    
    for (int scheduleIdx = 0; scheduleIdx < [schedules count]; scheduleIdx++) {
        //if (schedules.get(scheduleIdx).getDays().contains(today) == true) {
        //    return true;
       // }
    }
    
    return false;
}
-(bool)isScheduledNow{
    //Check to see if scheduled today & enabled
    if (![self isScheduledToday]) {
        return false;
    }
    
    //Now check to see if scheduled now
    
    //long timeNow = ProfileMgr.GetTimeNow();
    //long timeAtStartOfDay = ProfileMgr.GetTimeAtStartOfDay();
    long timeAtStartOfSchedule = 0L;
    long timeAtEndOfSchedule = 0L;
    
    for (int scheduleIdx = 0; scheduleIdx < [schedules count]; scheduleIdx++) {
        
        SensorSchedule *sched = [schedules objectAtIndex: scheduleIdx];
        //timeAtStartOfSchedule = timeAtStartOfDay + [sched getStartTime];
        //timeAtEndOfSchedule = timeAtStartOfDay + [sched getEndTime];
        
        //if (timeAtStartOfSchedule <= timeNow && timeNow <= timeAtEndOfSchedule) {
        //    return true;
        //}
    }
    
    return false;
}
-(long)getMinSensorFrequency:(NSString*)sensorType{
    long minSensorFreq = 0L;
    
    if ([sensorType isEqualToString: [self getSensorType]]) {
		
        for (int scheduleIdx = 0; scheduleIdx < [schedules count]; scheduleIdx++) {
            long sensorFreq = [[schedules objectAtIndex:scheduleIdx] getMeasurementFrequency];
            if (sensorFreq > 0L) {
                if (minSensorFreq == 0) {
                    minSensorFreq = sensorFreq;
                } else {
                    if (sensorFreq < minSensorFreq) {
                        minSensorFreq = sensorFreq;
                    }
                }
            }
        }
    }
    
    return minSensorFreq;
}
-(long)getMinLiveSensorFrequency:(NSString*)sensorType{
    long minSensorFreq = 0L;
    
    if ([sensorType isEqualToString: [self getSensorType]] && [self isScheduledNow]) {
		
        for (int scheduleIdx = 0; scheduleIdx < [schedules count]; scheduleIdx++) {
            long sensorFreq = [[schedules objectAtIndex:scheduleIdx] getMeasurementFrequency];
            if (sensorFreq > 0L) {
                if (minSensorFreq == 0) {
                    minSensorFreq = sensorFreq;
                } else {
                    if (sensorFreq < minSensorFreq) {
                        minSensorFreq = sensorFreq;
                    }
                }
            }
        }
    }
    return minSensorFreq;
    
}
-(long)getTimeToNextMeasurement:(NSString*)sensorType{
    /*
    long minTimeToNextMeasurement = ProfileMgr.MS_OFF;
    
    if (sensorType.equalsIgnoreCase(this.sensorType) && IsScheduledToday()) {
        
        SensorSchedule sched = null;
        long timeNow = ProfileMgr.GetTimeNow();
        long timeStartOfDay = ProfileMgr.GetTimeAtStartOfDay();
        
        for (int scheduleIdx = 0; scheduleIdx < schedules.size(); scheduleIdx++) {
            
            sched = schedules.get(scheduleIdx);
            long timeAtStartOfSchedule = timeStartOfDay + sched.getStartTime();
            long timeAtEndOfSchedule = timeStartOfDay + sched.getEndTime();
            
            //Handle scenario where we are before the start time
            if (timeAtStartOfSchedule > timeNow) {
                return timeAtStartOfSchedule - timeNow;
            }
            
            //Now get the amount of time in MS to the next scheduled measurement from now
            long timeLeftMS = timeAtStartOfSchedule % sched.getMeasurementFrequency();
            if (timeLeftMS == 0 ) {
                timeLeftMS = sched.getMeasurementFrequency();
            }
            
            //Now only consider it of it does not exceed the end of the schedule
            if ((timeNow + timeLeftMS) < timeAtEndOfSchedule ) {
                if (timeLeftMS > 0L) {
                    if (minTimeToNextMeasurement == ProfileMgr.MS_OFF) {
                        minTimeToNextMeasurement = timeLeftMS;
                    } else {
                        if (timeLeftMS < minTimeToNextMeasurement) {
                            minTimeToNextMeasurement = timeLeftMS;
                        }
                    }
                }
            }
        }
    }
    
    return minTimeToNextMeasurement;
     */
    
}
-(bool)shouldScheduleMeasurementNow:(NSString*)sensorType{
    if ([sensorType isEqualToString: [self getSensorType]] && IsScheduledNow()) {
        return true;
    }
    else {
        return false;
    }

}
-(bool)handleEvent{
    BOOL wasProcessed = false;
    
    //Check to see if we should handle this event now
    if (![self isScheduledNow]) {
        return false;
    }
    /*
    //Pass the event on to all the handlers
    for (int handlerIdx = 0; handlerIdx < handlers.size(); handlerIdx++) {
        
        if (handlers.get(handlerIdx).HandleEvent(ctx, location)) {
            wasProcessed = true;
        }
    }
    */
    return wasProcessed;
    
}

@end
