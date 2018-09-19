//
//  LoadableViewProtocol.swift
//  Meuhedet
//
//  Created by Sergey Krasiuk on 08/03/2018.
//  Copyright © 2018 Sergey Krasiuk. All rights reserved.
//

import UIKit

protocol LoadableView {
    
    func showLoadingView()
    func hideLoadingView()
}

extension LoadableView where Self: UIViewController {
    
    func showLoadingView() {
        IDLoader.show()
    }
    
    func hideLoadingView() {
        IDLoader.hide()
    }
}
