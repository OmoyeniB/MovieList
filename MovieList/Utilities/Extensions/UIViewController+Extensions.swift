//
//  UIViewController+Extensions.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String, type: LogType, action: ParameterHandler?) {
        var title = title
        switch type {
        case .success:
            title = "🟢🟢🟢   " + title + "   🟢🟢🟢"
        case .error:
            title = "🛑🛑🛑   " + title + "   🛑🛑🛑"
        case .info:
            title = "🟡🟡🟡   " + title + "   🟡🟡🟡"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in action?() }))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alert, animated: true)
        }
    }
}
