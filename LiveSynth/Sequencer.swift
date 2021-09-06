//
//  Sequencer.swift
//  LiveSynth
//
//  Created by Serena on 11/15/18.
//  Copyright © 2018 Serena. All rights reserved.
//

import AudioKit

//var samplerSeqKick: AKMIDISampler!
//var trackKick: AKMusicTrack!

open class SequencerKick {
    
    var sequencerKick: AKSequencer!
    

    init() {
        
        
        
        let samplerSeqKick = AKMIDISampler()
        try? samplerSeqKick.loadWav("Dub Smashkick")
        
    
        AudioKit.output = samplerSeqKick
        
        
        trackKick = sequencerKick.newTrack()
        sequencerKick.enableLooping(AKDuration(beats:8))
       
        sequencerKick.setGlobalMIDIOutput(samplerSeqKick.midiIn)
 
        
        try!AudioKit.start()
        sequencerKick.play()
    }
}
