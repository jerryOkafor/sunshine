//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.image` struct is generated, and contains static references to 14 images.
  struct image {
    /// Image `icClear`.
    static let icClear = Rswift.ImageResource(bundle: R.hostingBundle, name: "icClear")
    /// Image `icCloudy`.
    static let icCloudy = Rswift.ImageResource(bundle: R.hostingBundle, name: "icCloudy")
    /// Image `icFogCopy`.
    static let icFogCopy = Rswift.ImageResource(bundle: R.hostingBundle, name: "icFogCopy")
    /// Image `icLightClouds`.
    static let icLightClouds = Rswift.ImageResource(bundle: R.hostingBundle, name: "icLightClouds")
    /// Image `icLightRain`.
    static let icLightRain = Rswift.ImageResource(bundle: R.hostingBundle, name: "icLightRain")
    /// Image `icRain`.
    static let icRain = Rswift.ImageResource(bundle: R.hostingBundle, name: "icRain")
    /// Image `icSnow`.
    static let icSnow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icSnow")
    /// Image `icStorm`.
    static let icStorm = Rswift.ImageResource(bundle: R.hostingBundle, name: "icStorm")
    /// Image `ic_humidity`.
    static let ic_humidity = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_humidity")
    /// Image `ic_logo`.
    static let ic_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_logo")
    /// Image `ic_pressure`.
    static let ic_pressure = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_pressure")
    /// Image `ic_settings`.
    static let ic_settings = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_settings")
    /// Image `ic_uv_index`.
    static let ic_uv_index = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_uv_index")
    /// Image `ic_visibility`.
    static let ic_visibility = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_visibility")
    
    /// `UIImage(named: "icClear", bundle: ..., traitCollection: ...)`
    static func icClear(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icClear, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icCloudy", bundle: ..., traitCollection: ...)`
    static func icCloudy(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icCloudy, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icFogCopy", bundle: ..., traitCollection: ...)`
    static func icFogCopy(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icFogCopy, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icLightClouds", bundle: ..., traitCollection: ...)`
    static func icLightClouds(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icLightClouds, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icLightRain", bundle: ..., traitCollection: ...)`
    static func icLightRain(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icLightRain, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icRain", bundle: ..., traitCollection: ...)`
    static func icRain(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icRain, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icSnow", bundle: ..., traitCollection: ...)`
    static func icSnow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icSnow, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icStorm", bundle: ..., traitCollection: ...)`
    static func icStorm(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icStorm, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_humidity", bundle: ..., traitCollection: ...)`
    static func ic_humidity(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_humidity, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_logo", bundle: ..., traitCollection: ...)`
    static func ic_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_logo, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_pressure", bundle: ..., traitCollection: ...)`
    static func ic_pressure(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_pressure, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_settings", bundle: ..., traitCollection: ...)`
    static func ic_settings(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_settings, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_uv_index", bundle: ..., traitCollection: ...)`
    static func ic_uv_index(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_uv_index, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_visibility", bundle: ..., traitCollection: ...)`
    static func ic_visibility(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_visibility, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `ForcastPagerViewCell`.
    static let forcastPagerViewCell = _R.nib._ForcastPagerViewCell()
    
    /// `UINib(name: "ForcastPagerViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.forcastPagerViewCell) instead")
    static func forcastPagerViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.forcastPagerViewCell)
    }
    
    static func forcastPagerViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ForcastPagerViewCell? {
      return R.nib.forcastPagerViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ForcastPagerViewCell
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `DailyItemViewCell`.
    static let dailyItemViewCell: Rswift.ReuseIdentifier<DailyItemViewCell> = Rswift.ReuseIdentifier(identifier: "DailyItemViewCell")
    /// Reuse identifier `ForcastPagerViewCell`.
    static let forcastPagerViewCell: Rswift.ReuseIdentifier<ForcastPagerViewCell> = Rswift.ReuseIdentifier(identifier: "ForcastPagerViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _ForcastPagerViewCell.validate()
    }
    
    struct _ForcastPagerViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = ForcastPagerViewCell
      
      let bundle = R.hostingBundle
      let identifier = "ForcastPagerViewCell"
      let name = "ForcastPagerViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ForcastPagerViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ForcastPagerViewCell
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_logo' is used in nib 'ForcastPagerViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let detailViewController = StoryboardViewControllerResource<DetailViewController>(identifier: "DetailViewController")
      let homeViewController = StoryboardViewControllerResource<HomeViewController>(identifier: "HomeViewController")
      let name = "Main"
      let settingsViewController = StoryboardViewControllerResource<SettingsViewController>(identifier: "SettingsViewController")
      
      func detailViewController(_: Void = ()) -> DetailViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: detailViewController)
      }
      
      func homeViewController(_: Void = ()) -> HomeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: homeViewController)
      }
      
      func settingsViewController(_: Void = ()) -> SettingsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: settingsViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_humidity", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_humidity' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_logo' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_pressure", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_pressure' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_uv_index", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_uv_index' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_visibility", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_visibility' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().detailViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'detailViewController' could not be loaded from storyboard 'Main' as 'DetailViewController'.") }
        if _R.storyboard.main().homeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'homeViewController' could not be loaded from storyboard 'Main' as 'HomeViewController'.") }
        if _R.storyboard.main().settingsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'settingsViewController' could not be loaded from storyboard 'Main' as 'SettingsViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
