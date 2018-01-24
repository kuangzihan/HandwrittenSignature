//
//  Signature.swift
//  HandwrittenSignature
//
//  Created by 邝子涵 on 2018/1/24.
//  Copyright © 2018年 上海仁菜网络科技有限公司. All rights reserved.
//

import UIKit

// MARK: - 计算中心点
func midpoint(_ p0: CGPoint, _ p1: CGPoint) -> CGPoint {
    return CGPoint(x: (p0.x + p1.x)/2,
                   y: (p0.y + p1.y)/2)
}


class SignatureView: UIView {
    
    // 公共属性
    open var lineWidth: CGFloat = 2.0 {  // 线粗细
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    open var strokeColor: UIColor = UIColor.black   // 画笔颜色
    
    // 私有属性
    fileprivate var currentPointArr = [NSValue]() // 当前坐标点数组
    fileprivate var previousPoint:CGPoint = .zero // 记录上一次坐标点
    fileprivate var path = UIBezierPath()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // 设置画笔粗细
        path.lineWidth = lineWidth
        
        setupGestureRecognizer()
    }
    
    
    // MARK: - 创建手势
    func setupGestureRecognizer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick(pan:)))
        pan.maximumNumberOfTouches = -1
        addGestureRecognizer(pan)
    }
    
    
    // MARK: - 手势方法
    @objc func panClick(pan: UIPanGestureRecognizer) {
        let currentPoint = pan.location(in: self)
        
        let midPoint = midpoint(previousPoint, currentPoint)
        
        currentPointArr.append(NSValue(cgPoint: currentPoint))
        
        if pan.state == .began {
            path.move(to: currentPoint)
        } else if pan.state == .changed { // 手势改变过程中改变曲线基准点
            /*
             to:曲线的终点
             controlPoint:画曲线的基准点
             */
            path.addQuadCurve(to: midPoint, controlPoint: previousPoint)
        }
        
        // 记录上一次坐标
        previousPoint = currentPoint
        
        setNeedsDisplay()
    }
    
    
    
    // MARK: - 画图
    override func draw(_ rect: CGRect) {
        // 设置画笔颜色
        strokeColor.setStroke()
        // 根据设置的路径进行画图
        path.stroke()
    }
    
    
    
    
    // MARK: - 将签名保存为UIImage
    open func getSignature() ->UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width,
                                           height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return signature
    }
    
    // MARK: - 清除签名
    func clearSignature() {
        // 清除路径数组
        currentPointArr.removeAll()
        // 移除贝塞尔曲线
        path.removeAllPoints()
        // 重汇视图
        setNeedsDisplay()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
