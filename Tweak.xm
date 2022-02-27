#import "CSProvider.h"
#import "Tweak.h"
#import <LocalAuthentication/LAContext.h>

%ctor {
	kEnabled = [prefs boolForKey:@"kTweakEnabled"];
	kCusBioPass = [prefs boolForKey:@"kCusBioPass"];
	kCusBioFail = [prefs boolForKey:@"kCusBioFail"];
}

%hook LAContext
- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)localizedReason reply:(void (^)(BOOL success, NSError *error))reply {
    void (^myHandler)(BOOL, NSError*) = ^(BOOL success, NSError *error) {
reply(success, error);
        if (success) {
		if (kEnabled){
			if (kCusBioPass) {
				BioPassSound = 0;
				AudioServicesDisposeSystemSoundID(BioPassSound);
				AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/ActionSounds/%@",kBioPassSound]],&BioPassSound);
				AudioServicesPlaySystemSound(BioPassSound);
			}}} else { %orig;
		NSLog(@"Error = %@", error.localizedDescription);

		if (kEnabled)
			if (kCusBioFail) 
				BioFailSound = 0;
				AudioServicesDisposeSystemSoundID(BioFailSound);
				AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/ActionSounds/%@",kBioFailSound]],&BioFailSound);
				AudioServicesPlaySystemSound(BioFailSound);
			}};
         
    
    %orig(policy, localizedReason, myHandler);
}
%end