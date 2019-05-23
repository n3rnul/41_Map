//
//  ViewController.swift
//  Map
//
//  Created by bar2 on 2019/01/21.
//  Copyright © 2019 Bar2. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

	@IBOutlet weak var mvMap: MKMapView!

	// キーボード[return]押下時
	@IBAction func pushKeyboardReturn(_ sender: AnyObject) {
		
	}
	
	// 地名検索
	@IBAction func searchPlace(_ sender: UITextField) {
		
		// ジオコーディング
		doGeocording(sender.text!)
	}
	
	// 地図タイプ 選択値変更
	@IBAction func changeMapStyle(_ sender: UISegmentedControl) {
		
		// 地図タイプ設定
		switch sender.selectedSegmentIndex {
		case 0:
			mvMap.mapType = .standard		// 標準
		case 1:
			mvMap.mapType = .satellite		// 航空写真
		case 2:
			mvMap.mapType = .hybrid			// ハイブリッド
		default:
			break
		}
	}
	
	// ジオコーディング
	func doGeocording(_ place: String) {
		
		// 設定（ジオコーディング処理）
		let hnd: CLGeocodeCompletionHandler = { (placemarks, error) in
			
			// 該当チェック
			guard let plc = placemarks else {
				NSLog("ない")
				return
			}
			
			// 地図の移動
			let lc = plc[0].location?.coordinate
			self.movePlace(place: lc!)
		}
		
		// ジオコーディング実行
		CLGeocoder().geocodeAddressString(
			place, completionHandler: hnd)
	}
	
	// 地図の移動
	func movePlace(place: CLLocationCoordinate2D) {
		
		// （表示領域の長さ（緯度差、経度差））
		let sp = MKCoordinateSpan(
			latitudeDelta: 0.01, longitudeDelta: 0.01)
		
		// （地域）
		let cr = MKCoordinateRegion(center: place, span: sp)

		mvMap.setRegion(cr, animated: true)
	}
}
