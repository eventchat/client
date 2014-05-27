//
//  JsonParser.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

- (NSDictionary *) parse:(NSURL *) url {
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData * response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    return dict;
}

@end
