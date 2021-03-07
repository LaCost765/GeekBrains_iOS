//
//  ViewControllerExtensions.swift
//  ClientVK
//
//  Created by Egor on 08.03.2021.
//

import UIKit

extension UIViewController {
    func convertImageToData(named name: String) -> Data? {
        guard let image = UIImage(named: name) else {
            return nil
        }
        
        return image.pngData()
    }
}
