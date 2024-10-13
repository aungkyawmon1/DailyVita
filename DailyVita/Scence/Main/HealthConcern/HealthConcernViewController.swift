//
//  HealthConcerViewController.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import Combine

class HealthConcernViewController: BaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var collectionViewHealthConcern: UICollectionView!
    @IBOutlet weak var tableViewHealthConcern: UITableView!
    @IBOutlet weak var collectionViewheight: NSLayoutConstraint!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    
    private var subscriptions = Set<AnyCancellable>()
    
    let viewModel: HealthConcernViewModel
    
    init(viewModel: HealthConcernViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        setupCollectionView()
        
        setupTableView()
        
        listenData()
    }
    
    
    func setupUI() {
        
        btnNext.layer.cornerRadius = 10
        btnNext.addTarget(viewModel, action: #selector(HealthConcernViewModel.onTapNext), for: .touchUpInside)
        
        btnBack.addTarget(viewModel, action: #selector(HealthConcernViewModel.onTapBack), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        collectionViewHealthConcern.registerForCells(cells: HealthConcernCVCell.self)
        collectionViewHealthConcern.delegate = self
        collectionViewHealthConcern.dataSource = self
        collectionViewHealthConcern.isScrollEnabled = false
        collectionViewHealthConcern.allowsMultipleSelection = true
        let ansLayout = UICollectionViewLeftLayout()
        ansLayout.spacing = 10.0
        collectionViewHealthConcern.collectionViewLayout = ansLayout
    }
    
    func setupTableView() {
        tableViewHealthConcern.registerForCells(cells: HealthConcernTVCell.self)
        tableViewHealthConcern.delegate = self
        tableViewHealthConcern.dataSource = self
        tableViewHealthConcern.dragDelegate = self
        tableViewHealthConcern.dropDelegate = self
        tableViewHealthConcern.dragInteractionEnabled = true // Enable drag-and-drop
        tableViewHealthConcern.isScrollEnabled = false // Disable table view scrolling to manage height in scroll view
    }
    
    private func listenData() {
        viewModel.$buttonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.btnNext.isEnabled = isEnabled
            }
            .store(in: &subscriptions)
        
        
        viewModel
            .$healthConcernData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionViewHealthConcern.reloadData()
                self?.adjustCollectionViewHeight()
            }.store(in: &subscriptions)
    
        
        viewModel
            .$selectedHealthConcernData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                print("Updated data: ")// Debugging step
                self?.tableViewHealthConcern.reloadData()
                self?.adjustTableViewHeight()
            }.store(in: &subscriptions)
        
    }
    
    // Adjust the collection view height based on content size
    func adjustCollectionViewHeight() {
        collectionViewHealthConcern.layoutIfNeeded()
        let contentHeight = collectionViewHealthConcern.collectionViewLayout.collectionViewContentSize.height
        collectionViewheight.constant = contentHeight
        collectionViewHealthConcern.reloadData()
        
    }
    
    // Adjust the table view height based on content size
    func adjustTableViewHeight() {
        tableViewHealthConcern.layoutIfNeeded()
        let contentHeight = tableViewHealthConcern.contentSize.height
        tableViewheight.constant = contentHeight
        tableViewHealthConcern.reloadData()
    }
}

extension HealthConcernViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.healthConcernData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseCell(type: HealthConcernCVCell.self, indexPath: indexPath)
        cell.lblHealthConcern.text = viewModel.healthConcernData[indexPath.item].name
        cell.isSelectedItem(viewModel.isSelectedValue(at: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.selectedHealthConcernData.count < 5 && !viewModel.isSelectedValue(at: indexPath.item) {
            viewModel.addHealthConcern(at: indexPath.item)
        } else { // DidDeselcted Cell
            viewModel.removeSelectedHealthConcern(at: indexPath.item)
        }
        
        collectionViewHealthConcern.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the size that fits the label's text
        let labelWidth = calculateTextWidth(text: viewModel.healthConcernData[indexPath.item].name, font: UIFont.systemFont(ofSize: 17))
        
        let width = (labelWidth + 20.0)
        return CGSize(width: Int(width), height: 50)
    }
    
    func calculateTextWidth(text: String, font: UIFont) -> CGFloat {
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        return size.width
    }
    
}


extension HealthConcernViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.selectedHealthConcernData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: HealthConcernTVCell.self, indexPath: indexPath)
        cell.lblTitle.text = viewModel.selectedHealthConcernData[indexPath.item].name
        return cell
    }
    
    // MARK: - Drag Delegate Methods
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        debugPrint("Perform drag")
        let healthConcern = viewModel.selectedHealthConcernData[indexPath.row]
        let itemProvider = NSItemProvider(object: healthConcern.name as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = healthConcern // Store the object locally
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.localDragSession != nil // Only allow dragging within the app
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    // MARK: - Drop Delegate Methods
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        debugPrint("Perform drop")
        tableView.performBatchUpdates({
            for item in coordinator.items {
                if let sourceIndexPath = item.sourceIndexPath {
                    let moveHealthConcern = viewModel.selectedHealthConcernData[sourceIndexPath.row]
                    viewModel.removeSelectedHealthConcernBeforeInsert(at: sourceIndexPath.row)
                    viewModel.insertSelectedHealthConcern(at: destinationIndexPath.row, value: moveHealthConcern)
                    //                    dataSource.insert(healthConcern, at: destinationIndexPath.row)
                    //
                    // Update priority
                    viewModel.updatePriorityForHealthConcerns()
                    
                    tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
                }
            }
        }, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let previewParameters = UIDragPreviewParameters()
        previewParameters.visiblePath = UIBezierPath(roundedRect: tableView.cellForRow(at: indexPath)?.bounds ?? .zero, cornerRadius: 8)
        return previewParameters
    }
    
}

