//
//  DietViewController.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import Combine

class DietViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var collectionViewDiet: UICollectionView!
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: DietViewModel
    
    init(viewModel: DietViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupCollectionView()
        
        listenData()
    }
    
    func setupUI() {
        
        btnNext.layer.cornerRadius = 10
        btnNext.addTarget(viewModel, action: #selector(HealthConcernViewModel.onTapNext), for: .touchUpInside)
        
        btnBack.addTarget(viewModel, action: #selector(HealthConcernViewModel.onTapBack), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        collectionViewDiet.registerForCells(cells: DietCVCell.self)
        collectionViewDiet.delegate = self
        collectionViewDiet.dataSource = self
        // Enable multiple selection
        collectionViewDiet.allowsMultipleSelection = true
    }
    
    private func listenData() {
        
        viewModel.$buttonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.btnNext.isEnabled = isEnabled
            }
            .store(in: &subscriptions)
        
        viewModel
            .$dietData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionViewDiet.reloadData()
            }.store(in: &subscriptions)
        
    }

}


extension DietViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dietData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseCell(type: DietCVCell.self, indexPath: indexPath)
        cell.setupData(name: viewModel.dietData[indexPath.item].name, isChecked: viewModel.isSelectedItem(at: indexPath.item) , isNone: indexPath.item != 0 )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            viewModel.removeAllSelectedItems()
        } else if !viewModel.isSelectedItem(at: indexPath.item) {
            viewModel.selectItem(at: indexPath.item)
        } else {
            viewModel.deselectItem(at: indexPath.item)
        }
        collectionViewDiet.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 40
        return CGSize(width: width, height: 50)
    }
    
    func calculateTextWidth(text: String, font: UIFont) -> CGFloat {
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        return size.width
    }
    
}
