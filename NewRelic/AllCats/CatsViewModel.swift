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
    let allCatsDownloaded: Variable<Bool> = Variable(false)

    func requestAllCats() {
        var pageNumber = 1
        requestMoreCats(pageNumber: &pageNumber)
    }

    private func requestMoreCats(pageNumber: inout Int) {
        // Get the time at the start of the web call
        let startTime = DispatchTime.now().uptimeNanoseconds
        var page = pageNumber

        let dataCallback = { [weak self] (cats: CatResult?) in
            guard let cats = cats, let ourself = self else { return }
            
            // Get the elapsed time by suptrating the diference from startTime
            let elapsedNanoseconds = DispatchTime.now().uptimeNanoseconds - startTime
            let millisecond = round(Double(elapsedNanoseconds/1000000))
            // Add the new time to the times manager
            ourself.catTimeManager.times.append((Millisecond(millisecond)))
            
            // If we get no cats back from the call end the recursion
            if cats.data.count == 0 {
                // Set that all the cats have been downloaded
                ourself.allCatsDownloaded.value = true
                return
            }
            
            DispatchQueue.main.async {
                // Merge the new cats array into the existing incase of repeat
                let catArray = ourself.merge(first: ourself.cats.value, second: cats.data)
                ourself.cats.value = catArray.sorted()
                // Iterate the page number
                page += 1
                // recursively call for more cats
                ourself.requestMoreCats(pageNumber: &page)
            }
        }
        CatFetcher.shared.loadCats(perPage: 30, page: page, queue: DispatchQueue.main, callback: dataCallback)
    }
    
    // A function to merge two CatDetail arrays
    func merge(first: [CatDetail], second: [CatDetail]) -> [CatDetail] {
        return Array(Set(second).union(first))
    }

}
