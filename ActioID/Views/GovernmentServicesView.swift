import SwiftUI

struct GovernmentServicesView: View {
    @StateObject private var viewModel = GovernmentServicesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Services")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                    .padding(.bottom, 4)

                List {
                    ForEach($viewModel.services.indices, id: \.self) { index in
                        Section {
                            ServiceCard(service: $viewModel.services[index])
                        }
                        if viewModel.services[index].isExpanded {
                            ServiceDetails(service: viewModel.services[index])
                        }
                    }
                    .listRowBackground(Color.white)
                    .padding(.horizontal, 10)
                }
                .listStyle(PlainListStyle())
                .background(Color.white)
            }
            .background(Color.white)
            .onAppear {
                viewModel.fetchServiceRequests()
            }
        }
        .background(Color.white)
    }
}

struct ServiceCard: View {
    @Binding var service: Service

    var body: some View {
        HStack {
            Text(service.name)
                .font(.headline)
            Spacer()
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    service.isExpanded.toggle()
                }
            }) {
                Image(systemName: service.isExpanded ? "minus" : "plus")
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.vertical, 3)
    }
}

struct ServiceDetails: View {
    let service: Service

    var body: some View {
        ForEach(service.subServices) { subService in
            NavigationLink(destination: SubServiceDetailView(subService: subService)) {
                SubServiceCard(subService: subService)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .padding(.vertical, 3)
            }
           
        }
        .padding(.horizontal)
    }
}

struct SubServiceCard: View {
    let subService: SubService

    var body: some View {
        HStack {
            Text(subService.name)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 2)
        .padding(.vertical, 3)
    }
}

struct GovernmentServicesView_Previews: PreviewProvider {
    static var previews: some View {
        GovernmentServicesView()
    }
}
