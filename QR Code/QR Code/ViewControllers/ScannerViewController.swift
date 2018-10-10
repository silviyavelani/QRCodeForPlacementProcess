//
//  ScannerViewController.swift
//  ScannerQuizDemo
//
//  Created by Silviya Velani on 31/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import AVFoundation

protocol  ScannerViewControllerDelegate : class {
    func getBarCodeReceive(fromCode code:String)
}

class ScannerViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate{

    //MARK:- Outlet
    
    @IBOutlet weak var scannerView: UIView!
    
    //MARK:- Object
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    public weak var delegate: ScannerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannerView.backgroundColor = UIColor.black
        prepareMethods()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCloseOnClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
    private func prepareMethods()
    {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let err {
            print(err)
            captureSession = nil
            return
        }
        
        
        guard let getVideoInput = videoInput else {
            captureSession = nil
            return
        }
        
        if let caputeObject = captureSession, (caputeObject.canAddInput(getVideoInput)) {
                caputeObject.addInput(getVideoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if let caputeObject = captureSession, (caputeObject.canAddOutput(metadataOutput)) {
            caputeObject.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        if let caputeObject = captureSession {
            previewLayer = AVCaptureVideoPreviewLayer(session: caputeObject)
            previewLayer?.frame = self.view.layer.bounds
            previewLayer?.videoGravity = .resizeAspectFill
            scannerView.layer.addSublayer(previewLayer!)
            
            caputeObject.startRunning()
        }
    }
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession?.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession?.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession?.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        self.dismiss(animated: true)
    }
    
    fileprivate func found(code: String) {
        print(code)
        delegate?.getBarCodeReceive(fromCode: code)
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    

}
