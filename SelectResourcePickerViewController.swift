//
/**
 * @file      SelectResourcePickerViewController.swift
 * @brief
 * @details
 * @see
 * @author    Shrinivas Uttamrao Gutte, shrinivasgutte@elear.solutions
 * @copyright Copyright (c) 2019 Elear Solutions Tech Private Limited.
 *            All rights reserved.
 * @license   To any person (the "Recipient") obtaining a copy of this software
 *            and associated documentation files (the "Software"):
 *            All information contained in or disclosed by this software is
 *            confidential and proprietary information of Elear Solutions Tech
 *            Private Limited and all rights therein are expressly reserved.
 *            By accepting this material the recipient agrees that this material
 *            and the information contained therein is held in confidence and
 *            in trust and will NOT be used, copied, modified, merged,
 *            published, distributed, sublicensed, reproduced in whole or
 *            in part, nor its contents revealed in any manner to others
 *            without the express written permission of Elear Solutions Tech
 *            Private Limited.
 */

import UIKit

protocol SendResource: class {
    func sendResource(_ obj: ResourceModal)
}

class SelectResourcePickerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var resourceArray = [ResourceModal]()
    weak var delegate: SendResource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let obj = ResourceModal(resourceName: "Light", resourceImage: #imageLiteral(resourceName: "picker_light"), resourceImageUrl: nil)
        let obj1 = ResourceModal(resourceName: "TV", resourceImage: #imageLiteral(resourceName: "picker_tv"), resourceImageUrl: nil)
        let obj2 = ResourceModal(resourceName: "AC", resourceImage: #imageLiteral(resourceName: "picker_ac"), resourceImageUrl: nil)
        let obj3 = ResourceModal(resourceName: "Door Bell", resourceImage: #imageLiteral(resourceName: "picker_door"), resourceImageUrl: nil)
        
        let obj4 = ResourceModal(resourceName: "Sensor", resourceImage: #imageLiteral(resourceName: "picker_sensor"), resourceImageUrl: nil)
        let obj5 = ResourceModal(resourceName: "Window", resourceImage: #imageLiteral(resourceName: "picker_window"), resourceImageUrl: nil)
        let obj6 = ResourceModal(resourceName: "Door Lock", resourceImage: #imageLiteral(resourceName: "picker_lock"), resourceImageUrl: nil)
        let obj7 = ResourceModal(resourceName: "Intercom", resourceImage: #imageLiteral(resourceName: "picker_intercom"), resourceImageUrl: nil)
        
        resourceArray.append(obj)
        resourceArray.append(obj1)
        resourceArray.append(obj2)
        resourceArray.append(obj3)
        
        resourceArray.append(obj4)
        resourceArray.append(obj5)
        resourceArray.append(obj6)
        resourceArray.append(obj7)
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    @IBAction func crossButtonAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
}


extension SelectResourcePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectResourceCollectionViewCell", for: indexPath) as? SelectResourceCollectionViewCell else {
            fatalError("could not load TopCompanyContainerCollectionCell")
        }
        
        cell.resourceImageView.image = resourceArray[indexPath.row].resourceImage
        cell.resourceNameLabel.text = resourceArray[indexPath.row].resourceName
        cell.imageContentView.layer.cornerRadius = cell.imageContentView.frame.height / 2
        cell.imageContentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.imageContentView.layer.borderWidth = 1.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let obj = resourceArray[indexPath.row] as? ResourceModal {
            delegate?.sendResource(obj)
            presentingViewController?.dismiss(animated: true)
        }
    }
}
