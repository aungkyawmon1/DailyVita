//
//  UITableViewExtension.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

extension UITableView {
    func registerForCells<T>(cells : T...) {
        cells.forEach { (cell) in
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        }
    }
    
    func registerForCells<T>(cells : [T]) {
        cells.forEach { (cell) in
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        }
    }
    
    func dequeReuseCell<T>(type : T.Type, indexPath : IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
}
