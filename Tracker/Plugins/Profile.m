

#import "Profile.h"

@implementation Profile

// Constructor
-(id)initWithName:(NSString *)theName{
    if(self = [super init]){
        name = theName;
        sensorProfiles = [[NSMutableArray alloc] initWithCapacity: 50]; //50 must be decided
    }
    return self;
}


-(NSString*)getName{
    return name;
}


-(void)setName:(NSString *)theName{
    name = theName;
}


-(void)addSensorProfile:(SensorProfileBase *)sensorProfile{
    if(sensorProfiles != nil){
        [sensorProfiles addObject: sensorProfiles];
    }
}


-(NSMutableArray*)getSensorProfiles{
    return sensorProfiles;
}


-(NSMutableArray*)getActiveSensorProfiles:(NSString *)sensorType{
    NSMutableArray *profiles = [[NSMutableArray alloc] initWithCapacity: 50];
    for(int profIdx = 0; profIdx < [sensorProfiles count]; profIdx++){
        SensorProfileBase *sp = [sensorProfiles objectAtIndex: profIdx];
        /*
        if (sp.getSensorType().equalsIgnoreCase(sensorType)  && sp.IsScheduledNow()) {
            profiles.add(sp);
        }
         */
    
    }
    return profiles;
}

/**
 * Returns the minimum sensor measurement frequency for the specified sensor
 * @param sensorType The type of sensor - see sensor types above
 * @return Minimum sensor frequency
 */
-(long)getMinSensorFrequency:(NSString *)sensorType{
    long minSensorFreq = 0;
    long sensorFreq;
    for(int profIdx = 0; profIdx < [sensorProfiles count]; profIdx++){
        sensorFreq = [[sensorProfiles objectAtIndex: profIdx] getMinSensorFrequency: sensorType];
        if(sensorFreq > 0){
            minSensorFreq = sensorFreq;
        }else{
            if(sensorFreq < minSensorFreq){
                minSensorFreq = sensorFreq;
            }
        }
    }
    return  minSensorFreq;
}

/**
 * Returns the minimum sensor measurement frequency for the specified active live now (enabled, and active now)
 * @param sensorType The type of sensor - see sensor types above
 * @return Minimum sensor frequency
 */

-(long)getMinLiveSensorFrequency:(NSString *)sensorType{
    long minSensorFreq = 0;
    long sensorFreq;
    for(int profIdx = 0; profIdx < [sensorProfiles count]; profIdx++){
        sensorFreq = [[sensorProfiles objectAtIndex: profIdx] getMinLiveSensorFrequency: sensorType];
        if(sensorFreq > 0){
            minSensorFreq = sensorFreq;
        }else{
            if(sensorFreq < minSensorFreq){
                minSensorFreq = sensorFreq;
            }
        }
    }
    return  minSensorFreq;
}

-(long)getTimeToNextMeasurement:(NSString *)sensorType{
    long minTimeToNextMeasurement = 0; // = ProfileMgr.MS_OFF;
    long timeToNext;
    for(int profIdx = 0; profIdx < [sensorProfiles count]; profIdx++){
        timeToNext = [[sensorProfiles objectAtIndex: profIdx] getTimeToNextMeasurement: sensorType];
        /*
        if (timeToNext != ProfileMgr.MS_OFF) {
            if (minTimeToNextMeasurement == ProfileMgr.MS_OFF) {
                minTimeToNextMeasurement = timeToNext;
            } else {
                if (timeToNext < minTimeToNextMeasurement) {
                    minTimeToNextMeasurement = timeToNext;
                }
            }
        }
         */
        
    }
    return minTimeToNextMeasurement;
}
/**
 * Returns true if any of the sensor profiles are ready to get a sensor event
 * @param sensorType The type of sensor to be scheduled
 * @return true if scheduled, false otherwise
 */

-(bool)shouldScheduleMeasurementNow:(NSString *)sensorType{
    for (int profIdx = 0; profIdx < [sensorProfiles count]; profIdx++) {
        if ([[sensorProfiles objectAtIndex: profIdx] shouldScheduleMeasurementNow:sensorType]) {
            return true;
        }
    }
    return false;    
}

//Add handlers for different types of events here...

/**
 * Handle a Location event
 * @param location The event to handle
 * @return true if the event was processed, false otherwise
 */

-(bool)handleEvent{
    bool wasProcessed = false;
    return wasProcessed;
}
// Destructor
-(void)dealloc{
    [sensorProfiles release];
    sensorProfiles = nil;
    [name release];
    name = nil;
}
@end
