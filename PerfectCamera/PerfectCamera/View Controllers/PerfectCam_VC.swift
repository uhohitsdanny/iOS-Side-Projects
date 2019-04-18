//
//  Main_VC.swift
//  PerfectCamera
//
//  Created by Danny Navarro on 1/18/19.
//  Copyright © 2019 Squirrel. All rights reserved.
//

import UIKit
import AVFoundation

class PerfectCam_VC: UIViewController {

    @IBOutlet weak var camView : UIView!
    @IBOutlet weak var btnView : UIView!
    @IBOutlet weak var camBtn : UIButton!
    
    var capSesh : AVCaptureSession!
    var stillImageOutput : AVCapturePhotoOutput!
    var videoPreviewLayer : AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.capSesh != nil
        {
            self.capSesh.startRunning()
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // MARK: Final Step - Clean up!
        self.capSesh.stopRunning()
    }

}

// MARK: - Setup Functions
extension PerfectCam_VC
{
    func setup()
    {
        setupUI()
        buttonSetup()
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.cameraSetup()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted
                {
                    self.cameraSetup()
                }
            }
        default:
            return
        }
    }
    
    func setupUI()
    {
        camBtn.layer.cornerRadius = camBtn.frame.width / 2
        btnView.layer.cornerRadius = btnView.frame.width / 2
    }
    
    func buttonSetup()
    {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(takePic))
        let longPressGest = UILongPressGestureRecognizer(target: self, action: #selector(recordVideo))
        tapGest.numberOfTapsRequired = 1
        self.camBtn.addGestureRecognizer(tapGest)
        self.camBtn.addGestureRecognizer(longPressGest)
    }
    
    func cameraSetup()
    {
        // MARK: Step 1
        // A Capture Session needs to be created
        // This API allows us to coordinate input and output
        // of the data
        capSesh = AVCaptureSession()
        capSesh.sessionPreset = .high
        
        // MARK: Step 2
        // Choose an input device (front camera, rear camera)
        guard let rearCam = AVCaptureDevice.default(for: .video)
        else
        {
            print("Unable to access rear camera")
            return
        }
        
        // MARK: Step 3
        // Configure the middleman(AVCaptureDeviceInput) and output
        // for attachment
        do
        {
            let input = try AVCaptureDeviceInput(device: rearCam)
            
            stillImageOutput = AVCapturePhotoOutput()
            
            // MARK: Step 4
            // Attaches the input and output of the device to the Capture Session
            if capSesh.canAddInput(input) && capSesh.canAddOutput(stillImageOutput)
            {
                capSesh.addInput(input)
                capSesh.addOutput(stillImageOutput)
                
                // MARK: Step 5
                // if camera is setup successfully,
                // Associate capture session with the video preview layer
                // Setup the video preview layer
                // The reason the attributes are video,e.g. videoGravity & videoOrientation,
                // is that even though we are taking a picture, the screen that allows you
                // to see before capturing is technically a video session.
                // Image capturing is essentially snapshotting the screen of a video layer
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: capSesh)
                
                // This will tell the video to resize its aspect ratio
                // when we change the view size for any reason
                videoPreviewLayer.videoGravity = .resize
                videoPreviewLayer.connection?.videoOrientation = .portrait
                // Add it to the sublayer of the view you are using
                camView.layer.addSublayer(videoPreviewLayer)
                // Setup is done! Now add it to the background thread and start it!
                // If the capture session is ran on main thread, UI would be blocked
                DispatchQueue.global(qos: .userInitiated).async
                {
                    self.capSesh.startRunning()
                    
                    // Now we actually size the video preview layer to the view
                    // because video gravity is set, the framework will automatically
                    // scale the live video when changinge the layer size
                    // Since we are changing frames, which is a UI change, we need to
                    // go into the main thread.
                    DispatchQueue.main.async
                    {
                        self.videoPreviewLayer.frame = self.camView.bounds
                    }
                    // The live video preview is now ready, and the camera input/output is
                    // connected to a capture session.  Now, we can take some pictures!
                }
            }
        }
        catch
        {
            print("Unable to initialize rear camera: \(error.localizedDescription)")
        }
    }
}

// MARK: - Button Functions
extension PerfectCam_VC : AVCapturePhotoCaptureDelegate
{
    @objc func takePic()
    {
        print("""
                Action: taking picture

                Using new Multi-line system
                """)
        // Set the photo format to JPEG
        // AVVideoCodecKey is a string that will tell the settings that
        // we want to change the video codec
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        
        // The delegate function photoOutput will process the captured data
    }
    
    @objc func recordVideo()
    {
        print("Action: recording video")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // MARK: Step 7
        // Process the captured data!
        guard let imgData = photo.fileDataRepresentation()
        else{   return  }
        
        let image = UIImage(data: imgData)
        // Display in an ImageView!
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CaptureOutput_VC") as! CaptureOutput_VC
        vc.setImageView(with: image!)
        self.present(vc, animated: true, completion: nil)
    }
}
