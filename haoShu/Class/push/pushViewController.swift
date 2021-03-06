//
//  pushViewController.swift
//  haoShu
//
//  Created by x on 17/7/12.
//  Copyright © 2017年 cesiumai. All rights reserved.
//

import UIKit

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var dataSource = NSMutableArray()
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.setNavigationBar()
        
        tableView = UITableView.init(frame: self.view.frame)
        
        tableView?.tableFooterView = UIView()
        
        tableView?.delegate = self

        tableView?.dataSource = self
        
        tableView?.register(PushBookCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView!)
        
        tableView?.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pushViewController.headerRefresh))
        
        tableView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(pushViewController.footerRefresh))
        
//        tableView?.mj_footer.beginRefreshing()
        self.footerRefresh()
    
    }
 
    
    func setNavigationBar() {
        
        
        let navigationView = UIView.init(frame: CGRect(x: 0,y: -20,width:SCREEN_WIDTH,height: 65))
        
        navigationView.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton.init(frame: CGRect(x: 20,y: 20,width: SCREEN_WIDTH,height: 45))
        
        addBookBtn.setImage(UIImage.init(named: "plus circle"), for: .normal)
        
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        
        addBookBtn.setTitle("    新建书评", for: .normal)
        
        addBookBtn.titleLabel?.font = UIFont.init(name: MY_FONT, size: 15)
        
        addBookBtn.contentHorizontalAlignment = .left
        
        addBookBtn.addTarget(self, action: #selector(pushViewController.pushNewBook), for: .touchUpInside)
        
         
        navigationView.addSubview(addBookBtn)
       
        
        
    }

    func pushNewBook() {
        
        let vc = pushNewBookController()
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    //!< 下拉刷新，上拉加载
    func headerRefresh(){
        
        let query = AVQuery.init(className: "Book")
        
        query.order(byDescending: "createdAt")
        
        query.limit = 20
        
        query.skip = 0
        
        query.whereKey("user", equalTo: AVUser.current()!)
        
        query.findObjectsInBackground { (result, error)
            in
            
            self.tableView?.mj_header.endRefreshing()
            
            self.dataSource.removeAllObjects()
            
            self.dataSource.addObjects(from: result!)
            
            self.tableView?.reloadData()
            
            
        }
        
        
        
        
    }
    
    func footerRefresh(){
        
        let query = AVQuery.init(className: "Book")
        
        query.order(byDescending: "createdAt")
        
        query.limit = 20

        query.skip = self.dataSource.count
        
        query.whereKey("user", equalTo: AVUser.current()!)
        
        query.findObjectsInBackground { (result, error) in

            self.tableView?.mj_footer.endRefreshing()
            
            self.dataSource.addObjects(from: result!)
            
            self.tableView?.reloadData()
        
            
        }
        
    }
    
    //!< tableView 代理方法
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PushBookCell
        
      
        let dict = self.dataSource[indexPath.row] as? AVObject
        
        cell?.BookName?.text = "《" + (dict?["BookName"] as? String)! + "》:" + (dict!["title"] as! String)
        
        cell?.Editor?.text = "作者" + (dict?["BookEditor"] as! String)
        
        let date  = dict?["cratedAt"] as! NSDate
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy-MM-dd HH:mm"
        
        cell?.more?.text = format.string(from: date as Date)
        
        let coverFile = dict!["cover"] as? AVFile
        
        let image = UIImage.init(named: "Cover")
        
        let url = NSURL.init(string: (coverFile?.url!)!)
        
//        cell?.cover.sd
        
        cell?.cover?.sd_setImage(with: url! as URL, placeholderImage: image!)
     
        
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did click at section\(indexPath.section),row\(indexPath.row)")
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
