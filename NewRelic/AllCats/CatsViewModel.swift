//
//  CatsViewModel.swift
//  NewRelic
//
//  Copyright © 2022 newrelicchallenge. All rights reserved.
//

import Foundation

class CatsViewModel {
    // A manager class for the web call times
    let catTimeManager = CatsAPIResponseTimeManager()
    
    // Viarbles that will call a closure on update
    let cats: Variable<[CatDetail]> = Variable([])
    let error: Variable<Error?> = Variable(nil)

    let allCatsDownloaded: Variable<Bool> = Variable(false)

    func requestAllCats() {
        var pageNumber = 1
        requestMoreCats(pageNumber: &pageNumber)
    }

    private func requestMoreCats(pageNumber: inout Int) {
        // Get the time at the start of the web call
        let startTime = DispatchTime.now().uptimeNanoseconds
        var page = pageNumber
        
        let dataCallback = { [weak self] (result: (Result<[CatDetail], Error>), url: URL?) in
            guard let ourself = self else { return }
            
            if let theURL = url {
                ourself.addAPICallTime(startTime: startTime, url: theURL)
            }
            
            switch result {
            case .success(let cats):
                if ourself.catsRecieved(newCats: cats) {
                    // Iterate the page number
                    page += 1
                    // recursively call for more cats
                    ourself.requestMoreCats(pageNumber: &page)
                } else {
                    ourself.allCatsDownloaded.value = true
                }
            case .failure(let error):
                ourself.error.value = error
            }
            
        }

        CatFetcher.shared.loadCats(perPage: 30, page: page, queue: DispatchQueue.main, callback: dataCallback)
    }
    
    private func addAPICallTime(startTime: UInt64, url: URL) {
        // Get the elapsed time by suptrating the diference from startTime
        let elapsedNanoseconds = DispatchTime.now().uptimeNanoseconds - startTime
        let millisecond = round(Double(elapsedNanoseconds/1000000))
        // Add the new time to the times manager
        self.catTimeManager.times.append(APITimeObject(time: Millisecond(millisecond), url: url.absoluteString))
    }
    
    private func catsRecieved(newCats: [CatDetail]) -> Bool {
        // If we get no cats back from the call end the recursion
        if newCats.count == 0 {
            // Set that all the cats have been downloaded
            self.allCatsDownloaded.value = true
            return false
        }
        
        // Merge the new cats array into the existing incase of repeat
        let catArray = self.merge(first: self.cats.value, second: newCats)
        self.cats.value = catArray.sorted()
        return true
    }
    
    // A function to merge two CatDetail arrays
    func merge(first: [CatDetail], second: [CatDetail]) -> [CatDetail] {
        return Array(Set(second).union(first))
    }

}
