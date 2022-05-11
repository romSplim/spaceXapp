//
//  StretchyHeader.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 01.04.2022.
//


import UIKit

final class StretchyHeader: UIView {
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let blackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .black
        return view
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        imageView.addSubview(blackView)
    }
    
    func setViewConstraints() {
        
        blackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([widthAnchor.constraint(equalTo: containerView.widthAnchor),
                                     centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     heightAnchor.constraint(equalTo: containerView.heightAnchor),
                                     blackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: -1),
                                     blackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 1),
                                     blackView.heightAnchor.constraint(equalToConstant: 40),
                                     blackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
        
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
//        print(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    
    
    
    
}
