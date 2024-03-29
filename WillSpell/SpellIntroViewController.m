//
//  SpellIntroViewController.m
//  WillSpell
//
//  Created by Andy Beck on 11/14/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "SpellIntroViewController.h"
#import "SpellViewController.h"
#import "GameData.h"

@interface SpellIntroViewController ()

@property (strong, nonatomic) SpellViewController *spellViewController;
@property (nonatomic) NSUInteger level;
@property (strong, nonatomic) GameData *gameData;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levelSelect;
@end

@implementation SpellIntroViewController

@synthesize spellViewController = _spellViewController;

- (GameData *) gameData {
    if (!_gameData) {
        _gameData = [[GameData alloc] init];
    }
    return _gameData;
}

- (SpellViewController *) spellViewController {
    return _spellViewController;
}

- (void) setSpellViewController:(SpellViewController *) spellViewController {
    _spellViewController = spellViewController;
}

- (IBAction)playGame:(UIButton *)sender {
    [self playTheGame:NO];
}

- (IBAction)playIpadGame:(UIButton *)sender {
    [self playTheGame:YES];
    
}

- (void) playTheGame:(BOOL) goBig {
    /*[self.gameData loadGameData];
    
    NSLog(@"level:%d lastIndex:%d",level.intValue,lastIndex.intValue);
    
    [self.levelSelect setSelectedSegmentIndex:self.gameData.level.intValue];*/
    
    self.spellViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spellviewcontroller"];
    self.spellViewController.playBig = goBig;
    self.spellViewController.level = self.gameData.level.intValue;
    self.spellViewController.wordIndex = self.gameData.wordIndex.intValue;
    [self presentViewController:self.spellViewController animated:YES completion:nil];
    
    //NSString *def = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    //NSLog(@"%@", def);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self reloadGameData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)levelSelect:(UISegmentedControl *)sender {
    self.level = sender.selectedSegmentIndex;
    if (self.spellViewController) {
        self.spellViewController.level = sender.selectedSegmentIndex;
        [self.gameData saveGameData:sender.selectedSegmentIndex forLastIndex:self.spellViewController.wordIndex forNumberCorrect:self.gameData.numberCorrect.integerValue forNumberWrong:self.gameData.numberWrong.integerValue forNumberSkipped:self.gameData.numberSkipped.integerValue];
    } else {
        [self.gameData saveGameData:sender.selectedSegmentIndex forLastIndex:0 forNumberCorrect:self.gameData.numberCorrect.integerValue forNumberWrong:self.gameData.numberWrong.integerValue forNumberSkipped:self.gameData.numberSkipped.integerValue];
    }
    
    NSLog(@"Starter Index: %d", self.level);
}

- (void) reloadGameData {
    [self.gameData loadGameData];
    
    NSLog(@"level:%d lastIndex:%d",self.gameData.level.intValue,self.gameData.wordIndex.intValue);
    
    [self.levelSelect setSelectedSegmentIndex:self.gameData.level.intValue];

}
@end
