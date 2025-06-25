//
//  ViewController.h
//  task1
//
//  Created by georg on 22.05.25.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *canvas;

@property (nonatomic) CGFloat brushWidth;
@property (nonatomic, strong) UIColor *brushColor;

- (IBAction)changeBrushColor:(id)sender;
- (IBAction)changeBrushSize:(UISlider *)sender;
- (IBAction)clearButtonTapped:(id)sender;
- (IBAction)saveButtonTapped:(id)sender;

@end

