//
//  ApplicationController.m
//  CoreAnimationListView
//
//  Created by Patrick Geiller on 07/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ApplicationController.h"
#import "SampleObject.h"


@implementation ApplicationController

- (id)init
{
	if (![super init])	return nil;
	
	objects = [NSMutableArray array];

	// Add some objects
	int i;
	for (i=0; i<10; i++)
		[objects addObject:[[SampleObject alloc]init]];

	// Register ourselves as global observers of SampleObject
	[self bind:@"whatChanged" toObject:[SampleObject sharedInstance] withKeyPath:@"keyChanged" options:nil];
	
	[[SampleObject sharedInstance] addObserver:self forKeyPath:@"keyChanged" options:0 context:nil];
	
	return	self;
}


static double frandom(double start, double end)
{
  double r = random();
  r /= RAND_MAX;
  r = start + r*(end-start);
  
  return r;
}

//
// randomlyChangeAnAttribute
//	change an attribute of SampleObject, which will be dispatched by KVBO
//
- (IBAction)randomlyChangeAnAttribute:(id)sender
{
	if ([objects count] < 1)	return;
	int r1 = frandom(0, [objects count]);
	int r2 = frandom(0, 3);
	
	SampleObject* object = [objects objectAtIndex:r1];
	// Randomly change name
	if (r2 == 0)	
		[object setValue:[NSString stringWithFormat:@"new name %d", (int)frandom(0, 99)] forKey:@"name"];

	// Randomly change description
	if (r2 == 1)
		[object setValue:[NSString stringWithFormat:@"new desc %d", (int)frandom(0, 99)] forKey:@"description"];

	// Randomly change angle
	if (r2 == 2)	
		[object setValue:[NSNumber numberWithInt:(int)frandom(0, 360)] forKey:@"angle"];
}


//
// setWhatChanged
//	Called by KVBO as SampleObject's global notification recipient.
//
- (void)setWhatChanged:(id)whatChanged
{
	NSString* changeInfo = [NSString stringWithFormat:@"%@ of instance %x changed to %@\n", [SampleObject lastModifiedKey], [SampleObject lastModifiedInstance], [[SampleObject lastModifiedInstance] valueForKey:[SampleObject lastModifiedKey]] ];
	[textView insertText:changeInfo];
}
// dummy getter - prevents Cocoa from thinking this class is not KVO compliant.
- (id)whatChanged
{
	return	nil;
}

//
// observeValueForKeyPath:ofObject:change:context:
//	another way to listen to KVBO
//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//	NSString* changeInfo = [NSString stringWithFormat:@"from observeValueForKeyPath %@ of instance %x changed to %@\n", [SampleObject lastModifiedKey], [SampleObject lastModifiedInstance], [[SampleObject lastModifiedInstance] valueForKey:[SampleObject lastModifiedKey]] ];
//	[textView insertText:changeInfo];
}

@end
