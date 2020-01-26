import UIKit

// MARK: - NavigationBar Configuration
extension UIViewController {
    public func configureNavBar(with title: String, prefersLargeTitle: Bool = true) {
        navigationItem.title = title
        if #available(iOS 11.0, *) {
            if prefersLargeTitle {
                navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle
            } else {
                navigationItem.largeTitleDisplayMode = .never
            }
        }
    }
}

extension UINavigationBar {
    public func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        
        if #available(iOS 13.0, *) {
            let appereance = UINavigationBarAppearance()
            appereance.configureWithTransparentBackground()
            self.standardAppearance = appereance
            self.scrollEdgeAppearance = appereance
            self.compactAppearance = appereance
        }
    }
}

extension UIStackView {
    static public func create(arrangedSubViews: [UIView] = [],
                       axis: NSLayoutConstraint.Axis = .vertical,
                       alignment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       spacing: CGFloat = .leastNormalMagnitude) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
}

extension UIButton {
    static public func create(numberOfLines: Int = 0,
                       horizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
                       verticalAlignment: UIControl.ContentVerticalAlignment = .center,
                       backgroundColor: UIColor = .clear,
                       backgroundImage: UIImage? = nil,
                       image: UIImage? = nil,
                       title: String = "",
                       titleColor: UIColor = .white,
                       font: UIFont = .boldSystemFont(ofSize: 17.0)) -> UIButton {
        
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = backgroundColor
        button.contentHorizontalAlignment = horizontalAlignment
        button.contentVerticalAlignment = verticalAlignment
        button.setTitleColor(titleColor, for: .normal)
        button.setBackgroundImage(backgroundImage, for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = font
        button.setTitle(title, for: .normal)
        return button
    }
}

extension UILabel {
    static public func create(text: String = "",
                       numberOfLines: Int = 0,
                       textAlignment: NSTextAlignment = .center,
                       textColor: UIColor = .black,
                       font: UIFont) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.font = font
        return label
    }
}

extension UITextField {
    static public func create(font: UIFont = .boldSystemFont(ofSize: 17.0),
                       placeholder: String = "",
                       placeholderColor: UIColor = .lightGray,
                       textColor: UIColor = .white,
                       tintColor: UIColor = .black,
                       backgroundColor: UIColor = .clear,
                       borderStyle: UITextField.BorderStyle = .none,
                       textAlignment: NSTextAlignment = .left,
                       returnKeyType: UIReturnKeyType = .default) -> UITextField {
        
        let textField = UITextField()
        textField.font = font
        textField.placeholder = placeholder
        textField.textColor = textColor
        textField.tintColor = tintColor
        let attributes = [NSAttributedString.Key.foregroundColor: placeholderColor]
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.backgroundColor = backgroundColor
        textField.borderStyle = borderStyle
        textField.textAlignment = textAlignment
        textField.returnKeyType = returnKeyType
        return textField
    }
}

extension UIApplication {
    public class var mainWindow: UIWindow {
        return self.shared.keyWindow ?? UIWindow()
    }
}

extension Sequence where Element: AdditiveArithmetic {
    public func sum() -> Element {
        return reduce(.zero, +)
    }
}

extension Double {
    public var shortStringRepresentation: String {
        if self == 0 {
            return "0"
        }

        if self.isNaN {
            return "NaN"
        }
        if self.isInfinite {
            return "\(self < 0.0 ? "-" : "+")Infinity"
        }
        let units = ["", "k", "M"]
        var interval = self
        var i = 0
        while i < units.count - 1 {
            if interval < 1000.0 {
                break
            }
            i += 1
            interval /= 1000.0
        }
        // + 2 to have one digit after the comma, + 1 to not have any.
        // Remove the * and the number of digits argument to display all the digits after the comma.
        return "\(String(format: "%0.*g", Int(log10(interval)) + 2, interval))\(units[i])"
    }
}

extension Array {
    public func at(index: Int) -> Element? {
        if index < 0 || index > self.count - 1 {
            return nil
        }
        return self[index]
    }
}

extension UILabel {
    public func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

extension UIDevice {
    static public let isRunningOnIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
}

extension String {
    public func replacingLastOccurrenceOfString(_ searchString: String,
                                         with replacementString: String,
                                         caseInsensitive: Bool = true) -> String {
        let options: String.CompareOptions
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }
        
        if let range = self.range(of: searchString,
                                  options: options,
                                  range: nil,
                                  locale: nil) {
            
            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
    }
    
    public func replaceFirstOccurance(target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}

public class PaddingLabel: UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }
        
        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0
        
        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }
        
        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 16, weight: .regular)], context: nil)
        
        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth
        
        return contentSize
    }
    
}
