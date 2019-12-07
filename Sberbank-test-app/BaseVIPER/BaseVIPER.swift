//
//  WireframeInterface.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import UIKit

protocol WireframeInterface: class {
}

class BaseWireframe {

    private unowned var _viewController: UIViewController

    init(viewController: UIViewController) {
        _viewController = viewController
    }

}

extension BaseWireframe: WireframeInterface {
    
}

extension BaseWireframe {
    
    var viewController: UIViewController {
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

extension UIViewController {
    
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

extension UINavigationController {
    
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
    
}

protocol FormatterInterface: class {
}

extension FormatterInterface {
}

protocol PresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

extension PresenterInterface {
    func viewDidLoad() {
        fatalError("Implementation pending...")
    }
    func viewWillAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    func viewDidAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    func viewWillDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    func viewDidDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }
}

protocol ViewInterface: class {
}

extension ViewInterface {
}

protocol InteractorInterface: class {
}

extension InteractorInterface {
}
