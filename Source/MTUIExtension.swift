//
//  MTUIExtension.swift
//  UTIL
//
//  Created by chengfj on 16/8/17.
//  Copyright © 2016年 chengfj.com. All rights reserved.
//

import Foundation
import UIKit

class MTExtensionProcolStack:NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
  
  typealias DictHander = (info : [String : AnyObject])->Void;
  
  static let shareInstance:MTExtensionProcolStack = MTExtensionProcolStack();
  
  var imageCallBackHander:DictHander? = nil;
  
  func imagePickerController(picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    self.imageCallBackHander?(info: info);
    picker.dismissViewControllerAnimated(true, completion: nil);
  }
  
}

enum MTPickerImageResult {
  case Success(image:UIImage)
  case Failure(errorMsg:String)
}

extension UIImagePickerController {
  
  class func showPickerController(parentController:UIViewController,allowsEditing:Bool,complete:(MTPickerImageResult)->Void) -> UIImagePickerController {
    
    let imgPicker = UIImagePickerController();
    imgPicker.allowsEditing = allowsEditing;
    imgPicker.delegate = MTExtensionProcolStack.shareInstance;
    
    let alertController = UIAlertController.init(title: "选择照片", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet);
    alertController.addAction(UIAlertAction.init(title: "相册选择", style: UIAlertActionStyle.Default, handler: { (action) in
      
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        parentController.presentViewController(imgPicker, animated: true, completion: nil);
        MTExtensionProcolStack.shareInstance.imageCallBackHander = { info in
          if let img = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            complete(MTPickerImageResult.Success(image: img))
          } else {
            complete(MTPickerImageResult.Failure(errorMsg: "照片选择错误"));
          }
        }
        
      } else {
        complete(MTPickerImageResult.Failure(errorMsg: "无权限访问照片"));
      }
      
    }))
    alertController.addAction(UIAlertAction.init(title: "拍一张", style: UIAlertActionStyle.Default, handler: { (action) in
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
        imgPicker.sourceType = UIImagePickerControllerSourceType.Camera;
        parentController.presentViewController(imgPicker, animated: true, completion: nil);
        MTExtensionProcolStack.shareInstance.imageCallBackHander = { info in
          if let img = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            complete(MTPickerImageResult.Success(image: img))
          } else {
            complete(MTPickerImageResult.Failure(errorMsg: "拍照错误"));
          }
        }
      } else {
        complete(MTPickerImageResult.Failure(errorMsg: "无权限访问相机"));
      }

    }))
    alertController.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action) in
    }))
    parentController.presentViewController(alertController, animated: true) { 
      
    };
    return imgPicker;
  }
  
}