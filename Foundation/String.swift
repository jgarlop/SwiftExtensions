import UIKit

// MARK: Conversions

extension String {
    /**
     Converts the string as html to a NSMutableAttributedString.

     - Returns: An attributed string from html.

     Usage:
     ```
     let attributedString = "<b>Hello World</b>".htmlToMutableAttributedString
     ```
     */
    var htmlToMutableAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSMutableAttributedString(
                data: data,
                options: [.documentType: NSMutableAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            return nil
        }
    }

    /**
     Creates a NSAttributedString with some parts in bold,  using the system font, ready to use in a label component.

     - Parameter boldStrings: Strings to format as bold inside the full string.
     - Parameter fullString: The whole string.
     - Parameter ofSize: Size of the font.
     - Returns: NSAttributedString with bold attribute in selected parts.

     Usage:
     ```
     let string = String.createBoldAttributedString(boldStrings: "World", fullString: "Hello World", ofSize: 14)
     ```
     */
    static func createBoldAttributedString(boldStrings: String..., fullString: String, ofSize size: Int) -> NSAttributedString {
        let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(size))]
        let attributedString = NSMutableAttributedString(string: fullString)
        boldStrings.forEach { boldString in
            let range = (fullString as NSString).range(of: boldString)
            attributedString.addAttributes(boldAttribute, range: range)
        }
        return attributedString
    }
}

// MARK: Validations

extension String {
    /**
     Checks if string is a valid email.

     - Note: Change regex expression as needed.
     - Returns: Boolean indicating whether the email is valid or not.

     Usage:
     ```
     let isValid: Bool = "user@domain.com".isValidEmail
     ```
     */
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

// MARK: Localization

extension String {
    /**
     Returns a string from the file specified in "tableName", otherwise, using default Localizable.

     Usage:
     ```
     let string = "hello_world".localized
     ```
     */
    public func localized(tableName: String = "Localizable") -> String {
        NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }

    /**
     Returns a formatted string from the Localizable.strings using the variables passed as arguments.

     - Parameter arguments: variables to format the string.

     Usage:
     ```
     let string = "Hello %@".localized("Name")
     ```
     */
    public func localized(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}
