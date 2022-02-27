#include "CSPrefs.h"

@implementation CSPrefs
	- (void)viewDidLoad {
		[super viewDidLoad];
		UIBarButtonItem* applyBtn = [[UIBarButtonItem alloc]  initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
		[self.navigationItem setRightBarButtonItem:applyBtn];
	}
	- (void)previewPassSounds:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedPass);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/ActionSounds/%@",value]],&selectedPass);
		AudioServicesPlaySystemSound(selectedPass);
		[super setPreferenceValue:value specifier:specifier];
	}
	- (NSArray *)getPassSounds:(id)target {
		NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURL in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/ActionSounds/" error:NULL] filteredArrayUsingPredicate:predicate]) {
			[listing addObject:fileURL];
		}
		return listing;
	}
	- (void)previewFailSounds:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedPass);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/ActionSounds/%@",value]],&selectedFail);
		AudioServicesPlaySystemSound(selectedFail);
		[super setPreferenceValue:value specifier:specifier];	
	
	}
	- (NSArray *)getFailSounds:(id)target {
		NSMutableArray *listingA = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicateA = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURLA in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/ActionSounds/" error:NULL] filteredArrayUsingPredicate:predicateA]) {
			[listingA addObject:fileURLA];
		}
		return listingA;
	}
	- (void)apply:(id)sender {
		UIAlertController *ApplyChanges = [
			UIAlertController alertControllerWithTitle:@"Apply Changes?"
			message:@"Are you sure you want to apply changes?"
			preferredStyle:UIAlertControllerStyleAlert
		];
		UIAlertAction *noApply = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
		UIAlertAction *yesApply = [
			UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				pid_t pid;
				const char* args[] = {"killall", "backboardd", NULL};
				posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			}
		];
		[ApplyChanges addAction:noApply];
		[ApplyChanges addAction:yesApply];
		[self presentViewController:ApplyChanges animated: YES completion: nil];
	}
@end