
#import "MosquittoMessage.h"

@implementation MosquittoMessage

@synthesize mid, topic, payload, payloadlen, qos, retain;

-(id)init
{
    self.mid = 0;
    self.topic = nil;
    self.payload = nil;
    self.payloadlen = 0;
    self.qos = 0;
    self.retain = FALSE;
    return self;
}

@end
