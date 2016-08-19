//
//  MTUConstant.swift
//  UTIL
//
//  Created by chengfj on 16/8/16.
//  Copyright © 2016年 chengfj.com. All rights reserved.
//

import Foundation
import UIKit

/// -------
/// Block
/// -------

typealias MTVoidBlock      = () -> Void
typealias MTBoolBlock      = () -> Bool
typealias MTIntBlock       = () -> Int
typealias MTAnyobjectBlock = () -> AnyObject

/// -------
/// UIKit Size
/// -------

public let MTSCREEN_SIZE:CGSize    = UIScreen.mainScreen().bounds.size;
public let MTSCREEN_Width:CGFloat  = MTSCREEN_SIZE.width;
public let MTSCREEN_HEIGHT:CGFloat = MTSCREEN_SIZE.height;

extension UIView {
  
  /// UIView Getter size
  var mt_width:CGFloat  { return self.frame.size.width }
  var mt_height:CGFloat { return self.frame.size.height }
  var mt_minX:CGFloat   { return CGRectGetMinX(self.frame) }
  var mt_minY:CGFloat   { return CGRectGetMinY(self.frame) }
  var mt_midX:CGFloat   { return CGRectGetMidX(self.frame) }
  var mt_midY:CGFloat   { return CGRectGetMidY(self.frame) }
  var mt_maxX:CGFloat   { return CGRectGetMaxX(self.frame) }
  var mt_maxY:CGFloat   { return CGRectGetMaxY(self.frame) }
}

/// -------
/// Color
/// -------

extension UIColor {
  
  class func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
  }
  
}