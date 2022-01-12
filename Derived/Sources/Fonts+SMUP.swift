// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum SMUPFontFamily {
  public enum NotoSansKR {
    public static let black = SMUPFontConvertible(name: "NotoSansKR-Black", family: "Noto Sans KR", path: "NotoSansKR-Black.otf")
    public static let bold = SMUPFontConvertible(name: "NotoSansKR-Bold", family: "Noto Sans KR", path: "NotoSansKR-Bold.otf")
    public static let light = SMUPFontConvertible(name: "NotoSansKR-Light", family: "Noto Sans KR", path: "NotoSansKR-Light.otf")
    public static let medium = SMUPFontConvertible(name: "NotoSansKR-Medium", family: "Noto Sans KR", path: "NotoSansKR-Medium.otf")
    public static let regular = SMUPFontConvertible(name: "NotoSansKR-Regular", family: "Noto Sans KR", path: "NotoSansKR-Regular.otf")
    public static let thin = SMUPFontConvertible(name: "NotoSansKR-Thin", family: "Noto Sans KR", path: "NotoSansKR-Thin.otf")
    public static let all: [SMUPFontConvertible] = [black, bold, light, medium, regular, thin]
  }
  public static let allCustomFonts: [SMUPFontConvertible] = [NotoSansKR.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct SMUPFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension SMUPFontConvertible.Font {
  convenience init?(font: SMUPFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
// swiftlint:enable all
// swiftformat:enable all
