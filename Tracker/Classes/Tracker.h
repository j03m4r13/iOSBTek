//
//  Tracker.h
//  Tracker
//
//  Created by Joemarie Aliling on 4/19/13.
//
//

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>


@interface Tracker : CDVPlugin <CLLocationManagerDelegate>{
    
}
@property (strong, nonatomic) CLLocationManager *locationManager;

+(BOOL)isGPSRunning;

-(void)start:(CDVInvokedUrlCommand*)command;

-(void)stop:(CDVInvokedUrlCommand*)command;

-(void)setSensorProfile:(CDVInvokedUrlCommand*)command;

// location manager delegate protocol
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations;
@end
