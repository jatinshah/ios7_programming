//
//  Deck.h
//  Matchismo
//
//  Created by Jatin Shah on 9/29/14.
//  Copyright (c) 2014 Jatin Shah. All rights reserved.
//

@import Foundation;
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
