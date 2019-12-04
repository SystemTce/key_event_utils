#import "KeyEventUtilsPlugin.h"
#import <key_event_utils/key_event_utils-Swift.h>

@implementation KeyEventUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeyEventUtilsPlugin registerWithRegistrar:registrar];
}
@end
