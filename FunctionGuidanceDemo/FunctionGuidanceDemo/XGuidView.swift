//
//  XGuidView.swift
//
//  Created by wlx on 2019/10/9.
//  Copyright © 2019 WLX. All rights reserved.
//

import UIKit
import SnapKit

class XGuidView: UIView {
  fileprivate var tipsLabel = UILabel() // 所需提示语，
  fileprivate var finishImageView = UIImageView()
  fileprivate var step = 0 // 标记当点为第几步
  lazy fileprivate var rectangleFrames:[CGRect] = {()->[CGRect] in
    return [CGRect]()
  }()
  fileprivate var tipsMask:CAShapeLayer! // 遮罩层
  fileprivate var borderLayer:CAShapeLayer! // 镂空部分边框，demo中为虚线边框
  var finishClickBlock:(()->())! // 点击完成b回调方法
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.clipsToBounds = true
    self.viewDidLoad()
  }
  
  func viewDidLoad() {
    self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
    tipsLabel.textColor = UIColor.white
    tipsLabel.backgroundColor = .clear
    tipsLabel.text = "你所需要的提示"
    tipsLabel.textAlignment = .center
    addSubview(tipsLabel)
    addSubview(finishImageView)
    finishImageView.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(finshAction))
    finishImageView.addGestureRecognizer(tap)
  }
  
  // MARK: 创建提示视图
  //  rectangleFrames 为当前页面一共需要几步引导的镂空部分坐标
  func createUI(rectangleFrames:[CGRect]){
    self.rectangleFrames = rectangleFrames
    let rectangleFrame:CGRect = rectangleFrames.first!
//    tipsImageView.image = UIImage(named: "document_detail_guid_tips")
    finishImageView.image = UIImage(named: "step_next")
    createMask(frame: rectangleFrame)
    tipsLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(rectangleFrame.maxY+16)
      make.left.equalToSuperview().offset((rectangleFrame.origin.x))
      make.width.equalTo(200)
      make.height.equalTo(50)
    }
    finishImageView.snp.makeConstraints { (make) in
      make.top.equalTo(tipsLabel.snp.bottom).offset(118/2)
      make.centerX.equalToSuperview()
    }
  }
  
  // frame为镂空部分尺寸
  fileprivate func createMask(frame:CGRect){
    if tipsMask != nil {
      tipsMask.removeFromSuperlayer()
      tipsMask = nil
    }
    if self.borderLayer != nil {
      borderLayer.removeFromSuperlayer()
      self.borderLayer = nil
    }
    
    let path = UIBezierPath(rect: self.bounds)
    path.append(UIBezierPath(rect: frame).reversing()) // 反转路径形成镂空
    tipsMask = CAShapeLayer()
    tipsMask.path = path.cgPath
    self.layer.mask = tipsMask
    let borderFrame = CGRect(x: frame.origin.x - 4, y: frame.origin.y - 4, width: frame.width + 8, height: frame.height + 8)
    // 创建虚线边框
    borderLayer = CAShapeLayer()
    borderLayer.path = UIBezierPath(roundedRect: borderFrame, cornerRadius: 2).cgPath
    borderLayer.lineWidth = 1
    borderLayer.lineDashPattern = [4,4]
    borderLayer.fillColor = nil
    borderLayer.strokeColor = UIColor.white.cgColor
    self.layer.addSublayer(borderLayer)
  }
  
  // MARK: 下一步
  fileprivate func goNextStep(){
    
  }
  // MARK: 完成
  @objc fileprivate func finshAction(){
    
  }
  
  fileprivate func finishActionCallBack(key:String){
    UserDefaults.standard.setValue(true, forKey: key)
    UserDefaults.standard.synchronize()
    if self.finishClickBlock != nil {
      self.finishClickBlock()
    }
    self.removeFromSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  deinit {
    print("释放 == "+self.description)
  }
  
}
