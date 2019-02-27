
//
//  Theme.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import UIKit

class Theme {
    
    var colors: ThemeColors
    
    private init(colors: ThemeColors) {
        self.colors = colors
    }
    
    static let main: Theme = Theme(colors: ThemeColorsDefault())
    
}

protocol ThemeColors {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var primaryTextColor: UIColor { get }
}

private class ThemeColorsDefault: ThemeColors {
    
    var primaryColor: UIColor {
        return .black
    }
    
    var secondaryColor: UIColor {
        return .white
    }
    
    var primaryTextColor: UIColor {
        return .white
    }
    
}
