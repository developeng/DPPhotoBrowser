//
//  ViewController.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/4.
//

import UIKit

class ViewController: UIViewController {
    
    var imgV:UIImageView!
    var imgV2:UIImageView!
    var imgV3:UIImageView!
    var imgV4:UIImageView!
    var imgV5:UIImageView!
   lazy  var tableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 100, width: 350, height: 300), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 0;
        tableView.sectionFooterHeight = 0;
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView;
    }()
    
    
    lazy var localImgArr:Array<String> = {
        
        var arr:Array<String> = []
        arr.append("001")
        arr.append("002")
        arr.append("003")
        arr.append("004")
        arr.append("005")
        return arr
    }()
    
    lazy var internetImgArr:Array<String> = {
        var arr:Array<String> = []
        arr.append("http://img.jj20.com/up/allimg/911/121215132T8/151212132T8-1-lp.jpg")
        arr.append("http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1396940684766.jpg")
        arr.append("http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1394701139813.jpg")
        arr.append("http://img.jj20.com/up/allimg/911/0P315132137/150P3132137-1-lp.jpg")
        arr.append("http://b.zol-img.com.cn/sjbizhi/images/1/208x312/1350915106394.jpg")
        return arr
    }()
    
    lazy var imgArr:Array<UIImage> = {
        var arr:Array<UIImage> = []
        arr.append(UIImage(named: "001")!)
        arr.append(UIImage(named: "002")!)
        arr.append(UIImage(named: "003")!)
        arr.append(UIImage(named: "004")!)
        arr.append(UIImage(named: "005")!)
        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.frame
        
        self.tableView.register(DemoTableViewCell.classForCoder(), forCellReuseIdentifier: "DemoTableViewCell")
        self.tableView.register(DemoIITableViewCell.classForCoder(), forCellReuseIdentifier: "DemoIITableViewCell")
    }
    
    @objc func tapSingleClick(tap:UITapGestureRecognizer){
        
        DPPhotoBrowser.showPhotos(imgArr: ["001","002","003","004","005"],superView: imgV.superview!,selectIndex: 0)
    }
    
    @objc func tapSingleClick2(tap:UITapGestureRecognizer){
        
//        DPPhotoBrowser.showPhotos(imgArr: [UIImage(named: "001") as Any,UIImage(named: "002") as Any,UIImage(named: "003") as Any,UIImage(named: "004") as Any,UIImage(named: "005") as Any],selectIndex: 1)
    }
    
    @objc func tapSingleClick3(tap:UITapGestureRecognizer){
        
//        DPPhotoBrowser.showPhotos(imgArr: ["http://img.jj20.com/up/allimg/911/121215132T8/151212132T8-1-lp.jpg","http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1396940684766.jpg","http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1394701139813.jpg","http://img.jj20.com/up/allimg/911/0P315132137/150P3132137-1-lp.jpg","http://b.zol-img.com.cn/sjbizhi/images/1/208x312/1350915106394.jpg"],selectIndex: 2)
    }
    
    @objc func tapSingleClick4(tap:UITapGestureRecognizer){
        
//        DPPhotoBrowser.showPhotos(imgArr: ["001","002","003","004","005"],selectIndex: 3)
    }
    
    @objc func tapSingleClick5(tap:UITapGestureRecognizer){
        
//        DPPhotoBrowser.showPhotos(imgArr: ["001","002","003","004","005"],selectIndex: 4)
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:DemoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as! DemoTableViewCell
            cell.imgArr = self.localImgArr
            return cell
            
        }
        let cell:DemoIITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DemoIITableViewCell", for: indexPath) as! DemoIITableViewCell
        if indexPath.row == 1 {
            cell.imgArr = self.imgArr
        } else {
            cell.imgArr = self.internetImgArr
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

