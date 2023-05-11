//
//  ContentView.swift
//  Day62-Project13-Instafilter
//
//  Created by Emre Gemici on 4.05.2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image : Image?
    @State private var inputImage : UIImage?
    
    @State private var filterIntentsity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterAngle  = 0.0
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var checkingImageSaver = false
    @State private var showingRadiusSlider = false // Challenge 2
    @State private var showingAngleSlider = false // Challenge 3
    
    @State private var processedImage: UIImage?
    @State private var currentFilter : CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to Select A Picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                    
                }
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntentsity)
                        .onChange(of: filterIntentsity){ _ in applyProcessing()
                        }
                }
                .padding(.vertical)
                
                if showingRadiusSlider {
                    HStack{
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius){ _ in applyProcessing()
                        }
                    }
                    .padding(.vertical)
                }
                if showingAngleSlider {
                    HStack{
                        Text("Angle")
                        Slider(value: $filterAngle)
                            .onChange(of: filterAngle){ _ in applyProcessing()
                        }
                    }
                    .padding(.vertical)
                }
                
                HStack{
                    Button("Change Filter"){
                        showingFilterSheet = true
                        showingRadiusSlider = false
                        showingAngleSlider = false
                    }
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(checkingImageSaver == false)
                }
            }
            .padding([.horizontal,.bottom])
            .navigationTitle("InstaFilter")
            .sheet(isPresented: $showingImagePicker){
                    ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage){ _ in loadImage()}
            .confirmationDialog("Select a Filter", isPresented: $showingFilterSheet){
                
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                //Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Box Blur") {setFilter(CIFilter.boxBlur())}
                Button("Color Matrix") {setFilter(CIFilter.colorMatrix())}
                Button ("Circular Wrap") {setFilter(CIFilter.circularWrap())}
                Button("Cancel", role: .cancel) { }
                // confirmationDialog can't allow to use button more 10 Buttons.
            }
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    func save(){
        guard let processedImage = processedImage else { return }
        let imageServer = ImageSaver()
        imageServer.successHandler = {
            print("Success!")
        }
        imageServer.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        imageServer.writeToPhotoAlbum(image: processedImage)
        
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){currentFilter.setValue(filterIntentsity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
            showingRadiusSlider = true
        }
        if inputKeys.contains(kCIInputScaleKey){ currentFilter.setValue(filterIntentsity * 10, forKey: kCIInputScaleKey )}
        if inputKeys.contains(kCIInputAngleKey){ currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey)}
            
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    func setFilter (_ filter: CIFilter){
        currentFilter = filter
        loadImage()
        
        checkingImageSaver = true // Challenge 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
