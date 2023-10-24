//
//  ParentFormViewController.swift
//  DailyVita
//
//  Created by solinx on 24/10/2023.
//

import UIKit

class ParentFormViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    private var pageView: UIPageViewController?
    
    private var pages: [UIViewController] = []
    
    private var direction: UIPageViewController.NavigationDirection = .forward
    
    private var currentPage: Int? {
        didSet {
            pageDidChange()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPages()
    }
    
    private func setupPages() {
        
        let pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageView.dataSource = self
        pageView.delegate = self
        pageView.isDoubleSided = false
        pageView.view.frame = self.viewContainer.bounds
        pageView.didMove(toParent: self)
        self.pageView = pageView
        self.addChild(pageView)
        self.viewContainer.insertSubview(pageView.view, at: 0)
        
        
        let formOne = FormOneViewController()
        
        
        let formTwo = FormTwoViewController()
        
        let formThree = FormThreeViewController()
        
        let formFour = FormFourViewController()
        
        pages = [formOne, formTwo, formThree, formFour]
        
        currentPage = 1
        
    }
    
    private func pageDidChange() {
        if let step = currentPage {
            
            pageView?.setViewControllers([pages[step-1]], direction: direction, animated: true)
        }
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        currentPage = currentPage ?? 0 - 1
    }
    
    @IBAction func btnConfirm(_ sender: UIButton) {
        currentPage = currentPage ?? 0 + 1
    }

}

extension ParentFormViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController) ?? 0
        if currentIndex >= pages.count - 1 {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentIndex = pageViewController.viewControllers!.first!.view.tag
        currentPage = currentIndex + 1
    }
}
