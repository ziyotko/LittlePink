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
//        if let vc = viewController as? PostVC {
        if viewController is PostVC {
            var config = YPImagePickerConfiguration()
            //MARK: 基本设置
            config.isScrollToChangeModesEnabled = false //取消滑动切换,防止编辑相册图片时的收视冲突
            config.onlySquareImagesFromCamera = false //是否只让拍摄正方形图片
            config.albumName = Bundle.main.appName //存图片进相册App的'我的相册'里的文件夹名称
            config.startOnScreen = YPPickerScreen.library //一打开就展示相册
            config.screens = [.library, .photo,.video] //一次展示相册,拍视频,拍照页面
            config.maxCameraZoomFactor = kMaxCameraZoomFactor //最大变焦倍数
            
            //MARK: 相册设置
            config.library.defaultMultipleSelection = true //是否可多选
            config.library.maxNumberOfItems = kMaxPhotoCount //最大选取照片或视频数
            config.library.spacingBetweenItems = kSpacingBetweenItems //照片缩略图之间的间距
            
            //MARK: 视频设置(参照文档,此处全部默认)
            
            
            //MARK: - Gallery(多选完后的展示和编辑页面)画廊
            config.gallery.hidesRemoveButton = false //每个照片或视频右上方是否有删除按钮
            
             
            // [Edit configuration here ...]
            // Build a picker with your configuration
            let picker = YPImagePicker(configuration: config)
            
            //MARK: 选完或按取消按钮后的异步回调处理(依据配置处理单个或多个)
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
