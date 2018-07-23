//
//  ViewController.swift
//  DemoWikiSearch
//
//  Created by Bharat Byan on 22/07/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var resultsArray: [Page]  = [Page]()
    var selectedPage :Page?
    @IBOutlet weak var txtFSearchText: UITextField!
    @IBOutlet weak var tblWiki: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func actBtnAPI(_ sender: UIButton) {
        hideKeyBoard()
        restAPICall()
    }
    
    func restAPICall(){
        APIManager.sharedInstance.callWikiAPI(searchText: txtFSearchText.text!, onSuccess: { jsonDict in
            
            self.resultsArray.removeAll()
            for each in jsonDict["query"]["pages"]{
                let pageObj = Page(obj: each.1)
                self.resultsArray.append(pageObj)
            }
            
            DispatchQueue.main.async {
                self.tblWiki.reloadData()
            }
            
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hideKeyBoard()
        super.touchesBegan(touches, with: event)
    }
    
    func hideKeyBoard(){
        txtFSearchText.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "idWikiWebViewController" {
            let vc = segue.destination as? WikiWebViewController
            vc?.selectedPageId = self.selectedPage?.pageid?.stringValue
            vc?.pagetitle = self.selectedPage?.title
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWikiSearch") as? WikiSearchTableViewCell
        
        if let cell = cell{
            
            let currentPage : Page = resultsArray[indexPath.row]
            
            if (currentPage.thumbnail != nil) {
                cell.imgThumbnail.downloadedFrom(url: currentPage.thumbnail!)
            }else{
                cell.imgThumbnail.image = UIImage(named: "img_no_thumb")
            }
            
            cell.lblTitle.text = currentPage.title!
            
            if let desc = currentPage.description {
                
                cell.lblDescription.text = desc
            }
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPage = resultsArray[indexPath.row] as Page
        self.performSegue(withIdentifier: "idWikiWebViewController", sender: self)
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyBoard()
        return false
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
