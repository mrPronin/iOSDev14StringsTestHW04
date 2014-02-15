//
//  RITAppDelegate.m
//  14StringsTestHW04
//
//  Created by Pronin Alexander on 14.02.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import "RITAppDelegate.h"

@implementation RITAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString* text = @"The NSString class declares the programmatic interface for an object that manages immutable strings. An immutable string is a text string that is defined when it is created and subsequently cannot be changed. NSString is implemented to represent an array of Unicode characters, in other words, a text string. The mutable subclass of NSString is NSMutableString. The NSString class has two primitive methods—length and characterAtIndex:—that provide the basis for all other methods in its interface. The length method returns the total number of Unicode characters in the string. characterAtIndex: gives access to each character in the string by index, with index values starting at 0. NSString declares methods for finding and comparing strings. It also declares methods for reading numeric values from strings, for combining strings in various ways, and for converting a string to different forms (such as encoding and case changes). The Application Kit also uses NSParagraphStyle and its subclass NSMutableParagraphStyle to encapsulate the paragraph or ruler attributes used by the NSAttributedString classes. Additionally, methods to support string drawing are described in NSString Additions, found in the Application Kit. NSString is “toll-free bridged” with its Core Foundation counterpart, CFStringRef. See “Toll-Free Bridging” for more information on toll-free bridging. String Objects NSString objects represent character strings in frameworks. Representing strings as objects allows you to use strings wherever you use other objects. It also provides the benefits of encapsulation, so that string objects can use whatever encoding and storage are needed for efficiency while simply appearing as arrays of characters. The cluster’s two public classes, NSString and NSMutableString, declare the programmatic interface for non-editable and editable strings, respectively. Note: An immutable string is a text string that is defined when it is created and subsequently cannot be changed. An immutable string is implemented as an array of Unicode characters (in other words, a text string). To create and manage an immutable string, use the NSString class. To construct and manage a string that can be changed after it has been created, use NSMutableString. The objects you create using NSString and NSMutableString are referred to as string objects (or, when no confusion will result, merely as strings).";
    
    
    NSLog(@"\n\nInitial string = \n%@", text);
    
    //NSMutableString* finalString = [self transformText01:text];
    
    NSMutableString* finalString = [self transformText02:text];
    
    NSLog(@"\n\nFinal string = \n%@\n\n",finalString);
    
    return YES;
}

- (NSMutableString*) transformText01:(NSString*) text {
    
    NSMutableString*    finalString         = [NSMutableString string];
    // divide text into sentences
    NSArray*            sentenceArray       = [text componentsSeparatedByString:@". "];
    NSCharacterSet*     letterCharacterSet  = [NSCharacterSet letterCharacterSet];
    NSString*           zeroString          = @"";
    NSString*           spaceString         = @" ";
    NSString*           dotAndSpace         = @". ";
    NSInteger textLength = [sentenceArray count];
    NSInteger sentenceCount = 0;
    // sentences cycle
    for (NSString* sentence in sentenceArray) {
        // divide sentence into words
        NSArray* wordsArray = [sentence componentsSeparatedByString:@" "];
        NSInteger sentenceLength = [wordsArray count];
        NSInteger wordCount = 0;
        // process every word in cycle
        for (NSString* word in wordsArray) {
            
            NSMutableString* wordMutable = [NSMutableString stringWithString:word];
            NSInteger wordLength = [word length];
            // search the first letter and lower case it
            for (int i = 0; i < wordLength; i++) {
                unichar ch = [wordMutable characterAtIndex:i];
                if ([letterCharacterSet characterIsMember:ch]) {
                    NSString* chString = [[NSString stringWithCharacters:&ch length:1] lowercaseString];
                    [wordMutable replaceCharactersInRange:NSMakeRange(i, 1) withString:chString];
                    break;
                }
            }
            // search the last letter in word and upper case it
            for (int i = wordLength - 1; i >= 0; i--) {
                unichar ch = [wordMutable characterAtIndex:i];
                if ([letterCharacterSet characterIsMember:ch]) {
                    NSString* chString = [[NSString stringWithCharacters:&ch length:1] uppercaseString];
                    [wordMutable replaceCharactersInRange:NSMakeRange(i, 1) withString:chString];
                    break;
                }
            }
            // add whitespaces between words except last word
            [finalString appendFormat:@"%@%@", wordMutable, (wordCount == sentenceLength - 1)?zeroString:spaceString];
            wordCount++;
        }
        // add dot and spaces between sentenses except last sentence
        [finalString appendString:(sentenceCount == textLength - 1)?zeroString:dotAndSpace];
        sentenceCount++;
    }
    return finalString;
}

- (NSMutableString*) transformText02:(NSString*) text {
    
    __block NSMutableString*    finalString         = [NSMutableString stringWithString:text];
    
    NSRange range = NSMakeRange(0, [text length]);
    
    [finalString enumerateSubstringsInRange:range
                                    options:NSStringEnumerationByWords
                                 usingBlock:^(NSString *substring,
                                              NSRange substringRange,
                                              NSRange enclosingRange,
                                              BOOL *stop) {
                                     
                                     NSRange firstCharRange = NSMakeRange(substringRange.location, 1);
                                     
                                     NSString* firstChar = [[finalString
                                                             substringWithRange:firstCharRange]
                                                            lowercaseString];
                                     
                                     [finalString
                                      replaceCharactersInRange:firstCharRange
                                      withString:firstChar];
                                     
                                     NSRange lastCharRange = NSMakeRange(substringRange.location + substringRange.length - 1, 1);
                                     
                                     NSString* lastChar = [[finalString
                                                            substringWithRange:lastCharRange]
                                                           uppercaseString];
                                     
                                     [finalString
                                      replaceCharactersInRange:lastCharRange
                                      withString:lastChar];
                                     
                                 }];

    return finalString;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
