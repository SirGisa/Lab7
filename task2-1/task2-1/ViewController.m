//
//  ViewController.m
//  task1
//
//  Created by georg on 22.05.25.
//

#import "ViewController.h"

@interface ViewController ()

@property CGPoint lastPoint;
@property (nonatomic) BOOL isDrawing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Инициализация по умолчанию
    self.brushColor = [UIColor blackColor];
    self.brushWidth = 5.0f;
}

#pragma mark - Жесты рисования

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
    self.isDrawing = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.canvas.bounds.size);
    [self.canvas.image drawInRect:CGRectMake(0, 0, self.canvas.bounds.size.width, self.canvas.bounds.size.height)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.brushWidth);
    CGContextSetStrokeColorWithColor(context, self.brushColor.CGColor);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextStrokePath(context);
    
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isDrawing = NO;
}

#pragma mark - IBActions

- (IBAction)changeBrushColor:(id)sender {
    // Пример: можно использовать tag для кнопок
    switch ([sender tag]) {
        case 0:
            self.brushColor = [UIColor redColor];
            break;
        case 1:
            self.brushColor = [UIColor greenColor];
            break;
        case 2:
            self.brushColor = [UIColor blueColor];
            break;
        case 3:
            self.brushColor = [UIColor blackColor];
            break;
        default:
            break;
    }
}

- (IBAction)changeBrushSize:(UISlider *)sender {
    self.brushWidth = sender.value;
}

- (IBAction)clearButtonTapped:(id)sender {
    self.canvas.image = nil;
}

- (IBAction)saveButtonTapped:(id)sender {
    if (self.canvas.image) {
        UIImageWriteToSavedPhotosAlbum(self.canvas.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message = error ? @"Не удалось сохранить изображение." : @"Рисунок сохранен в фотоальбом.";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Сохранение"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
