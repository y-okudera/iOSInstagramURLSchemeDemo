//
//  ViewController.swift
//  iOSInstagramURLSchemeDemo
//
//  Created by Yuki Okudera on 2019/09/12.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Photos
import UIKit

final class ViewController: UIViewController {
    
    private var imagePickerController: UIImagePickerController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupImagePiccker()
    }
    
    private func setupImagePiccker() {
        PHPhotoLibrary.requestAuthorization { _ in }
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.sourceType = .photoLibrary
        present(imagePickerController!, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let linkURL = info[.phAsset] as? PHAsset else {
            print("info[.phAsset] is nil.")
            picker.dismiss(animated: false, completion: nil)
            return
        }
        
        guard let instagramURL = URL(string: "instagram://library?LocalIdentifier=\(linkURL.localIdentifier)") else {
            print("instagram url is nil.")
            picker.dismiss(animated: false, completion: nil)
            return
        }
        
        picker.dismiss(animated: true, completion: {
            if UIApplication.shared.canOpenURL(instagramURL) {
                UIApplication.shared.open(instagramURL)
            }
        })
    }
}

extension ViewController: UINavigationControllerDelegate {}
