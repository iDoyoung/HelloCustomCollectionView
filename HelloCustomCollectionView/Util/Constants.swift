//
//  Constants.swift
//  HelloCustomCollectionView
//
//  Created by Doyoung on 2022/02/08.
//

import Foundation

enum SegueID {
    
    case showCircularVC, showCLVC
    
    var id: String {
        switch self {
        case .showCircularVC:
            return "ShowCircularVCSegueIdentfier"
        case .showCLVC:
            return "ShowCLVCSegueIdentifier"
        }
    }
    
    
}
