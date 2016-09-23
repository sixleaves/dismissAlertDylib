//
//  quicktest.mm
//  quicktest
//
//  Created by admini on 16/9/7.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>
#import "CaptainHook/CaptainHook.h"
#import <UIKit/UIAlertView.h>
#import <UIKit/UIImagePickerController.h>

//CHDeclareClass(SBWifiManager);
//CHMethod(1, void, SBWifiManager, setWiFiEnabled, BOOL, arg1) {
//    CHSuper(1, SBWifiManager, setWiFiEnabled, arg1);
//    NSLog(@"在搞wifi! attention!");
//}
//
//CHMethod(1, void, SBWifiManager, setPowered, BOOL, arg1) {
//    CHSuper(1, SBWifiManager, setPowered, arg1);
//    NSLog(@"在搞wifi setPowerd! attention!");
//}
CHDeclareClass(UIViewController);
CHMethod(3, void, UIViewController, presentViewController,  id, vc, animated, bool, arg2, completion, bool, arg3) {

    if (![vc isKindOfClass:objc_getClass("UIImagePickerController")]) {
        CHSuper(3, UIViewController,presentViewController, vc, animated, arg2, completion, arg3);
    }else {
        NSLog(@"成功屏蔽相册功能");
    }
}

CHDeclareClass(UIApplication); // declare class
CHMethod(1, void, UIApplication,registerUserNotificationSettings, id, arg1) {
    NSLog(@"notification!");

}

CHMethod(0, void, UIApplication, registerForRemoteNotifications) {
    NSLog(@"notification!");
}

CHMethod(1, void, UIApplication, registerForRemoteNotificationTypes, id, arg1) {
    NSLog(@"notification!");
}


CHDeclareClass(CLLocationManager);
CHMethod(0, BOOL, CLLocationManager, locationServicesEnabled) {
    return YES;
}

CHMethod(0, void, CLLocationManager, startUpdatingLocation) {
    NSLog(@"start updating location!");
}
CHMethod(0, void, CLLocationManager, requestWhenInUseAuthorization) {
    NSLog(@"location hook!");
}
CHMethod(0, void, CLLocationManager,requestAlwaysAuthorization) {
    NSLog(@"location hook!");
}

__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(UIApplication);
    CHLoadLateClass(CLLocationManager);
    CHLoadLateClass(UIViewController);
    CHClassHook(3, UIViewController, presentViewController, animated, completion);
    CHClassHook(0, UIApplication, registerForRemoteNotifications);
    CHClassHook(1, UIApplication, registerUserNotificationSettings);
    CHClassHook(1, UIApplication, registerForRemoteNotificationTypes);
    CHClassHook(0, CLLocationManager, requestWhenInUseAuthorization);
    CHClassHook(0, CLLocationManager, requestAlwaysAuthorization);
    CHClassHook(0, CLLocationManager, startUpdatingLocation);
    CHClassHook(0, CLLocationManager, locationServicesEnabled);
    
}

