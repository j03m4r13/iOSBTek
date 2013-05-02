//
//  Tracker.h
//  Tracker
//
//  Created by Joemarie Aliling on 4/19/13.
//
//  This is the iOS version of the BTekSensorAPI


#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>

@interface Tracker : CDVPlugin <CLLocationManagerDelegate>{
    
}
@property (strong, nonatomic) CLLocationManager *locationManager;

+(BOOL)isGPSRunning;

-(void)start:(CDVInvokedUrlCommand*)command;

-(void)stop:(CDVInvokedUrlCommand*)command;

-(void)pause:(CDVInvokedUrlCommand*)command;

-(void)setSensorProfile:(CDVInvokedUrlCommand*)command;

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations;
@end
