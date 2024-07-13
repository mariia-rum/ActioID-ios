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
                        VStack(alignment: .leading, spacing: 0) {
                            ServiceCard(service: $viewModel.services[index])
                                .listRowBackground(Color.white)

                            if viewModel.services[index].isExpanded {
                                ServiceDetails(service: viewModel.services[index])
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.white)
            .onAppear {
                viewModel.fetchServiceRequests()
            }
        }
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
        .padding(.vertical, 2)
    }
}

struct ServiceDetails: View {
    let service: Service

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(service.description)
                .padding()
                .background(Color(.systemGray6))
            ForEach(service.subServices) { subService in
                NavigationLink(destination: SubServiceDetailView(subService: subService)) {
                    SubServiceCard(subService: subService)
                        .listRowBackground(Color.white)
                }
                .buttonStyle(PlainButtonStyle()) // Ensure no default button styling
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.vertical, 2)
        .transition(.opacity.combined(with: .slide))
        .animation(.easeInOut(duration: 0.3))
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
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding(.vertical, 2)
    }
}

struct GovernmentServicesView_Previews: PreviewProvider {
    static var previews: some View {
        GovernmentServicesView()
    }
}
