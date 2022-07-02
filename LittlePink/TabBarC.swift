//
//  TabBarC.swift
//  LittlePink
//
//  Created by 支天白 on 2022/7/1.
//

import UIKit
import YPImagePicker

class TabBarC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    


    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let vc = viewController as? PostVC {
            var config = YPImagePickerConfiguration()
            //MARK: 基本设置
            config.isScrollToChangeModesEnabled = false
            config.onlySquareImagesFromCamera = false
            config.albumName = Bundle.main.appName
            config.startOnScreen = YPPickerScreen.library
            config.screens = [.library, .photo,.video]
            config.maxCameraZoomFactor = 5.0
            
            //MARK: 相册设置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.spacingBetweenItems = 2.0
            
            //MARK: 视频设置(参照文档,此处全部默认)
            
            
            //MARK: - Gallery(多选完后的展示和编辑页面)画廊
            config.gallery.hidesRemoveButton = false
            
             
            // [Edit configuration here ...]
            // Build a picker with your configuration
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    print(photo.fromCamera) // Image source (camera or library)
                    print(photo.image) // Final image selected by the user
                    print(photo.originalImage) // original image selected by the user, unfiltered
//                    print(photo.modifiedImage) // Transformed image, can be nil
//                    print(photo.exifMeta) // Print exif meta data of original image.
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            return false
        }
        return true
    }
}
