#import "WidgetsFunctionsPlugin.h"
#if __has_include(<widgets_functions/widgets_functions-Swift.h>)
#import <widgets_functions/widgets_functions-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "widgets_functions-Swift.h"
#endif

@implementation WidgetsFunctionsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWidgetsFunctionsPlugin registerWithRegistrar:registrar];
}
@end
