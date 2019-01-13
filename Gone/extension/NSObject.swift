import Foundation

extension NSObject {
    ///
    /// クラス名を返す
    ///
    static var className: String {
        return String(describing: self)
    }
}
