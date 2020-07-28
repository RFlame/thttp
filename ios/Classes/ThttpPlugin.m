#import "ThttpPlugin.h"
#if __has_include(<thttp/thttp-Swift.h>)
#import <thttp/thttp-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "thttp-Swift.h"
#endif

@implementation ThttpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftThttpPlugin registerWithRegistrar:registrar];
}
@end
