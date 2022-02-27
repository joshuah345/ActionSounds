#import <CSPreferences/libCSPreferences.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>

@interface CSPrefs : CSPListController { SystemSoundID selectedPass; SystemSoundID selectedFail; }
	- (void)apply:(id)sender;
	- (NSArray *)getPassSounds:(id)target;
	- (NSArray *)getFailSounds:(id)target;
	- (void)previewPassSounds:(id)value forSpecifier:(id)specifier;
	- (void)previewFailSounds:(id)value forSpecifier:(id)specifier;
@end