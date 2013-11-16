//
//  SpellIntroViewController.m
//  WillSpell
//
//  Created by Andy Beck on 11/14/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "SpellIntroViewController.h"
#import "SpellViewController.h"

@interface SpellIntroViewController ()

@end

@implementation SpellIntroViewController

- (IBAction)playGame:(UIButton *)sender {
    SpellViewController *spellViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spellviewcontroller"];
    [self presentViewController:spellViewController animated:YES completion:nil];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
