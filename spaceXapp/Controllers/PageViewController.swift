//
//  PageViewController.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 14.04.2022.
//

import UIKit

class PageViewController: UIPageViewController {

    //MARK: - Private Properties
    private var pages = [UIViewController]()
    private let pageControl = UIPageControl()
    private let initialPage = 0
    
    private var pageControlBottomAnchor: NSLayoutConstraint?
    var source: [RocketElement]?
    
    //MARK: - Override Methods
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
           super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkService.shared.getRequest { [weak self] data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self?.source = data.shuffled()
                    self?.setup(data: self!.source!)
                    self?.style()
                    self?.layout()
                }
                
            }
        }
    }

    //MARK: - Private Methods
    private func setup(data: [RocketElement]) {
        dataSource = self
        delegate = self
//        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        
        for currentData in 0..<source!.count {
            pages.append(ViewController(data: (source?[currentData])!))

        }
        
//        let page1 = ViewController()
//        let page2 = ViewController()
//        let page3 = ViewController()
//        let page4 = ViewController()
//
//        pages.append(page1)
//        pages.append(page2)
//        pages.append(page3)
//        pages.append(page4)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        
    }
    
    private func layout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
            
    
    private func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(named: "textColor")
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
    }
    
}

//MARK: - Data Source Methods
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
    
    
}

//MARK: - Delegate Methods
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
        
    }

    
}


