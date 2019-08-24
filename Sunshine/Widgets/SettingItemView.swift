//
//  SettingItemView.swift
//  Sunshine
//
//  Created by Jerry Hanks on 24/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import SnapKit


class SettingsItemVeiw: UIView {
    
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
            $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
            $0.textColor = UIColor(hex: "#ffffff")
        }
    }()
    
    internal lazy var valueLabel : UILabel = {
        return UILabel().then{
            $0.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 14)!
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
            make.width.height.equalTo(self.frame.height * 1/2.5)
            make.centerY.equalToSuperview()
        }
        
        self.iconImageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView().then{
            $0.alignment = .fill
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 8
        }
        
        //add title label
        self.addSubview(stackView)
        stackView.snp.makeConstraints{make in
            make.left.equalTo(iconImageView.snp_right).offset(16)
            make.width.equalTo((self.frame.width/5) * 3)
            make.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubview(titlelabel)
        stackView.addArrangedSubview(valueLabel)
    }
}

