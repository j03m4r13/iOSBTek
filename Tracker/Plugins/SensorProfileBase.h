
#import <Foundation/Foundation.h>

@interface SensorProfileBase : NSObject{
    NSString    *sensorType;
    bool        sensorEnabled;
    NSMutableArray *schedules;
    NSMutableArray *handlers;
}

-(id)initWithSensorType:(NSString*)theSensorType withSensorEnable:(bool)theSensorEnable;
-(NSString*)getSensorType;
-(void)setSensorType:(NSString*)theSensorType;
-(bool)isSensorEnabled;
-(void)setSensorEnabled:(bool)enabled;
-(bool)processSettingsConfig:(NSString*)settingsStr;
-(bool)processSchedulesConfig:(NSString*)schedulesStr;
-(bool)processHandlersConfig:(NSString*)handlersStr;
-(bool)isScheduledToday;
-(bool)isScheduledNow;
-(long)getMinSensorFrequency:(NSString*)sensorType;
-(long)getMinLiveSensorFrequency:(NSString*)sensorType;
-(long)getTimeToNextMeasurement:(NSString*)sensorType;
-(bool)shouldScheduleMeasurementNow:(NSString*)sensorType;
-(bool)handleEvent;
@end
