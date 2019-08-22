//
//  WeatherView.swift
//  Sunshine
//
//  Created by Jerry Hanks on 22/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import SnapKit


class WeatherVeiw: UIView {
    
    @IBInspectable var  icon : UIImage?{
        set(value){iconImageView.image = value}
        get{return iconImageView.image}
    }
    
    @IBInspectable var title:String?{
        set(value){titlelabel.text = value}
        get{return titlelabel.text}
    }
    
    @IBInspectable var value:String?{
        set(value){valueLabel.text = value}
        get{return valueLabel.text}
    }
    
    var attribuetedValue:NSAttributedString?{
        set(value){valueLabel.attributedText = value}
        get{return valueLabel.attributedText}
    }
    
    internal lazy var  iconImageView : UIImageView = {
        return UIImageView()
    }()
    
    internal lazy var titlelabel : UILabel = {
        return UILabel().then{
            $0.font = UIFont(name: "HelveticaNeue-Bold", size: 14)!
            $0.textColor = UIColor(hex: "#ffffff")
        }
    }()
    
    internal lazy var valueLabel : UILabel = {
        return UILabel().then{
            $0.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 26)!
            $0.textColor = UIColor(hex: "#ffffff")
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        setUpViews()
    }
    
    override func awakeFromNib() {
        setUpViews()
    }
    
    
    func setUpViews(){
        self.customCornerRadius  = 10
        self.borderWidth  = 1
        self.borderColor = UIColor(hex: "#5d606a")
        
        //add iconImageView
        self.addSubview(iconImageView)
        self.iconImageView.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(self.frame.height * 1/4)
            make.top.equalToSuperview().offset(24)
        }
        
        self.iconImageView.contentMode = .scaleAspectFit
        
        //add title label
        self.addSubview(titlelabel)
        self.titlelabel.snp.makeConstraints{make in
            make.top.equalTo(iconImageView.snp_bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        self.addSubview(valueLabel)
        self.valueLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(16)
        }
    }
}

