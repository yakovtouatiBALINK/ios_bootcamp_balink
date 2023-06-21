//
//  CustemView.swift
//  to du list
//
//  Created by yacov touati on 21/06/2023.
//

import UIKit

enum FieldType {
    case Title
}

class CustemView: UIView {
    var type: FieldType = .Title
    
    private let titleTask: UILabel = UILabel()
    init(frame: CGRect, type: FieldType) {
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDocer: NSCoder) {
        super.init(coder: aDocer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.type = self.titleTask
    }
}
