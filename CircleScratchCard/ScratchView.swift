//
//  ScratchView.swift
//  CircleScratchCard
//
//  Created by huangxiong on 15/6/6.
//  Copyright (c) 2015年 huangxiong. All rights reserved.
//

import UIKit

class ScratchView: UIView {
    
    let imageView: UIImageView = UIImageView(frame: CGRectZero)
    
    let maskImageView: UIImageView = UIImageView(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.frame = bounds
        self.imageView.image = UIImage(named: "user_back_04")
        self.addSubview(imageView)

        self.maskImageView.frame = bounds
        self.maskImageView.image = UIImage(named: "user_back_05")
        self.addSubview(maskImageView)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func drawImage(currentPoint: CGPoint) -> Void {
        
        // 设置可操作矩形范围
        let rect: CGRect = self.maskImageView.bounds
        
        // 当前点活动空间
        let rectCircle: CGRect = CGRectMake(currentPoint.x - 15, rect.height - currentPoint.y - 15, 30, 30)
        
        // 创建颜色空间
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        
        // 位图信息
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedFirst.rawValue)

        // 底层设备环境
        let bottomCtx : CGContextRef = CGBitmapContextCreate(nil, Int(rect.width), Int(rect.height), 8, Int(rect.width) * 4, colorSpace, bitmapInfo)
        
        // 打印当前点活动范围
        println(rectCircle)
        
        // 创建可变路径标记
        var mutablePath: CGMutablePathRef = CGPathCreateMutable()
        
        // 添加圆
        CGPathAddEllipseInRect(mutablePath, nil, rectCircle)
        
        // 将路径加到底层设备环境
        CGContextAddPath(bottomCtx, mutablePath)
        
        // 剪切设备环境
        CGContextClip(bottomCtx)
        
        // 为设备环境写入图片
        CGContextDrawImage(bottomCtx, rect, self.imageView.image?.CGImage)
        
        // 得到剪切图
        var ciclreImage: CGImageRef = CGBitmapContextCreateImage(bottomCtx)
        
        // 剪切后的图像
        var image: UIImage = UIImage(CGImage: ciclreImage)!
        
        // 面具设备环境
        let  maskCtx : CGContextRef = CGBitmapContextCreate(nil, Int(rect.width), Int(rect.height), 8, Int(rect.width) * 4, colorSpace, bitmapInfo)
        
        // 预先写入原面具图
        CGContextDrawImage(maskCtx, rect, self.maskImageView.image?.CGImage)
        
        // 添加可变路径
        CGContextAddPath(maskCtx, mutablePath)
        
        // 剪切路线路径
        CGContextClip(maskCtx)
//        CGContextClipToMask(maskCtx, rect, ciclreImage)
        
        // 写入图像
        CGContextDrawImage(maskCtx, rect, ciclreImage)
        
        // 创建新图
        let newCGImage: CGImageRef = CGBitmapContextCreateImage(maskCtx)
        
        // 创建面具图像
        let newMaskImage: UIImage = UIImage(CGImage: newCGImage)!
        
        // 设置图像
        self.maskImageView.image = newMaskImage
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        
        let currentPoint: CGPoint = touch.locationInView(self.maskImageView)
        
        self.drawImage(currentPoint)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        
        let currentPoint: CGPoint = touch.locationInView(self.maskImageView)
        
        self.drawImage(currentPoint)
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }

}
