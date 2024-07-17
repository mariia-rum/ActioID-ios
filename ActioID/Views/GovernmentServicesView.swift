import SwiftUI


struct GovernmentServicesView: View {
    @StateObject private var viewModel = GovernmentServicesViewModel()
    @State private var path: [SubService] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Services")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                    .padding(.bottom, 4)

                List {
                    ForEach($viewModel.services.indices, id: \.self) { index in
                        ServiceCard(service: $viewModel.services[index])
                        if viewModel.services[index].isExpanded {
                            ServiceDetails(service: $viewModel.services[index], path: $path)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.white)
            }
            .onAppear {
                viewModel.fetchServiceRequests()
            }
            .navigationDestination(for: SubService.self) { subService in
                SubServiceDetailView(subService: subService, path: $path)
            }
        }
        .background(Color.white)
    }
}

// ServiceCard
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

// ServiceDetails
struct ServiceDetails: View {
    @Binding var service: Service
    @Binding var path: [SubService]

    var body: some View {
        VStack {
            Text(service.description)
                .padding()
                .background(Color.white)
            ForEach(service.subServices) { subService in
                NavigationLink(value: subService) {
                    SubServiceCard(subService: subService)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .shadow(radius: 2)
                        .padding(.vertical, 3)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

// SubServiceCard
struct SubServiceCard: View {
    let subService: SubService

    var body: some View {
        HStack {
            Text(subService.name)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.vertical, 3)
    }
}

// Previews
struct GovernmentServicesView_Previews: PreviewProvider {
    static var previews: some View {
        GovernmentServicesView()
    }
}
