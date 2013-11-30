//
//  SpellViewController.m
//  WillSpell
//
//  Created by Andy Beck on 9/20/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "SpellViewController.h"
#import "ImageView.h"
#import "LetterScrollView.h"
#import "MysteryWord.h"
#import "GameData.h"

NSString *const WIN_IMAGE = @"winner-win.jpg"; //@"fireworks_animated_black_background_large-1.gif";

@interface SpellViewController () //<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet ImageView *imageView;
@property (weak, nonatomic) IBOutlet LetterScrollView *letterScrollView;

@property (strong, nonatomic) NSArray *letterList;
@property (strong, nonatomic) NSArray *imageList;
@property (strong, nonatomic) NSArray *wordList;
@property (strong, nonatomic) MysteryWord *mysteryWord;

@property (strong, nonatomic) GameData *gameData;
@end

@implementation SpellViewController

@synthesize imageView = _imageView;
@synthesize letterScrollView = _letterScrollView;

- (NSArray *)letterList {
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

- (NSArray *) imageList {
    return @[@"redapple.png",@"yellowbanana.png",@"greenpear.png",@"orange.png"];
}

- (NSArray *) wordList {
    return @[@"APPLE",@"BANANA",@"PEAR",@"ORANGE"];
}

- (NSArray *)colorList {
    return @[@"RED",@"YELLOW",@"GREEN",@"ORANGE"];
}

- (MysteryWord *) mysteryWord {
    if (!_mysteryWord) {
        _mysteryWord = [[MysteryWord alloc] init];
    }
    return _mysteryWord;
}

- (LetterScrollView *) letterScrollView {
    if (!_letterScrollView) {
        _letterScrollView = [[LetterScrollView alloc] init];
    }
    
    if (!_letterScrollView.winnerDelegate) {
        _letterScrollView.winnerDelegate = self;
    }
    
    return _letterScrollView;
}

- (void) setLetterScrollView:(LetterScrollView *)letterScrollView {
    _letterScrollView = letterScrollView;
}

- (ImageView *) imageView {
    if (!_imageView) {
        _imageView = [[ImageView alloc] init];
    }
    return _imageView;
}
- (void)setImageView:(ImageView *)imageView {
    _imageView = imageView;
    [imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:imageView action:@selector(pinch:)]];
}

- (GameData *) gameData {
    if (!_gameData) {
        _gameData = [[GameData alloc] init];
    }
    return _gameData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	   
    // 320, 153
    self.letterScrollView.contentSize = CGSizeMake(1640.0, 640.0);
    
    [self setupWord];
    [self.letterScrollView setupLetters:self.letterList];
}

- (void) setupWord {
    [self.imageView changeImage:self.imageList[self.wordIndex]];
    [self refreshWord];
}

- (void) refreshWord {

    if (self) {
        [self.mysteryWord initCurrentWord:self.wordList[self.wordIndex]];
        self.letterScrollView.mysteryWord = self.mysteryWord;
        [self.letterScrollView refreshWord:[self.mysteryWord guessedWord] withMysteryWord:self.mysteryWord];
    }

    // If easy fill out all but first letter, if medium give half word
    if (self.level == 0) {
        [self.mysteryWord hint:self.mysteryWord.actualWord.count-1];
        [self.letterScrollView resetWordLetters:[self.mysteryWord guessedWord]];
    } else if (self.level == 1) {
        [self.mysteryWord hint:(self.mysteryWord.actualWord.count/2)];
        [self.letterScrollView resetWordLetters:[self.mysteryWord guessedWord]];
    }
    
    [self.gameData saveGameData:self.level forLastIndex:self.wordIndex];
}
- (IBAction)giveMeAHint:(UIButton *)sender {
    if (self.letterScrollView) {
        [self.mysteryWord hint];
        [self.letterScrollView resetWordLetters:[self.mysteryWord guessedWord]];
    }
}

- (IBAction)chooseNextWord:(UIButton *)sender {
    
    if (self.wordIndex >= self.wordList.count-1) {
        self.wordIndex = 0;
    } else {
        self.wordIndex++;
    }
    
    [self.mysteryWord clearWord];
    [self refreshWord];
    [self.imageView changeImage:self.imageList[self.wordIndex]];
}

- (IBAction)exitSpellViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) winner {
    NSLog(@"winner!");
    [self.imageView changeImage:WIN_IMAGE];
}

@end
