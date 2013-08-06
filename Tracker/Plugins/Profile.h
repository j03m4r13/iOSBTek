
#import <Foundation/Foundation.h>
#include "SensorProfileBase.h"
/**
 by Joe
 * The behaviour of the Sensor API is controlled by the Profile.
 *
 * A profile contains a set of one of more SensorProfiles, which in turn control how the underlying sensor system works.
**/

@interface Profile : NSObject {
/**
    Profile name
**/
    NSString *name;
    
/**
    Array of SensorProfile
**/
    NSMutableArray *sensorProfiles;

    
}

-(id)initWithName: (NSString*) theName;
-(void)setName: (NSString*) theName;
-(NSString*)getName;
-(NSMutableArray*)getSensorProfiles;
-(void)addSensorProfile: (SensorProfileBase*) sensorProfile;
-(NSMutableArray*)getActiveSensorProfiles: (NSString*) sensorType;
-(long)getMinSensorFrequency: (NSString*) sensorType;
-(long)getMinLiveSensorFrequency: (NSString*) sensorType;
-(long)getTimeToNextMeasurement: (NSString*) sensorType;
-(bool)shouldScheduleMeasurementNow: (NSString*) sensorType;
-(bool)handleEvent;
@end
