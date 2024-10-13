//
//  DailyRoutineViewController.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import Combine

class DailyRoutineViewController: BaseViewController {
    
    @IBOutlet weak var btnGetPersonlizedVitamin: UIButton!
    @IBOutlet weak var tableViewQuestion: UITableView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    let viewModel: DailyRoutineViewModel
    
    init(viewModel: DailyRoutineViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupTableView()
        
        listenData()
    }

    func setupUI() {
        btnGetPersonlizedVitamin.layer.cornerRadius = 10
        btnGetPersonlizedVitamin.addTarget(viewModel, action: #selector(DailyRoutineViewModel.onTapGetPersonalizedVitamin), for: .touchUpInside)
    }
    
    func setupTableView() {
        tableViewQuestion.registerForCells(cells: DailyRoutineTVCell.self)
        tableViewQuestion.delegate = self
        tableViewQuestion.dataSource = self
    }
    
    func listenData() {
        viewModel.$buttonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.btnGetPersonlizedVitamin.isEnabled = isEnabled
            }
            .store(in: &subscriptions)
    }
}

extension DailyRoutineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questions[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: DailyRoutineTVCell.self, indexPath: indexPath)
        let name = viewModel.questions[indexPath.section].options[indexPath.row]
        if let selectedIndex = viewModel.questions[indexPath.section].selectedIndex {
            cell.setupData(name: name, isSelected: selectedIndex == indexPath.row )
        } else {
            cell.setupData(name: name, isSelected: false)
        }
        return cell
    }
    
    // Handle option selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectQuestion(at: indexPath.section, selectedIndex: indexPath.row)
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
    
    // Set the header as the question title
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create a UIView for the header
        let headerView = DailyRoutineHeaderView()
        headerView.setupData(name: viewModel.questions[section].title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = viewModel.questions[section].title
        let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        let width = tableView.frame.width - 40
        let height = title.height(withConstrainedWidth: width, font: font)
        let topMargin: CGFloat = section == 0 ? 48.0 : 0.0
        return height + topMargin
    }
}
