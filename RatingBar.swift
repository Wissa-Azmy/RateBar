//
//  RatingBar.swift

//
//  Created by Ragaie alfy on 7/10/17.Egypt ()+201113938736)
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//


//https://github.com/ragaie/RateBar.git

import UIKit

@IBDesignable open class RatingBar: UIView {
    
    @IBOutlet weak var rate1: UIButton!
    @IBOutlet weak var rate2: UIButton!
    @IBOutlet weak var rate3: UIButton!
    @IBOutlet weak var rate4: UIButton!
    @IBOutlet weak var rate5: UIButton!
    
    public var ID: String!
    public var delegate: RatingBarDelegate!
    public var rateValue = 0
    private var rateImage: UIImage! //=  UIImage.init(named: "star3")
    private var halfrateImage: UIImage! //=  UIImage.init(named: "star2")
    private var unrateImage: UIImage! //=  UIImage.init(named: "star1")
    private var allRatingButton: [UIButton]! = []
    
    // MARK: Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        initActionAndDelegete()
    }
    
    func initSubviews() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "RatingBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        // to make view fit view in design you welcome.
        view.frame = self.bounds
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // nib.contentView.frame = bounds
        
        allRatingButton = [rate1, rate2, rate3, rate4, rate5]
        addSubview(view)
        
        // custom initialization logic
        
        // initalize images
        rateImage = UIImage(named: "star3", in: bundle, compatibleWith: nil)!
        halfrateImage = UIImage(named: "star2", in: bundle, compatibleWith: nil)!
        unrateImage = UIImage(named: "star1", in: bundle, compatibleWith: nil)!
    }
    
    func initActionAndDelegete() {
        allRatingButton.forEach {$0.addTarget(self, action: #selector(self.changeRating(_:)), for: .touchUpInside)}
    }
    
    open func setRatingValue(rateValue: Double) {
        //rate value from 1 to 5
        
        for item in allRatingButton {
            item.isUserInteractionEnabled = false
        }
        
        if rateValue  <= 0 {
            for item in allRatingButton {
                item.setBackgroundImage(unrateImage, for: .normal)
            }
        } else {
            var rate = rateValue
            self.rateValue = Int(rate)
            
            if rate > 5 {
                rate = rate.truncatingRemainder(dividingBy: 5)
            }
            
            if rate <= 5 {
                var stringNumber = String(rate).split(separator: ".")
                let firstNumber: Int! = Int(stringNumber[0])
                let secandNumber: Int! = Int(stringNumber[1])
                
                if firstNumber > 1 {
                    for  i  in  0...firstNumber - 1 {
                        allRatingButton[i].setBackgroundImage(rateImage, for: .normal)
                    }
                }
                
                if secandNumber > 0 {
                    allRatingButton[firstNumber].setBackgroundImage(halfrateImage, for: .normal)
                }
            }
        }
    }
    
    fileprivate func updateRatingButtons(with value: Int) {
        for item in allRatingButton {
            item.setBackgroundImage(unrateImage, for: .normal)
            item.tag = 0
        }
        
        for i in 0...value {
            allRatingButton[i].setBackgroundImage(rateImage, for: .normal)
            allRatingButton[i].tag = 1
        }
        
        if delegate != nil {
            delegate.RatingBar(self, didChangeValue: 2)
            rateValue = value + 1
        }
    }
    
    
    @objc open func changeRating(_ sender: UIButton) {
        // if sender.tag == 0 {
        switch sender.restorationIdentifier! {
        case "rate1":
            updateRatingButtons(with: 0)
            break
            
        case "rate2":
            updateRatingButtons(with: 1)
            break
            
        case "rate3":
            updateRatingButtons(with: 2)
            break
            
        case "rate4":
            updateRatingButtons(with: 3)
            break
            
        case "rate5":
            updateRatingButtons(with: 4)
            break
            
        default:
            break
        }
        
    }
    
}
