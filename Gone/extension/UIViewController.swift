import UIKit

extension UIViewController {
    ///
    /// クラス名と同名の Identifier が付けられている UIViewController を返す
    ///
    func instantiateFromStoryboard<T: UIViewController>(viewController: T.Type) -> T? {
        return storyboard?.instantiateViewController(withIdentifier: String(describing: viewController)) as? T
    }
}
