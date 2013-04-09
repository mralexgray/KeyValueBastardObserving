//
//  ApplicationController.h
//  CoreAnimationListView
//
//  Created by Patrick Geiller on 07/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SampleObject.h"


@interface ApplicationController : NSObject {

	NSMutableArray*		objects;
	
	IBOutlet	NSTextView*			textView;

}

- (IBAction)randomlyChangeAnAttribute:(id)sender;


@end
