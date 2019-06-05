//
//  ViewController.m
//  UIImageNameBackgroundBug
//
//  Created by Jonathan Rose on 03/06/2019.
//  Copyright © 2019 Jonathan Rose. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (IBAction)loadImages:(id)sender {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    [self addLog:@"starting loading"];
    BOOL loadedAll = YES;

    for (int i = 1; i < 1000; i++) {
      NSString *name = [NSString stringWithFormat:@"icon%d", i];
      UIImage *image = [UIImage imageNamed:name];
      if (image == nil) {
        [self addLog:[NSString stringWithFormat:@"unable to load image %@", name]];
        loadedAll = NO;
        break;
      }
      if (i % 50 == 0) {
        [self addLog:[NSString stringWithFormat:@"loading....%d", i]];
      }
    }

    if (loadedAll) {
      [self addLog:@"finished loading all"];
    } else {
      [self addLog:@"finished loading with errors"];
    }
  });
}

- (void)addLog:(NSString *)log {
  NSLog(@"%@", log);
  dispatch_async(dispatch_get_main_queue(), ^{
    self.textView.text = [self.textView.text stringByAppendingFormat:@"\n%@", log];
  });
}
@end
