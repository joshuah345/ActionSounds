#line 1 "Tweak.xm"
#import "Tweak.h"
#import <LocalAuthentication/LAContext.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class LAContext; 
static void (*_logos_orig$_ungrouped$LAContext$evaluatePolicy$localizedReason$reply$)(_LOGOS_SELF_TYPE_NORMAL LAContext* _LOGOS_SELF_CONST, SEL, LAPolicy, NSString *, void (^)(BOOL success, NSError *error)); static void _logos_method$_ungrouped$LAContext$evaluatePolicy$localizedReason$reply$(_LOGOS_SELF_TYPE_NORMAL LAContext* _LOGOS_SELF_CONST, SEL, LAPolicy, NSString *, void (^)(BOOL success, NSError *error)); 

#line 4 "Tweak.xm"

static void _logos_method$_ungrouped$LAContext$evaluatePolicy$localizedReason$reply$(_LOGOS_SELF_TYPE_NORMAL LAContext* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, LAPolicy policy, NSString * localizedReason, void (^reply)(BOOL success, NSError *error)) {
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
       _logos_orig$_ungrouped$LAContext$evaluatePolicy$localizedReason$reply$(self, _cmd, policy, localizedReason, myHandler);  
  
}

















static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$LAContext = objc_getClass("LAContext"); { MSHookMessageEx(_logos_class$_ungrouped$LAContext, @selector(evaluatePolicy:localizedReason:reply:), (IMP)&_logos_method$_ungrouped$LAContext$evaluatePolicy$localizedReason$reply$, (IMP*)&_logos_orig$_ungrouped$LAContext$evaluatePolicy$localizedReason$reply$);}} }
#line 44 "Tweak.xm"
