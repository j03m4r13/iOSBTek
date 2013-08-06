

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SensorHandlerBase.h"
@interface GpsMQTTHandler : SensorHandlerBase{
	/**
	 * The server we will connect to
	 */
	NSString *server; // = "dev.btekint.com";
	
	/**
	 * The port we will connect to
	 */
    long port; // = 4001;
	
	/**
	 * The username we will use
	 */
	NSString *username;
	
	/**
	 * The password we will use
	 */
	NSString *password;
	
	/**
	 * The topic we will use
	 */
	NSString *topic;
	
	/**
	 * Async task for posing messages
	 */
	//private PostMessageTask postMessageTask = null;
    
}
-(id)init;
-(NSString*)getServer;
-(void)setServer:(NSString*)server;
-(long)getPort;
-(void)setPort:(long)thePort;
-(NSString*)getUsername;
-(void)setUsername:(NSString*)username;
-(void)setPassword:(NSString*)password;
-(NSString*)getTopic;
-(void)setTopic:(NSString*)topic;
-(BOOL)processHandlerConfig:(NSString*)handlerStr;

/**
 * Handle a Location event
 * @param location The event to handle
 * @return true if the event was processed, false otherwise
 */
//@Override
//public boolean HandleEvent(Context ctx, Location location) {
-(void)broadCastMQTTLocation:(CLLocation*)location;
@end
