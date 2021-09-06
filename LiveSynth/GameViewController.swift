//
//  GameViewController.swift
//  LiveSynth
//
//  Created by Serena on 11/9/18.
//  Copyright © 2018 Serena. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioKit
import AudioKitEX


class GameViewController: UIViewController {

    //Declarations of variable for the sequencer and samplers
    
    var sampler: MIDISampler!
    
    //Drums
    
    var samplerSeqKick:    MIDISampler!
    var samplerSeqSnare:    MIDISampler!
    var samplerSeqHat:    MIDISampler!
    var samplerSeqClap:    MIDISampler!
    
    // Drum tracks
    
    var trackKick: MusicTrackManager!
    var trackSnare: MusicTrackManager!
    var trackHat: MusicTrackManager!
    var trackClap: MusicTrackManager!
    
    //Drum Sequencers
    
    var sequencerKick: AppleSequencer!
    var sequencerSnare: AppleSequencer!
    var sequencerHat: AppleSequencer!
    var sequencerClap: AppleSequencer!
    
    //Bass
    
    var samplerSeqBass:    MIDISampler!
    
    //Bass Track
    
    var trackBass:    MusicTrackManager!
    
    //Bass Sequencer
    
    var sequencerBass:    AppleSequencer!
    
    var mixer:    Mixer!
    
    //Post Effects
    var delay:    Delay!
    var reverb:    Reverb!

    //Labels for Sliders
    @IBOutlet weak var delayTimeLabel: UILabel!
    @IBOutlet weak var delayFeedbackLabel: UILabel!
    @IBOutlet weak var delayDryWetMixLabel: UILabel!
    @IBOutlet weak var reverbDryWetMixLabel: UILabel!
    @IBOutlet weak var BPMLabel: UILabel!
    
    let engine = AudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Loading the game scene graphics into the main view controller
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            
        }
        
        //loading in the innitial smapler sound
        
        sampler =    MIDISampler()
        try? sampler.loadWav("Piano")
        try? engine.start()
        
        
        //Loading in the sampler sounds(in Wav format) for Drums and bass
        
        //kick
        samplerSeqKick =    MIDISampler()
        try? samplerSeqKick.loadWav("Dub Smashkick")
        
        //snare
        samplerSeqSnare =    MIDISampler()
        try? samplerSeqSnare.loadWav("Dub Smashsnare")
        
        //Hat
        samplerSeqHat =    MIDISampler()
        try? samplerSeqHat.loadWav("Dub SmashoHH")
        
        //Clap
        samplerSeqClap =    MIDISampler()
        try? samplerSeqClap.loadWav("909ClapV1_X")

        //Bass
        samplerSeqBass =    MIDISampler()
        try? samplerSeqBass.loadWav("Bass")
        
        
        //Establishing sequencers for Drums and bass
        
        //Kick
        sequencerKick =    AppleSequencer()
        //creating an instance of track, which is used to add sounds to the sequencer
        trackKick = sequencerKick.newTrack()
        //Setting the duration of the sequencer
        sequencerKick.enableLooping(   Duration(beats:8))
        sequencerKick.setGlobalMIDIOutput(samplerSeqKick.midiIn)
        
        //Snare
        sequencerSnare =    AppleSequencer()
        //creating an instance of track, which is used to add sounds to the sequencer
        trackSnare = sequencerSnare.newTrack()
        sequencerSnare.enableLooping(   Duration(beats:8))
        sequencerSnare.setGlobalMIDIOutput(samplerSeqSnare.midiIn)
        
        //Hat
        sequencerHat =    AppleSequencer()
        //creating an instance of track, which is used to add sounds to the sequencer
        trackHat = sequencerHat.newTrack()
        sequencerHat.enableLooping(   Duration(beats:8))
        sequencerHat.setGlobalMIDIOutput(samplerSeqHat.midiIn)
        
        //Clap
        sequencerClap =    AppleSequencer()
        //creating an instance of track, which is used to add sounds to the sequencer
        trackClap = sequencerClap.newTrack()
        sequencerClap.enableLooping(   Duration(beats:8))
        sequencerClap.setGlobalMIDIOutput(samplerSeqClap.midiIn)
        
        //Bass
        sequencerBass =    AppleSequencer()
        //creating an instance of track, which is used to add sounds to the sequencer
        trackBass = sequencerBass.newTrack()
        //Setting the duration of the sequencer
        sequencerBass.enableLooping(   Duration(beats:8))
        sequencerBass.setGlobalMIDIOutput(samplerSeqBass.midiIn)
    
        //Using thge mixer variable to send all the sampler sounds into one channel
        mixer =    Mixer(sampler,samplerSeqKick,samplerSeqSnare, samplerSeqHat, samplerSeqClap, samplerSeqBass)
        mixer.volume = 0.5
        
        //sending the mixer to the delay for post sound effects
        delay =    Delay(mixer)
        
        //Setting all initial delay values to 0
        delay.time = 0.0
        delay.feedback = 0.0
        delay.dryWetMix = 0.0
        
        //sending the delay to the reverb for post sound effects
        reverb =    Reverb(delay)
        reverb.dryWetMix = 0.0
        
        //Sending the reveb to the output to be played
        engine.output = reverb
        try? engine.start()
        
        //Play all sequencers
        sequencerKick.play()
        sequencerSnare.play()
        sequencerHat.play()
        sequencerClap.play()
        sequencerBass.play()
        
    }

    //Slider used to change the time of the delay which will be shown in the label beside the slider
    @IBAction func delayTime(_ sender: UISlider) {
        
        delay.time = AUValue(Double(sender.value))
        delayTimeLabel.text = String(format: "%0.2f", delay.time)
    }
    
    //Slider used to change the feedback of the delay which will be shown in the label beside the slider
    @IBAction func delayFeedback(_ sender: UISlider) {
        
        delay.feedback = AUValue(Double(sender.value))
        delayFeedbackLabel.text = String(format: "%0.2f", delay.feedback)
        
    }
    
    //Slider used to change the drywetmix of the delay which will be shown in the label beside the slider
    @IBAction func delayDryWetMix(_ sender: UISlider) {
        
        delay.dryWetMix = AUValue(Double(sender.value))
        delayDryWetMixLabel.text = String(format: "%0.2f",  delay.dryWetMix)
        
    }
    
    //Slider used to change the amount(drywetmix) of the reverb(depending on which factory preset has been chosen) which will be shown in the label beside the slider
    @IBAction func reverbAmount(_ sender: UISlider) {
        
        reverb.dryWetMix = AUValue(Double(sender.value))
        reverbDryWetMixLabel.text = String(format: "%0.2f",  reverb.dryWetMix)
    }
    
   
    //Buttons and case statements used to change the depth/size of the reverb which are depended upon the factory preset
    @IBAction func reverbFactoryPreset(_ sender: UIButton) {
           switch (sender.tag) {
           case 1:
            reverb.loadFactoryPreset(.smallRoom)
           case 2:
            reverb.loadFactoryPreset(.mediumRoom)
           case 3:
            reverb.loadFactoryPreset(.largeRoom)
           case 4:
            reverb.loadFactoryPreset(.mediumChamber)
           case 5:
            reverb.loadFactoryPreset(.largeChamber)
           case 6:
            reverb.loadFactoryPreset(.cathedral)
           default:
                print("not working")
        }
    }
    
    //Sider that will change the mixer volume value
    @IBAction func masterVolume(_ sender: UISlider) {
        
        mixer.volume = AUValue(Double(sender.value))
    
    }
    
    //Buttons that allow the user to change the keyboard sample from the preset sounds
    @IBAction func changeSampleButton(_ sender: UIButton) {

        switch (sender.tag) {
            
        case 1:
             sampler.amplitude = 0.0
             try? sampler.loadWav("Piano")
        case 2:
             sampler.amplitude = 0.0
             try? sampler.loadWav("Synth")
        case 3:
            sampler.amplitude = 0.0
            try? sampler.loadWav("Guitar")
        default:
             print("not working")
        }
    }
    //Buttons that respond to touch from the user and produce the sampler sounds within a 2ve range
    @IBAction func buttonPressed(_ sender: UIButton) {
    
        var note: MIDINoteNumber = 0
        print(sender.tag)
        switch (sender.tag) {
            
        case 1: note = 60
        case 2: note = 61
        case 3: note = 62
        case 4: note = 63
        case 5: note = 64
        case 6: note = 65
        case 7: note = 66
        case 8: note = 67
        case 9: note = 68
        case 10: note = 69
        case 11: note = 70
        case 12: note = 71
        case 13: note = 72
        case 14: note = 73
        case 15: note = 74
        case 16: note = 75
        case 17: note = 76
        case 18: note = 77
        case 19: note = 78
        case 20: note = 79
        case 21: note = 80
        case 22: note = 81
        case 23: note = 82
        case 24: note = 83
        default:
            print("not working")
        }
        try! sampler.play(noteNumber: note, velocity: 127, channel: 0)
    }
    
    //Making sure that the sample sound stops after the user releases the key
    @IBAction func buttonReleased(_ sender: UIButton) {
        sampler.amplitude = 0.0
        
    }
    
 //The following sequencers buttons use 8 cases (1 for each square in the sequencer, this allows the user to switch on a beat in a specific part of the sequencer
 //All velocities are set to be the same for balance in the sound
    
    //Kick
    @IBAction func buttonPressedKick(_ sender: UIButton) {
        switch (sender.tag) {
            
        case 1:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
        trackKick?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
        }
    }
    
    //Snare
    @IBAction func buttonPressedSnare(_ sender: UIButton) {
        switch (sender.tag) {
                
        case 1:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackSnare?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
            }
        }
    
    //Hat
    @IBAction func buttonPressedHat(_ sender: UIButton) {
        switch (sender.tag) {
                    
        case 1:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackHat?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
                }
        }
    
    //Clap
    @IBAction func buttonPressedSeqClap(_ sender: UIButton) {
        switch (sender.tag) {
                
        case 1:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackClap?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
            }
    }
    
    //C
    @IBAction func buttonPressedBassC(_ sender: UIButton) {
        switch (sender.tag) {
            
        case 1:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 60, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
                
            }
}
    //D
    @IBAction func buttonPressedBassD(_ sender: UIButton) {
        switch (sender.tag) {
                
        case 1:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 62, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
                
            }
        }
//E
    @IBAction func buttonPressedSeqBassE(_ sender: UIButton) {
        switch (sender.tag) {
                
        case 1:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 64, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
                
            }
        }
  //F
    @IBAction func buttonPressedBassF(_ sender: UIButton) {
        switch (sender.tag) {
            
        case 1:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 65, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
            
        }

    }
   //G
    @IBAction func buttonPressedSeqBassG(_ sender: UIButton) {
        switch (sender.tag) {
            
        case 1:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 67, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
            
        }
    }
       //A
    @IBAction func buttonPressedBassA(_ sender: UIButton) {
        switch (sender.tag) {
                
        case 1:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 69, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
                
            }
    }
    
    //B
    @IBAction func buttonPressedSeqBassB(_ sender: UIButton) {
        switch (sender.tag) {
            
        case 1:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 71, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
            
        }
    }
    
    //B
    @IBAction func buttonPressedBassCve(_ sender: UIButton) {
        switch (sender.tag) {
                
        case 1:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:1), duration:    Duration(beats:1))
        case 2:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:2), duration:    Duration(beats:1))
        case 3:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:3), duration:    Duration(beats:1))
        case 4:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:4), duration:    Duration(beats:1))
        case 5:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:5), duration:    Duration(beats:1))
        case 6:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:6), duration:    Duration(beats:1))
        case 7:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:7), duration:    Duration(beats:1))
        case 8:
            trackBass?.add(noteNumber: 72, velocity: 127, position:    Duration(beats:8), duration:    Duration(beats:1))
        default:
            print("not working")
                
            }
    }
    
    // These buttons allow the users sequencer creation to be cleared and started again.
    
    //Kick
    @IBAction func clearKick(_ sender: UIButton) {
        trackKick.clear()
    }
    
    //Snare
    @IBAction func clearSnare(_ sender: UIButton) {
        trackSnare.clear()
    }
    
    //Hat
    @IBAction func clearHat(_ sender: UIButton) {
        trackHat.clear()
    }
    
    //Clap
    @IBAction func clearClap(_ sender: UIButton) {
        trackClap.clear()
    }
    
    //Bass
    @IBAction func clearBass(_ sender: UIButton) {
        trackBass.clear()
    }
    
    //This button will set the tempo of each sequencer to be the same, then allow the user to change it.
   @IBAction func seqBPM(_ sender: UISlider) {
        sequencerKick.setTempo(Double(sender.value))
        sequencerSnare.setTempo(Double(sender.value))
        sequencerHat.setTempo(Double(sender.value))
        sequencerClap.setTempo(Double(sender.value))
        sequencerBass.setTempo(Double(sender.value))
        print(sequencerKick.tempo)
        BPMLabel.text = String(format: "%0.2f", sequencerKick.tempo)
    
    }
    
    

}


