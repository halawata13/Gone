import UIKit

extension UIViewController {
    /// クラス名と同名の Identifier が付けられている UIViewController を返す
    func instantiateFromStoryboard<Element: UIViewController>(viewController: Element.Type) -> Element? {
        return storyboard?.instantiateViewController(withIdentifier: String(describing: viewController)) as? Element
    }
}
