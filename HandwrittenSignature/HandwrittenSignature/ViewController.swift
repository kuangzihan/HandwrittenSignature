//
//  ViewController.swift
//  HandwrittenSignature
//
//  Created by 邝子涵 on 2018/1/24.
//  Copyright © 2018年 上海仁菜网络科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    lazy var signatureView: SignatureView = {
        let signatureView = SignatureView(frame: CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 230))
        
        return signatureView
    }()
    
    
    // MARK: - 清除button
    lazy var clearButton: UIButton = {
        let clearButton = UIButton(type: UIButtonType.custom)
        clearButton.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width/2, height: 50)
        clearButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        clearButton.setTitle("清除", for: UIControlState.normal)
        clearButton.addTarget(self, action: #selector(clearButtonClick), for: UIControlEvents.touchUpInside)
        return clearButton
    }()
    
    
    // MARK: - 确定button
    lazy var sureButton: UIButton = {
        let sureButton = UIButton(type: UIButtonType.custom)
        sureButton.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 20, width: UIScreen.main.bounds.width/2, height: 50)
        sureButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        sureButton.setTitle("确定", for: UIControlState.normal)
        sureButton.addTarget(self, action: #selector(sureButtonClick), for: UIControlEvents.touchUpInside)
        return sureButton
    }()
    
    
    // MARK: - image
    lazy var image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: self.signatureView.frame.maxY + 10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (self.signatureView.frame.maxY + 10)))
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view.addSubview(clearButton)
        view.addSubview(sureButton)
        view.addSubview(signatureView)
        view.addSubview(image)
    }
    
    
    
    @objc func clearButtonClick() {
        signatureView.clearSignature()
    }
    
    @objc func sureButtonClick() {
        image.image = signatureView.getSignature()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

