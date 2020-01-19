/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        List {
        VStack {
            MapView(coordinate: landmark.locationCoordinate, landmark: landmark)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 500)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(verbatim: landmark.name)
                        .font(.title)
                    
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex]
                            .isFavorite.toggle()
                    }) {
                        if self.userData.landmarks[self.landmarkIndex]
                            .isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                Text("Classrooms:")
                HStack(alignment: .top) {
                    Text(verbatim: landmark.park)
                        .font(.subheadline)
                    Spacer()
                    Text(verbatim: landmark.state)
                        .font(.subheadline)
                }
                 //Text("HH-123, HH-124, HH-125")
            }
           .padding()
           Spacer()
            .navigationBarTitle(Text("SDSU Campus"), displayMode: .inline)
            }
            NavigationLink(destination: Directions()) {
                Text("Get Directions").frame(maxWidth: .infinity, alignment: .center).foregroundColor(.red)
            }
        }
    }
}


struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LandmarkDetail(landmark: userData.landmarks[0])
            .environmentObject(userData)
    }
}
