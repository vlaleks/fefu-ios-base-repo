//
//  MainTableController.swift
//  fefuactivity
//
//  Created by иван on 16.12.2021.
//

import UIKit
import CoreData

class MainTableController: UIViewController {
   
    @IBAction func typeStartButton(_ sender: Any) {
        let ptr = self.storyboard?.instantiateViewController(identifier: "LockationTracking")
        ptr?.modalPresentationStyle = .fullScreen
        self.present(ptr! , animated: false)
    }
    
    
    @IBOutlet weak var table_with_activnosti: UITableView!
    let name_of_table_cell = "OneStatementInActivityTableViewCell";
    var data_for_table: [LocationData] = [];
    private let fefuCoreData = FEFUCoreDataContainer.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        table_with_activnosti.dataSource = self
        registerCell()
        fetchDataFromCoreData()
    }
    private func registerCell(){
        table_with_activnosti.register(UINib(nibName: name_of_table_cell , bundle: nil), forCellReuseIdentifier: name_of_table_cell)
    }
    
    private func formateDataForTable(item_from_data: CDUserActivitys){
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "MMM d, yyyy"
        
        if item_from_data.long_of_activity == 0 || item_from_data.end_date?.description ?? "Не найдено"
            == "Не найдено"{
            return;
        }
        var ptr: LocationData = LocationData()
        
        ptr.header_time_of_activnost = formatter.string(from: item_from_data.end_date!)
        
        ptr.long_way_of_activnosi = (round(
            item_from_data.long_of_activity * 1000) / 1000
        ).description + " км"
        ptr.how_time_ago = item_from_data.end_date?.description ?? "Не найдено"
        ptr.type_of_activnosti = item_from_data.type_of_activity ?? "Не выбран"
        ptr.long_time_of_activnosti = item_from_data.durationOfActivity ?? "??"
        
        data_for_table.insert(ptr, at: 0)
    }
    
    private func fetchDataFromCoreData(){
        let locate_request: NSFetchRequest<CDUserActivitys> = CDUserActivitys.fetchRequest()
        do {
            let rawActivity =
                try FEFUCoreDataContainer.instance.context.fetch(locate_request)
            if ( rawActivity.count != 0 ){
                for item in rawActivity {
                    formateDataForTable(item_from_data: item)
                }
            }
        } catch {
            print(error)
        }
    }
    
}


extension MainTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_for_table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: name_of_table_cell,
            for:indexPath
            ) as? OneStatementInActivityTableViewCell{
            
            cell.how_time_ago.text = data_for_table[indexPath.row].header_time_of_activnost
            
            cell.long_way_of_activnost.text = data_for_table[indexPath.row].long_way_of_activnosi
            
            cell.header_time_of_activnost.text = data_for_table[indexPath.row].header_time_of_activnost
            
            cell.long_time_of_activnosti.text = data_for_table[indexPath.row].long_time_of_activnosti
            
            cell.type_of_activnosti.text = data_for_table[indexPath.row].type_of_activnosti
            return cell
        } else {
            assert(false)
            return UITableViewCell()
        }
        
    }
    
    
}
