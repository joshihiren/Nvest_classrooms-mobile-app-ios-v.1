//
//  MyThemes.swift
//  Demo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import Foundation

private let lastThemeIndexKey = "lastedThemeIndex"
private let defaults = UserDefaults.standard

enum MyThemes: Int {
    
    case Default = 0
    case night = 1
    
    // MARK: -
    
    static var current: MyThemes { return MyThemes(rawValue: ThemeManager.currentThemeIndex)! }
    static var before = MyThemes.Default
    
    // MARK: - Switch Theme
    
    static func switchTo(theme: MyThemes) {
        before = current
        ThemeManager.setTheme(index: theme.rawValue)
    }
    
    static func switchToNext() {
        var next = ThemeManager.currentThemeIndex + 1
        if next > 0 { next = 0 } // cycle and without Night
        switchTo(theme: MyThemes(rawValue: next)!)
    }
    
    // MARK: - Switch Night
    
    static func switchNight(isToNight: Bool) {
        switchTo(theme: isToNight ? .night : before)
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
    
    // MARK: - Save & Restore
    
    static func restoreLastTheme() {
        switchTo(theme: MyThemes(rawValue: defaults.integer(forKey: lastThemeIndexKey))!)
    }
    
    static func saveLastTheme() {
        defaults.set(ThemeManager.currentThemeIndex, forKey: lastThemeIndexKey)
    }
    
}
