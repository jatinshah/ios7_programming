//
//  Card.h
//  Matchismo
//
//  Created by Jatin Shah on 9/29/14.
//  Copyright (c) 2014 Jatin Shah. All rights reserved.
//

@import Foundation;

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
