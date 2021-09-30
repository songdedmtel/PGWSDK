#import "PgwSdkPlugin.h"
#if __has_include(<pgw_sdk/pgw_sdk-Swift.h>)
#import <pgw_sdk/pgw_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pgw_sdk-Swift.h"
#endif

@implementation PgwSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPgwSdkPlugin registerWithRegistrar:registrar];
}
@end
