//
//  ViewController.m
//  Matchismo
//
//  Created by Jatin Shah on 10/2/14.
//  Copyright (c) 2014 Jatin Shah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cardMatchLabel;
@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)reDeal:(UIButton *)sender {
    [self.game dealWithCardCount:[self.cardButtons count]
                       usingDeck:[self createDeck]];
    [self updateUI];
    [self.gameModeSwitch setEnabled:YES];
    [self.gameModeSwitch setOn:NO];
    [self.game setCardMatchCount:2];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    if([self.gameModeSwitch isEnabled]) {
        [self.gameModeSwitch setEnabled:NO];
    }
}

- (IBAction)changeGameMode:(UISwitch *)sender {
    if([sender isOn]) {
        [self.game setCardMatchCount:3];
    } else {
        [self.game setCardMatchCount:2];
    }
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.cardMatchLabel.text = [self matchedCardsLabel];
    }
}

- (NSString *)matchedCardsLabel
{
    NSMutableString *label = [[NSMutableString alloc] init];
    for(Card *card in self.game.chosenCards) {
        [label appendString:card.contents];
    }
    
    if([self.game.chosenCards count] == self.game.cardMatchCount) {
        if(self.game.lastMatchScore < 0) {
            return [NSString stringWithFormat:@"%@ don't match! %d points", label, self.game.lastMatchScore];
        } else if (self.game.lastMatchScore > 0) {
            return [NSString stringWithFormat:@"Matched %@ for %d points", label, self.game.lastMatchScore];
        }
    }
    return label;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront":@"cardback"];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
@end
