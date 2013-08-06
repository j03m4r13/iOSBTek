
#import <Foundation/Foundation.h>
#import "SensorProfileBase.h"
@interface GpsSensorProfile : SensorProfileBase{
	
	/**
	 * We only want gps readings that are more accurate than this value
	 */
    long gpsAccuracyThreshold;
    
	/**
	 * We only want network readings that are more accurate than this value
	 */
	long networkAccuracyThreshold;
	
	/**
	 * We only want movement readings if the user has moved more than this distance
	 */
	long movementThreshold;
    
	/**
	 * @return The gpsAccuracyThreshold - gps readings need to be more accurate than this to be sent
	 */
    
}
-(long)getGpsAccuracyThreshold;
-(void)setGpsAccuracyThreshold:(long)gpsAccuracyThres;
-(long)getNetworkAccuracyThreshold;
-(void)setNetworkAccuracyThreshold:(long)networkAccuracyThres;
-(long)getMovementThreshold;
-(void)setMovementThreshold:(long)movementThres;
// override
-(bool)processSettingsConfig:(NSString *)settingsStr;
// overrid
-(bool)processHandlersConfig:(NSString *)handlersStr;
@end
