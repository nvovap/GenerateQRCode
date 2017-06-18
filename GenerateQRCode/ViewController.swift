//
//  ViewController.swift
//  GenerateQRCode
//
//  Created by Владимир Невинный on 18.06.17.
//  Copyright © 2017 Владимир Невинный. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var detectionQRCode: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tap = UITapGestureRecognizer(target: self, action:  #selector(self.tapHandle) )
        
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue) {
        guard let vc = segue.source as? DetectionQRCodeViewController else {
            return
        }
        
        detectionQRCode.text = vc.QRCodeForReturn
    }
    
    func tapHandle() {
        textField.resignFirstResponder()
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if let image = generateQRCode(from: text) {
                imageView.image = image
            }
        }
    }
    
}

