//
//  TaskCell.swift
//  ToDo
//
//  Created by Ahamed Muqthar M K on 13/03/17.
//  Copyright © 2017 Privin. All rights reserved.
//

import Foundation
import UIKit

protocol TaskCellDelegate {
    func stateChanged(cell : TaskCell)
}
class TaskCell: UITableViewCell {
    
    var delegate : TaskCellDelegate?
    let label : UILabel = {
       let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 20)
       label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkbox : UIButton = {
        let box = UIButton()
        box.clipsToBounds = true
        box.contentMode = .scaleAspectFit
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        addSubview(checkbox)
        addSubview(label)
        checkbox.anchors(topAnchor: self.topAnchor, bottomAnchor: self.bottomAnchor, leftAnchor: self.leftAnchor, rightAnchor: nil, topConstant: 4, bottomConstant: 4, leftConstant: 4, rightConstant: 0, width: 30, height: 0)
        label.anchors(topAnchor: self.topAnchor, bottomAnchor: self.bottomAnchor, leftAnchor: checkbox.leftAnchor, rightAnchor: self.rightAnchor, topConstant: 4, bottomConstant: 4, leftConstant: 34, rightConstant: 4, width: 0, height: 0)
        checkbox.addTarget(self, action: #selector(complete), for: .touchUpInside)
        
    }
    
    
    @objc func complete(){
        if let d = delegate {
            d.stateChanged(cell: self)
        }
    }

}


