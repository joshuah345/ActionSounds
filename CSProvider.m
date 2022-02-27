#import "CSProvider.h"

@implementation CSProvider
	+ (CSPreferencesProvider *)sharedProvider {
		static dispatch_once_t once;
		static CSPreferencesProvider *sharedProvider;
		dispatch_once(&once, ^{
			NSString *CSBundleID = @"com.shouganai.customsounds";
			NSString *updatedPrefs = [CSBundleID stringByAppendingString:@"/updated"];
			NSString *defaultPrefs = @"/Library/PreferenceBundles/ActionSoundsPrefs.bundle/defaults.plist";
			sharedProvider = [[CSPreferencesProvider alloc] initWithTweakID:CSBundleID defaultsPath:defaultPrefs postNotification:updatedPrefs notificationCallback:^void (CSPreferencesProvider *provider) {
				[[NSNotificationCenter defaultCenter] postNotificationName:@"CSPreferencesChanged" object:nil userInfo:nil];
			}];
		});
		return sharedProvider;
	}
@end