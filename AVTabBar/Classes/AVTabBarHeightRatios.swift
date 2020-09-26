//
//  AVTabBarHeightRatios.swift
//  AVTabBar
//
//  Created by Umesh on 26/09/20.
//

import Foundation

public enum AVTabBarHeightRatios: Float {
    case iPhone = 0.12
    case iPhoneX = 0.1201
    case iPad = 0.09
    case notDetermined = 0.2
    
    static let bestSize: AVTabBarHeightRatios = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            switch UIScreen.main.nativeBounds.height {
                case 2436:
                     return .iPhoneX

                case 2688:
                    return .iPhoneX

                case 1792:
                    return .iPhoneX

                default:
                    return .iPhone
                }
        case .pad:
            return .iPad
        default:
            return .notDetermined
        }
    }()
    
    func cornerRadius() -> CGFloat{
        return self == AVTabBarHeightRatios.iPhoneX ? 46 : 10
    }
    
    func circleRadius() -> CGFloat{
        return self == AVTabBarHeightRatios.iPhoneX ? 32 : 28
    }
}
