//
//  ViewController.swift
//  FunctionGuidanceDemo
//
//  Created by lei on 2020/3/23.
//  Copyright © 2020 lei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    createUI()
  }
  
  fileprivate func createUI(){
    let button = UIButton(type: .contactAdd)
    self.view.addSubview(button)
    button.frame = CGRect(x: 100, y: 100, width: 60, height: 60)
    let guidView = XGuidView(frame: UIScreen.main.bounds)
    let frame = self.view.convert(button.frame, to: self.view)
    guidView.createUI(rectangleFrames: [frame])
    self.view.addSubview(guidView)
  }
}

