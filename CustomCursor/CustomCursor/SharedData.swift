//
//  SharedData.swift
//  CustomCursor
//
//  Created by 박병호 on 5/31/24.
//

import Foundation

struct EffectRingInfo : Encodable, Decodable  {
    var ringRadius : CYCLE_RING_RADIUS
    var ringLineWidth : CGFloat
    var ringLineAlpha : CGFloat
}

class SharedData {
    static let sharedData = SharedData()
    var effectRingInfo : EffectRingInfo!
    
    private init() {
        print("[SharedData] private init")
        self.loadData()
    }
    
    func loadData(){
        print("[SharedData] loadData")
        
        if let savedData = UserDefaults.standard.object(forKey: "EffectRingInfo") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(EffectRingInfo.self, from: savedData) {
                print(savedObject) // Person(name: "jake", age: 20)
                effectRingInfo = savedObject
            }
        }else{
            print("[SharedData] load data init")
            
            effectRingInfo = EffectRingInfo.init(ringRadius: CYCLE_RING_RADIUS.MIDDLE, ringLineWidth: DEFAULT_RING_LINE_WIDTH, ringLineAlpha: DEFAULT_RING_LINE_ALPHA)
        }
    }
    
    func saveData(){
        print("[SharedData] saveData")
        
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(effectRingInfo) {
            UserDefaults.standard.setValue(encoded, forKey: "EffectRingInfo")
        }
    }
    
    func removeData(){
        
    }
}