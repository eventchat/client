//
//  JsonParser.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

- (NSDictionary *) parse:(NSURL *) url;

@end
