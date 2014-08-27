//
//  DoPhotoCell.h
//  DoImagePickerController
//
//  Created by Donobono on 2014. 1. 23..
//

#import <UIKit/UIKit.h>

@interface DoPhotoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView    *ivPhoto;
@property (strong, nonatomic) IBOutlet UIView         *vSelect;

- (void)setSelectMode:(BOOL)bSelect;

@end
