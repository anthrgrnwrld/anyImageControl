//
//  ViewController.swift
//  AnyImageControl
//
//  Created by Masaki Horimoto on 2015/04/20.
//  Copyright (c) 2015年 Masaki Horimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //UIImageViewのOutlet (Outlet Collectionを使えば良かった...)
    @IBOutlet var image1st: UIImageView!
    @IBOutlet var image2nd: UIImageView!
    @IBOutlet var image3rd: UIImageView!
    @IBOutlet var image4th: UIImageView!
    @IBOutlet var image5th: UIImageView!
    @IBOutlet var image6th: UIImageView!
    
    var startImagePoint: CGPoint?       //タッチ開始時のImageの座標を保存するProperty
    var currentImagePoint: CGPoint?     //タッチ中のImageの座標を保存するProperty
    var startTouchPoint: CGPoint?       //タッチ開始時のタッチ座標を保存するProperty
    var isImageInsideArray: [Bool] =    //どのImage内部を触ったかを管理する配列 (いらなかったかも...)
    [
        false,
        false,
        false,
        false,
        false,
        false
    ]
    
    var initialImagePointArray: [CGPoint] =    //各Imageの初期座標を保存するProperty (やっつけ仕事)
    [
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 0)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //各Imageのタッチ操作を有効にする
        self.image1st.userInteractionEnabled = true
        self.image2nd.userInteractionEnabled = true
        self.image3rd.userInteractionEnabled = true
        self.image4th.userInteractionEnabled = true
        self.image5th.userInteractionEnabled = true
        self.image6th.userInteractionEnabled = true
 
        for (index, val) in enumerate(initialImagePointArray) {
            initialImagePointArray[index] = getImagePointTag(index + 1) //各Imageの初期座標を保存する
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let tag: Int = touch.view.tag
        startTouchPoint = touch.locationInView(self.view)   //タッチ座標(開始時)を取得
                                                            //ここで取得しておこなければダメ
                                                            //(1回目のタッチがImage以外だった場合にnilのままになるから)

        for (index, val) in enumerate(isImageInsideArray) {
            if tag == index + 1 {
                isImageInsideArray[index] = true            //タッチしているImageに対応するisImageInsideArrayをtrueにする
                startImagePoint = getImagePointTag(tag)     //Imageの座標(タッチ開始時)を取得
                bringImageToFrontTag(tag)                   //タッチしている画像を最前面に持ってくるメソッドを実行
                                                            //このメソッドをまともに動かすにはAutoLayoutをDisableにしないとダメ
                                                            //(subViewを再描画され元の位置に戻ってしまうから)
            } else {
                isImageInsideArray[index] = false           //タッチしていない画像に対応するisImageInsideArrayをfalseにする

            }
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let tag = touch.view.tag                                            //タッチしている箇所のtagを取得する
        let deltaX = touch.locationInView(self.view).x - startTouchPoint!.x //タッチの移動量を計算
        let deltaY = touch.locationInView(self.view).y - startTouchPoint!.y //タッチの移動量を計算
        
        for (index, val) in enumerate(isImageInsideArray) {
            if val {
                moveImagePointTag(tag, deltaX: deltaX, deltaY: deltaY)      //タッチの移動量から画像を動かすメソッドを実行
            } else {
                
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for (index, val) in enumerate(isImageInsideArray) {
            isImageInsideArray[index] = false       //タッチ操作完了時には全ての画像のisImageInsideArrayをfalseにする
        }
    }

    //引数のtagに対応したImageの座標を返すメソッド
    func getImagePointTag(tag: Int) -> CGPoint {
        switch tag {
        case 1:
            return image1st.center
        case 2:
            return image2nd.center
        case 3:
            return image3rd.center
        case 4:
            return image4th.center
        case 5:
            return image5th.center
        case 6:
            return image6th.center
        default:
            println("Error")
            return image1st.center
        }
    }
    
    //引数のtagに対応したImageを最前面に持ってくるメソッド
    func bringImageToFrontTag(tag: Int) {
        switch tag {
        case 1:
            self.view.bringSubviewToFront(image1st)
        case 2:
            self.view.bringSubviewToFront(image2nd)
        case 3:
            self.view.bringSubviewToFront(image3rd)
        case 4:
            self.view.bringSubviewToFront(image4th)
        case 5:
            self.view.bringSubviewToFront(image5th)
        case 6:
            self.view.bringSubviewToFront(image6th)
        default:
            println("Error")
        }
    }

    //引数のtagに対応したImageを引数の移動量の分だけ移動させるメソッド
    func moveImagePointTag(tag: Int, deltaX: CGFloat, deltaY: CGFloat) {
        switch tag {
        case 1:
            image1st.center.x = startImagePoint!.x + deltaX
            image1st.center.y = startImagePoint!.y + deltaY
        case 2:
            image2nd.center.x = startImagePoint!.x + deltaX
            image2nd.center.y = startImagePoint!.y + deltaY
        case 3:
            image3rd.center.x = startImagePoint!.x + deltaX
            image3rd.center.y = startImagePoint!.y + deltaY
        case 4:
            image4th.center.x = startImagePoint!.x + deltaX
            image4th.center.y = startImagePoint!.y + deltaY
        case 5:
            image5th.center.x = startImagePoint!.x + deltaX
            image5th.center.y = startImagePoint!.y + deltaY
        case 6:
            image6th.center.x = startImagePoint!.x + deltaX
            image6th.center.y = startImagePoint!.y + deltaY
        default:
            image1st.center.x = startImagePoint!.x + deltaX
            image1st.center.y = startImagePoint!.y + deltaY
            
        }
    }

    //Imageを初期位置に戻すメソッド
    @IBAction func pressInitButton(sender: AnyObject) {
        image1st.layer.position = initialImagePointArray[0]
        image2nd.layer.position = initialImagePointArray[1]
        image3rd.layer.position = initialImagePointArray[2]
        image4th.layer.position = initialImagePointArray[3]
        image5th.layer.position = initialImagePointArray[4]
        image6th.layer.position = initialImagePointArray[5]
    }
}

