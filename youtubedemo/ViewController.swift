import UIKit
import WebKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var youtubeView: WKWebView!
    
    @IBOutlet weak var archiveTable: UITableView!
    
    var archiveItems: [ArchiveItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadYoutubeVDO()
        
        archiveItems.append(ArchiveItem(youtubeID: "kUFZdxN7psA", companyEN: "WHA"))
        archiveItems.append(ArchiveItem(youtubeID: "8mUV0PW4krs", companyEN: "IRPC"))
        
        archiveTable.dataSource = self
    }
    
    private func loadYoutubeVDO() {
        let request = URLRequest(url: URL( string: "https://www.youtube.com/embed/kUFZdxN7psA")!)
        youtubeView.load(request)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archiveItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ArchiveTableViewCell = tableView.dequeueReusableCell(withIdentifier: "archiveCell")! as! ArchiveTableViewCell
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageUrl = URL(string: "https://img.youtube.com/vi/\(self.archiveItems[indexPath.row].youtubeID)/0.jpg")
            
            if let imageData = NSData(contentsOf: imageUrl!),
                let loadedImage = UIImage(data: imageData as Data) {
                DispatchQueue.main.async {
                    cell.thumbnail.image = loadedImage
                }
            }
            
        }
        
        cell.company.text = archiveItems[indexPath.row].companyEN
        
        return cell
    }
}

