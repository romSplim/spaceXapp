//
//  SettingsViewController.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 07.04.2022.
//

import UIKit

protocol SegmentDelegate: AnyObject {
    func didSelectHeightSegment(_ selectedIndex: String)
    func didSelectDiametrSegment(_ selectedIndex: String)
    func didSelectMassSegment(_ selectedIndex: String)
    func didSelectPayloadSegment(_ selectedIndex: String)
}

class SettingsViewController: UIViewController {
   
    weak var delegate: SegmentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        addTargetsToSegment()
        setupRightBarButton()
        view.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
    }
    
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 40
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        [heightLbl,diameterLbl,massLbl,payloadLbl].forEach { lbl in
            lbl.textColor = .myColor
            stack.addArrangedSubview(lbl) }
        return stack
    }()
    
    lazy var segmentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 28
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        [heightSegment, diameterSegment, massSegment, payloadSegment].forEach {
            $0.selectedSegmentTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)]
            let titleAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.myLightGray]
            $0.setTitleTextAttributes(titleAttributes, for: .selected)
            $0.setTitleTextAttributes(titleAttributesNormal, for: .normal)
            stack.addArrangedSubview($0) }
        return stack
    }()

    
    
    func setupView() {
        title = "Настройки"
    }
    
    func setupRightBarButton() {
        let barButton = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(closeButtonTapped(sender:)))
        barButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func closeButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func addTargetsToSegment() {
        heightSegment.addTarget(self, action: #selector(segmentTapped(sender:)), for: .valueChanged)
        diameterSegment.addTarget(self, action: #selector(segmentTapped(sender:)), for: .valueChanged)
        massSegment.addTarget(self, action: #selector(segmentTapped(sender:)), for: .valueChanged)
        payloadSegment.addTarget(self, action: #selector(segmentTapped(sender:)), for: .valueChanged)
    }
    
    func setupConstraints() {
        view.addSubview(labelStackView)
        view.addSubview(segmentStackView)
        NSLayoutConstraint.activate([labelStackView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 20),
                                     labelStackView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 120),
                                     labelStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,constant: -90),
                                     labelStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -208),
                                     
                                     
                                     segmentStackView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 120),
                                     segmentStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,constant: -20),
                                     segmentStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -208),
                                     segmentStackView.centerYAnchor.constraint(equalTo: labelStackView.centerYAnchor)])
    }
    
    @objc func segmentTapped(sender: UISegmentedControl!) {
        guard let selectedIndex = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        switch sender {
        case heightSegment:
            self.delegate?.didSelectHeightSegment(selectedIndex)
        case diameterSegment:
            self.delegate?.didSelectDiametrSegment(selectedIndex)
        case massSegment:
            self.delegate?.didSelectMassSegment(selectedIndex)
        case payloadSegment:
            self.delegate?.didSelectPayloadSegment(selectedIndex)
        default:
            break
        }
    }
    
    
    let heightLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Высота"
        lbl.textAlignment = .left
        return lbl
    }()
    
    let diameterLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Диаметр"
        lbl.textAlignment = .left
        return lbl
    }()
    
    let massLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Масса"
        lbl.textAlignment = .left
        return lbl
    }()
    
    let payloadLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Полезная нагрузка"
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    let heightSegment: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["m","ft"])
        seg.selectedSegmentIndex = 0
        seg.setWidth(56, forSegmentAt: 0)
        seg.setWidth(56, forSegmentAt: 1)
        
        return seg
    }()
    
    let diameterSegment: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["m","ft"])
        seg.selectedSegmentIndex = 0
        seg.setWidth(56, forSegmentAt: 0)
        seg.setWidth(56, forSegmentAt: 1)
        return seg
    }()
    
    let massSegment: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["kg","lb"])
        seg.selectedSegmentIndex = 0
        seg.setWidth(56, forSegmentAt: 0)
        seg.setWidth(56, forSegmentAt: 1)
        return seg
    }()
    
    let payloadSegment: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["kg","lb"])
        seg.selectedSegmentIndex = 0
        seg.setWidth(56, forSegmentAt: 0)
        seg.setWidth(56, forSegmentAt: 1)
        return seg
    }()
}
