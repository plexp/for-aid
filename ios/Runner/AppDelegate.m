#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

//Google Maps Require this
#import "GoogleMaps/GoogleMaps.h"
//Google Maps end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  //Google Maps Require this
  [GMSServices provideAPIKey: @"AIzaSyAIQUgMuH3Z4FZIv1hfOuKap1EjnN6xXNg"];
  //Google Maps End
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
