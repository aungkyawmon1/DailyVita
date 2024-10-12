//
//  UICollectionViewExtension.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

extension UICollectionView {
    func registerForCells<T>(cells : T...) {
        cells.forEach { (cell) in
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellWithReuseIdentifier: String(describing: cell))
        }
    }
    
    func registerForCells<T>(cells : [T]) {
        cells.forEach { (cell) in
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellWithReuseIdentifier: String(describing: cell))
        }
    }
    
    func dequeReuseCell<T>(type : T.Type, indexPath : IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}
