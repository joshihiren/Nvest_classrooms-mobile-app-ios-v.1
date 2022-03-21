#if os(OSX)
    typealias Image     = NSImage
    typealias ImageName = NSImage.Name
#elseif os(iOS)
    import UIKit

    typealias Image     = UIImage
    typealias ImageName = String
#endif

extension Image {
    static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
    static var assetsAndroid: Image { return Image(named: ImageName("Android"))! }
    static var assetsBack: Image { return Image(named: ImageName("Back"))! }
    static var assetsBackground: Image { return Image(named: ImageName("BackGround"))! }
    static var assetsCatsearch: Image { return Image(named: ImageName("CatSearch"))! }
    static var assetsDesignThinkingMore: Image { return Image(named: ImageName("Design_thinking_more"))! }
    static var assetsDownarrow: Image { return Image(named: ImageName("DownArrow"))! }
    static var assetsGroup: Image { return Image(named: ImageName("Group"))! }
    static var assetsHometab: Image { return Image(named: ImageName("HomeTab"))! }
    static var assetsLogo: Image { return Image(named: ImageName("Logo"))! }
    static var assetsMachine: Image { return Image(named: ImageName("Machine"))! }
    static var assetsProfiletab: Image { return Image(named: ImageName("ProfileTab"))! }
    static var assetsPulse: Image { return Image(named: ImageName("Pulse"))! }
    static var assetsPython: Image { return Image(named: ImageName("Python"))! }
    static var assetsSearch: Image { return Image(named: ImageName("Search"))! }
    static var assetsSfCheckmarkSquareFill: Image { return Image(named: ImageName("SF_checkmark_square_fill"))! }
    static var assetsSfChevronCompactDown: Image { return Image(named: ImageName("SF_chevron_compact_down"))! }
    static var assetsSfChevronCompactUp: Image { return Image(named: ImageName("SF_chevron_compact_up"))! }
    static var assetsSfChevronLeftSquareFill: Image { return Image(named: ImageName("SF_chevron_left_square_fill"))! }
    static var assetsSfClockFill: Image { return Image(named: ImageName("SF_clock_fill"))! }
    static var assetsSfPlayCircleFill: Image { return Image(named: ImageName("SF_play_circle_fill"))! }
}