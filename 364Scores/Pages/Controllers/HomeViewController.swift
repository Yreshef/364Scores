//
//  HomeViewController.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Properties | Components
    
    @IBOutlet weak var tableView: UITableView!
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No teams to show"
        return label
    }()
    
    // MARK: - Properties | Variables
    
    private var interactor: FootballDataInteracting!
    private var subscriptions: Set<AnyCancellable> = []
    
    var teams: [Team] = [] {
        didSet {
            DispatchQueue.main.async {
                if self.teams.isEmpty {
                    self.tableView?.backgroundView = self.emptyLabel
                } else {
                    self.tableView?.backgroundView = nil
                }
                self.tableView?.reloadData()
                print("Reloaded table view!")
            }
            print("Array has changed! 😱😱😱")
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TeamSummaryCardCell.self,
                           forCellReuseIdentifier: TeamSummaryCardCell.cellID)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        fetchTeamsData()
        title = "364 Scores"
    }
    
    // MARK: - Methods
    
    static func create(interactor: FootballDataInteracting) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        vc?.interactor = interactor
        return vc
    }
    
    private func fetchTeamsData(){
        interactor.getAllTeams().sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                print("An error has occured: \(error)")
            }
        } receiveValue: { [weak self] response in
            self?.teams = response.teams ?? []
        }.store(in: &subscriptions)
    }
}

// MARK: - TableView Implementation

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamSummaryCardCell.cellID) as? TeamSummaryCardCell,
              teams.indices ~= indexPath.row else {
            assertionFailure("Failed to dequeue required TeamSummaryCell")
            return UITableViewCell()
        }
        let team = teams[indexPath.row]
        cell.setup(teamName: team.name ?? "N/A")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard teams.indices ~= indexPath.row else {
            return
        }
        let team = teams[indexPath.row]
        if let vc = TeamViewController.create(
            interactor: interactor,
            teamID: team.id) as? TeamViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

