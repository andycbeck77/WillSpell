//
//  MysteryWord.m
//  WillSpell
//
//  Created by Andy Beck on 11/4/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "MysteryWord.h"

NSString *const DEFAULT_CHAR = @"-";

@interface MysteryWord()

@end

@implementation MysteryWord

- (NSArray *)wordList {
    return @[@"APPLE",@"BANANA",@"PEAR",@"ORANGE"];
}

- (NSMutableArray *) guessedWord {
    if (!_guessedWord) {
        _guessedWord = [[NSMutableArray alloc] init];
    }
    return _guessedWord;
}

- (NSMutableArray *) actualWord {
    if(!_actualWord) {
        _actualWord = [[NSMutableArray alloc] init];
    }
    return _actualWord;
}

- (void) clearWord {
    _actualWord = [[NSMutableArray alloc] init];
    _guessedWord = [[NSMutableArray alloc] init];
}

- (void) initCurrentWordByIndex:(NSInteger)wordIndex {
    [self initCurrentWord:self.wordList[wordIndex]];
}
- (void) initCurrentWord:(NSString *)word {
    for (NSUInteger currentLetterIndex = 0; currentLetterIndex < [word length]; currentLetterIndex++) {
        
        NSRange range = NSMakeRange (currentLetterIndex, 1);
        NSString *currentLetter = [word substringWithRange:range];
        
        //_actualWord[currentLetterIndex] = currentLetter;
        [self.actualWord addObject:currentLetter];
        //_guessedWord[currentLetterIndex] = @"-";
        [self.guessedWord addObject:DEFAULT_CHAR];
    }
}

- (BOOL) makeGuess:(NSString *)letter atIndex:(NSUInteger) index {
    
    if ([letter isEqualToString:_actualWord[index]]) {
        _guessedWord[index] = letter;
        return YES;
    }
    
    return NO;
}

- (void) hint {
    [self hint:1];
}

- (void) hint:(NSUInteger) numberOfLetters {
    BOOL foundMatch = NO;
    while (numberOfLetters > 0) {
        for (NSUInteger currentLetterIndex = _guessedWord.count-1; currentLetterIndex >= 0; currentLetterIndex--) {
            if ([DEFAULT_CHAR isEqualToString:(NSString *)_guessedWord[currentLetterIndex]]) {
                _guessedWord[currentLetterIndex] = _actualWord[currentLetterIndex];
                numberOfLetters--;
                foundMatch = YES;
                break;
            }
        }
        
        if (!foundMatch) {
            return;
        }
    }
}

@end
