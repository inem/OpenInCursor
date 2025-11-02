//
//  main.m
//  Open in Cursor
//
//  Created by Sertac Ozercan on 7/9/2016.
//  Copyright Sertac Ozercan 2016. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Finder.h"

NSString* getPathToFrontFinderWindow(){

	FinderApplication* finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];

	FinderItem *target = [(NSArray*)[[finder selection]get] firstObject];
    if (target == nil){
        target = [[[[finder FinderWindows] firstObject] target] get];
    }

	NSURL* url =[NSURL URLWithString:target.URL];
	NSError* error;
	NSData* bookmark = [NSURL bookmarkDataWithContentsOfURL:url error:nil];
    NSURL* fullUrl = [NSURL URLByResolvingBookmarkData:bookmark
                                        options:NSURLBookmarkResolutionWithoutUI
                                  relativeToURL:nil
                            bookmarkDataIsStale:nil
                                          error:&error];
    if(fullUrl != nil){
        url = fullUrl;
    }

	NSString* path = [[url path] stringByExpandingTildeInPath];

    BOOL isDir = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];

	if(!isDir){
		path = [path stringByDeletingLastPathComponent];
	}

	return path;
}

int main(int argc, char *argv[])
{
	id pool = [[NSAutoreleasePool alloc] init];

	NSString* path;
	@try{
		path = getPathToFrontFinderWindow();
		NSLog(@"Open in Cursor: Opening path: %@", path);
	}@catch(id ex){
		path =[@"~/Desktop" stringByExpandingTildeInPath];
		NSLog(@"Open in Cursor: Error getting path, using Desktop: %@", path);
	}

    // Fallback if path is nil
    if (path == nil || [path length] == 0) {
        path = [@"~/Desktop" stringByExpandingTildeInPath];
        NSLog(@"Open in Cursor: Path was nil or empty, using Desktop: %@", path);
    }

    NSString* bundleId = @"com.todesktop.230313mzl4w4u92";
    NSLog(@"Open in Cursor: Opening Cursor (bundle ID: %@) with path: %@", bundleId, path);

    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/open"];
    [task setArguments:@[@"-n", @"-b", bundleId, @"--args", path]];

    NSPipe* pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task setStandardError:pipe];

    [task launch];
    [task waitUntilExit];

    int status = [task terminationStatus];
    if (status != 0) {
        NSData* data = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Open in Cursor: Error opening Cursor. Status: %d, Output: %@", status, output);
    } else {
        NSLog(@"Open in Cursor: Successfully opened Cursor");
    }

    [task release];

	[pool release];
    return status;
}
