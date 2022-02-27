#import "Tweak.h"
#import <LocalAuthentication/LAContext.h>

%hook LAContext
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)localizedReason reply:(void (^)(BOOL success, NSError *error))reply {
    void (^myHandler)(BOOL, NSError*) = ^(BOOL success, NSError *error) {
	
        if (success)
				{
				reply(success, error);
				BioPassSound = 0;
				AudioServicesDisposeSystemSoundID(BioPassSound);
				AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/ActionSounds/true.caf"]],&BioPassSound);
				AudioServicesPlaySystemSound(BioPassSound);
				}
		else { 
				reply(success, error);
				BioFailSound = 0;
				AudioServicesDisposeSystemSoundID(BioFailSound);
				AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/ActionSounds/fail.caf"]],&BioFailSound);
				AudioServicesPlaySystemSound(BioFailSound);
				}
	};		
       %orig(policy, localizedReason, myHandler);  
  
}
%end

/* %hook LAContext
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)localizedReason reply:(void (^)(BOOL success, NSError *error))reply {
    void (^myHandler)(BOOL, NSError*) = ^(BOOL success, NSError *error) {
        if (success)
            NSLog(@"Biometric authentication succeeded");
        else
            NSLog(@"Error = %@", error.localizedDescription);
        reply(success, error);
    };
    %orig(policy, localizedReason, myHandler);
}
%end
*/


