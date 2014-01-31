//
//  AppDelegate.h
//  Daily5
//
//  Created by Mohammad Azam on 9/25/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}
@property (nonatomic,copy) NSString *databaseName;
@property (nonatomic,copy) NSString *databasePath;

@property (strong, nonatomic) UIWindow *window;

@end
