//
//  AllergeyViewController.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import Combine

class AllergeyViewController: BaseViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableViewAllergey: UITableView!
    @IBOutlet weak var collectionViewAllergey: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionViewWidth: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    private var subscriptions = Set<AnyCancellable>()
    let viewModel: AllergeyViewModel
    
    init(viewModel: AllergeyViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupTableView()
        
        setupCollectionView()
        
        listenData()
    }
    
    func setupUI() {
        textField.delegate = self
        
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.clipsToBounds = true
        
        btnNext.layer.cornerRadius = 10
        btnNext.addTarget(viewModel, action: #selector(HealthConcernViewModel.onTapNext), for: .touchUpInside)
        
        btnBack.addTarget(viewModel, action: #selector(HealthConcernViewModel.onTapBack), for: .touchUpInside)
    }
    
    func setupTableView() {
        tableViewAllergey.registerForCells(cells: AllergeyFilterItemTVCell.self)
        tableViewAllergey.delegate = self
        tableViewAllergey.dataSource = self
        tableViewAllergey.isHidden = true
    }
    
    func setupCollectionView() {
        collectionViewAllergey.registerForCells(cells: AllergeyItemCVCell.self)
        collectionViewAllergey.delegate = self
        collectionViewAllergey.dataSource = self
        collectionViewAllergey.isScrollEnabled = false
    }
    
    private func listenData() {
        
        
        viewModel
            .$filteredItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableViewAllergey.reloadData()
                self?.showHideTableView()
            }.store(in: &subscriptions)
        
        viewModel
            .$selectedItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionViewAllergey.reloadData()
                self?.adjustCollectionViewWidth()
            }.store(in: &subscriptions)
        
    }
    
    //Show Hide
    func showHideTableView() {
        tableViewAllergey.isHidden = viewModel.filteredItems.isEmpty
    }
    
    // Adjust the collection view height based on content size
    func adjustCollectionViewWidth() {
        collectionViewAllergey.layoutIfNeeded()
        let contentHeight = collectionViewAllergey.collectionViewLayout.collectionViewContentSize.width
        collectionViewWidth.constant = contentHeight
        collectionViewAllergey.reloadData()
        //scrollToRight()
    }
    
    
}

extension AllergeyViewController: UITextFieldDelegate {
    // Handle text input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        viewModel.filterContentForSearchText(currentText)
        return true
    }
    
    // UITextFieldDelegate method to handle "Done" button press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // This will hide the keyboard
        return true
    }
}

extension AllergeyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: AllergeyFilterItemTVCell.self, indexPath: indexPath)
        cell.allergyVO = viewModel.filteredItems[indexPath.row]
        return cell
    }
    
    // Handle autocomplete item selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.selectedAllergey(at: indexPath.row)
        textField.text = ""
        textField.resignFirstResponder() // Hide the keyboard
        
        // Scroll to the right after a tag is added
        if self.view.frame.width - 40 < collectionViewWidth.constant + 200 + 12 {
            DispatchQueue.main.async {
                self.scrollToRight()
            }
        }
        
    }
    
    // Function to scroll the scrollView to the right when a new tag is added
    func scrollToRight() {
        let rightOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(rightOffset, animated: true)
    }
}

extension AllergeyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.selectedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseCell(type: AllergeyItemCVCell.self, indexPath: indexPath)
        cell.allegeyData = viewModel.selectedItems[indexPath.row]
        cell.selectedItemAt = indexPath.row
        cell.tapDeleteItem = { [weak self] item in
            guard let self else { return }
            self.viewModel.removeSelectedAllergey(at: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        // Calculate the size that fits the label's text
        let labelWidth = calculateTextWidth(text: viewModel.selectedItems[indexPath.item].name, font: UIFont.systemFont(ofSize: 17))
        
        let width = (labelWidth + 20.0)
        return CGSize(width: Int(width), height: 50)
    }
    
    func calculateTextWidth(text: String, font: UIFont) -> CGFloat {
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        return size.width
    }
    
}
