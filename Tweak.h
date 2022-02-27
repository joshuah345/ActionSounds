#import <AudioToolbox/AudioServices.h>

#define prefs [CSProvider sharedProvider]

static bool kEnabled;
static bool kCusBioFail;
static bool kCusBioPass;

int soundCount = 1;

NSString *kBioPassSound;
NSString *kBioFailSound;

// NSString *deleteKey = [[NSBundle bundleWithPath:@"/System/Library/Audio/UISounds/"] pathForResource:@"key_press_delete" ofType:@"caf"];

SystemSoundID BioPassSound;
SystemSoundID BioFailSound;



