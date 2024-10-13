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
    
    // MARK: Show Tooltip
    func showTooltip(at sourceView: UIView, index: Int) {
        // Create a tooltip label
        let tooltipLabel = UILabel()
        tooltipLabel.text = viewModel.dietData[index].tool_tip
        tooltipLabel.backgroundColor = .white
        tooltipLabel.textColor = .gray
        tooltipLabel.font = UIFont.systemFont(ofSize: 14)
        tooltipLabel.numberOfLines = 0
        tooltipLabel.textAlignment = .center
        tooltipLabel.layer.cornerRadius = 8
        tooltipLabel.layer.masksToBounds = true
        
        // Set tooltip dimensions
        let tooltipWidth: CGFloat = 200
        let tooltipHeight: CGFloat = calculateHeightForText(viewModel.dietData[index].tool_tip, font:  UIFont.systemFont(ofSize: 14), width: 200) + 30
        
        // Convert the frame of sourceView to the main view's coordinate space
        if let superview = sourceView.superview {
            let convertedFrame = superview.convert(sourceView.frame, to: self.view)
            
            // Calculate the tooltip's frame (positioned above the icon button)
            let tooltipX = convertedFrame.midX - tooltipWidth / 2
            let tooltipY = convertedFrame.minY - tooltipHeight - 10
            let tooltipFrame = CGRect(x: tooltipX, y: tooltipY, width: tooltipWidth, height: tooltipHeight)
            
            tooltipLabel.frame = tooltipFrame
            tooltipLabel.alpha = 0.0
            
            // Add the tooltip to the view controller's view
            self.view.addSubview(tooltipLabel)
            
            // Animate the tooltip appearance
            UIView.animate(withDuration: 0.3) {
                tooltipLabel.alpha = 1.0
            }
            
            // Auto-hide the tooltip after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                UIView.animate(withDuration: 0.3, animations: {
                    tooltipLabel.alpha = 0.0
                }) { _ in
                    tooltipLabel.removeFromSuperview()
                }
            }
        }
    }
    
    func calculateHeightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }

}


extension DietViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dietData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseCell(type: DietCVCell.self, indexPath: indexPath)
        cell.setupData(name: viewModel.dietData[indexPath.item].name, isChecked: viewModel.isSelectedItem(at: indexPath.item) , isNone: indexPath.item != 0 )
        // Handle icon tap and show tooltip
        cell.didTapInfo = { [weak self] in
            guard let strongSelf = self else { return }
            debugPrint("Tap info")
            strongSelf.showTooltip(at: cell.ivInfo, index: indexPath.item)
        }
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
